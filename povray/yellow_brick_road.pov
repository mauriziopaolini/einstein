/*
 * sullo stile di "sorvolo" si percorre il worm semiinfinito che si ottiene
 * per deflazione a partire da un H7
 * H7 = 0, H8 = 1
 *
 * clock is in seconds
 */
/*
#finalclock 11
#numseconds 110
#durata 115
#coda 5
#titolo 5
 */

#version 3.7;

global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "subdivision.inc"
#include "ambiente.inc"
#include "yellow_brick_road_include.inc"

#ifndef (preambletime) #declare preambletime = 4; #end
#declare endtime = 10000;

#declare time = clock;

#if (clock >= preambletime)
  #declare time = clock - preambletime;
#end

#declare yellowroadstart = <0,0,0>;
/*
 * this is the end of the worm in case depth=5
 */
#declare yellowroadend = <-775.5, 0, 200.051868>;
#declare yellowroaddir = vnormalize(yellowroadend - yellowroadstart);
//#declare yellowroaddirrot90 = vtransform (yellowroaddir, -90*y);

#ifndef (dorothyspeed) #declare dorothyspeed = 4; #end

#declare meters = 10;

//#declare behind = -1*meters*yellowroaddir + 1*meters*y;
#declare behind = -6*meters*yellowroaddir + 2*meters*y;
#declare ahead = 4*meters*yellowroaddir;
#declare dorothystartpos = yellowroadstart;
#declare lookatpos = yellowroadstart + ahead;
#declare faraway = yellowroadstart - 40*meters*yellowroaddir + 10*meters*y;
#declare textfont = "LiberationMono-Regular.ttf"

#declare eyeshift = 0*x;
#declare skycam = y;
#declare dorothypos = dorothystartpos;

#ifndef (depth) #declare depth = 5; #end
#ifndef (htile) #declare htile = 8; #end

build_wormAB (depth)

/*
 * se non ho sbagliato i conti Dorothy impiega 0.7 secondi per avanzare di un
 * cluster, avanzando a velocita' 4
 */

//#declare bricks_speed = 0.7/4*dorothyspeed*(138/133)*(144.5/146.763158)*(144.5/144.523131); // adjusted may 25, 2023
#declare bricks_speed = 0.7/4*dorothyspeed*1.021430283490544; // adjusted may 25, 2023

#ifdef (debug)
  #debug concat ("wormB[depth] = ", wormB[depth], "\n")
  #debug concat ("  last element: ", substr(wormB[depth], 144, 1), "\n")
#end

#declare h7worm = union {
  h7list (<1,1,0>, <1,0.5,0>, <1,0.6,0.2>)
  texture {finish {tile_Finish}}
}

#declare h8worm = union {
  h8list (<1,1,0>, <0.5,1,0>, <0.6,1,0.2>)
  texture {finish {tile_Finish}}
} 

#declare MaxPosLeft = <0,0,0>;

#if (htile = 7)
  h7rec (transform {scale 1.0}, depth)
  #declare onlyworm = 1;
  h7rec (transform {scale 1.0 + h*y}, depth)
#else
  h8rec (transform {scale 1.0}, depth)
  #declare onlyworm = 1;
  h8rec (transform {scale 1.0 + h*y}, depth)
#end

#debug concat ("MaxPosLeft.x = ", str(MaxPosLeft.x,0,-1), "\n")
#debug concat ("MaxPosLeft.z = ", str(MaxPosLeft.z,0,-1), "\n")
/*
 * this gives <-775.5, 0, 200.051868> for depth = 5
 */

#ifdef (augmented)
  #declare historythickness = 0.1;
  #declare raythickness = 0.07;
  #declare axisthickness = 0.06;
  #declare textinfo = "";
  #declare bricktype = "?"
#end

#switch (clock)
  #range (0,preambletime)
    #declare smoothtime = smoothp(clock/preambletime).x;
    #declare camerapos = (1-smoothtime)*faraway + smoothtime*dorothystartpos + behind;
    #debug concat ("smoothtime = ", str(smoothtime,0,-1), "\n")
    #declare bricktype = "A";

  #break

  #range (preambletime,endtime)

    #declare dorothypos = dorothystartpos + dorothyspeed*time*yellowroaddir;
    #declare camerapos = dorothypos + behind;
    #declare lookatpos = dorothypos + ahead;

    #ifdef (augmented)
      #declare brick_number_r = time*bricks_speed+1.5;
      #declare brick_number = int(brick_number_r);
      #if (brick_number_r - brick_number < 0.8)
        #declare bricktype = substr (wormB[depth], brick_number, 1);
        #declare textinfo = concat ("#", str(brick_number,0,0), ": ", bricktype);
        #debug concat ("At time ", str(time,0,-1), " Dorothy is on brick number ", str(brick_number,0,0), " (", str(brick_number_r,0,-1), ") of type ", bricktype, "\n")
      #end
      // #ifdef (test)
      #local i = 0; #local j = 0;
      #if (brick_number >= 2)
        #local k = 0;
        #declare history = union {
          #while (k < brick_number - 1)
            #local k = k + 1;
            sphere { <i, j, 0>, historythickness }
            cylinder {
              <i, j, 0>
              #if (substr (wormB[depth], k, 1) = "A")
                // upword segment
                #local j = j + 1;
              #else
                // horizontal segment
                #local i = i + 1;
              #end
              <i, j, 0>
              historythickness
            }
          #end
        }
      #end
      #declare present = union {
        #local k = k + 1;
        cylinder {
          <i, j, 0>
          #if (substr (wormB[depth], k, 1) = "A")
            #local j = j + (brick_number_r - brick_number);
          #else
            #local i = i + (brick_number_r - brick_number);
          #end
          <i, j, 0>
          historythickness
        }
        sphere {<i, j, 0> 1.3*historythickness}
      }
      // #end
    #end

    #debug concat ("REGULAR TIME! camera.y is", str(camerapos.y,0,-1),"\n")
    #debug concat ("bricks_speed ", str(bricks_speed,0,-1),"\n")

  #break
#end

cylinder {
  dorothypos,
  dorothypos+0.5*y,
  1
  texture {pigment {color Black} finish {tile_Finish}}
}

#ifdef (augmented)
  text {ttf textfont textinfo 0.1 0
    rotate -78*y
    scale 2
    translate tile_thick*y
    translate dorothypos
    translate 10*yellowroaddir
    texture {
      pigment {color Blue}
      finish {tile_Finish}
    }
  }
  // #ifdef (test)
  #declare grid = union {
    #ifdef (history) object {history} #end
    #ifdef (present) object {present} #end
    sphere {<-1,0,0>, raythickness}
    cylinder {<-1,0,0>, <100*Phi, 100, 0>, raythickness}
    cylinder {<-2,0,0>, <100*Phi, 0, 0>, axisthickness}
    cylinder {<0,-2,0>, <0, 100, 0>, axisthickness}
  }
  #ifdef (grid)
    object {grid
      translate -1.0*20*x
      rotate -78*y
      translate (tile_thick+4*axisthickness)*y
      scale 0.4
      translate dorothypos
      translate 0*20*x
      translate 20*yellowroaddir
      texture {
        pigment {color Black}
        // Blue_Agate scale 2
        finish {tile_Finish}
      }
      no_shadow
    }
  #end
  // #end
  text {ttf textfont "Oz" 0.02 0
    rotate 45*x
    rotate -78*y
    scale 80
    translate 30*tile_thick*y
    translate 50*z
    translate -120*x
    texture {
      White_Marble scale 20
      finish {tile_Finish}
    }
  }
#end

camera {
  #ifdef (AspectWide)
    angle 20*4/3
    right 16/9*x
  #else
    angle 20
  #end
  location camerapos + eyeshift
  look_at lookatpos
  sky skycam
}

light_source { 100*<20, 20, -20> color White } 
//light_source { 2*20*<1, 1, 1> color White }
  
#ifdef (sfondobianco) 
  background {White}
#end
