/*
 * sullo stile di "sorvolo" si percorre il worm semiinfinito che si ottiene
 * per deflazione a partire da un H7
 * H7 = 0, H8 = 1
 *
 * clock is in seconds
 * per depth=6 Dorothy raggiungerebbe la fine al clock=329 (time = 325)
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

#include "colors.inc"
#include "skies.inc"
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
 * this is the end of the worm in case depth=5 type B
 * (trovato con trial and error)
 * depth = 5, htile=8: #declare yellowroadend = <-775.5, 0, 200.051868>;
 */
/* questo invece si riferisce a depth=6, type A
 */
#declare yellowroadend = <-1258.79, 0, 324.724>;
#declare yellowroaddir = vnormalize(yellowroadend - yellowroadstart);
//#declare yellowroaddirrot90 = vtransform (yellowroaddir, -90*y);

#ifndef (dorothyspeed) #declare dorothyspeed = 4; #end

#declare meters = 10;

//#declare behind = -1*meters*yellowroaddir + 1*meters*y;
#declare behind = -7*meters*yellowroaddir + 2*meters*y;
#declare ahead = 4*meters*yellowroaddir;
#declare dorothystartpos = yellowroadstart;
#declare lookatpos = yellowroadstart + ahead;
#declare faraway = yellowroadstart - 40*meters*yellowroaddir + 10*meters*y;
#declare textfont = "LiberationMono-Regular.ttf"

#declare eyeshift = 0*x;
#declare skycam = y;
#declare dorothypos = dorothystartpos;

#ifndef (depth) #declare depth = 5; #end
#ifndef (htile)
  #declare htile = 7;
#end

build_wormAB (depth)

#declare worm = wormA;
#if (htile = 8)
  #declare worm = wormB;
#end

/*
 * se non ho sbagliato i conti Dorothy impiega 1/0.7 secondi per avanzare di un
 * cluster, avanzando a velocita' 4
 */

#declare bricks_speed = 0.7/4*dorothyspeed*1.021430283490544*233.5/233.875389; // adjusted may 29, 2023
//#declare bricks_speed = 233.5/233.875389*bricks_speed; // adjusted for depth=6 may 29, 2023
#if (depth = 5 & htile = 8)
  #declare bricks_speed = 0.7/4*dorothyspeed*1.021430283490544; // adjusted may 25, 2023
#end


#ifdef (debug)
  #debug concat ("worm = ", worm, "\n")
  #debug concat ("  last element: ", substr(worm, 144, 1), "\n")
#end
#debug concat ("\n=========\nnumber of H clusters in the yellow brick road = ", str(strlen(worm),0,0), "\n")

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

#ifdef (debug)
  #debug concat ("MaxPosLeft.x = ", str(MaxPosLeft.x,0,-1), "\n")
  #debug concat ("MaxPosLeft.z = ", str(MaxPosLeft.z,0,-1), "\n")
  /*
   * this gives <-775.5, 0, 200.051868> for depth = 5
   */
#end

#ifdef (augmented)
  #declare historythickness = 0.1;
  #declare raythickness = 0.07;
  #declare axisthickness = 0.06;
  #declare textinfo = "";
  #declare bricktype = "?"
  #declare tgridleft = 0;
  #declare tgriddown = 0;
#end

#switch (clock)
  #range (0,preambletime)
    #declare smoothtime = smoothp(clock/preambletime).x;
    #declare camerapos = (1-smoothtime)*faraway + smoothtime*dorothystartpos + behind;
    #declare reltime = (preambletime - clock)/preambletime;
    #declare lookatpos = dorothystartpos + (4*reltime + 1)*ahead;
    #ifdef (debug)
      #debug concat ("smoothtime = ", str(smoothtime,0,-1), "\n")
    #end
    #declare bricktype = "A";

  #break

  #range (preambletime,endtime)

    #declare dorothypos = dorothystartpos + dorothyspeed*time*yellowroaddir;
    #declare camerapos = dorothypos + behind;
    #declare lookatpos = dorothypos + ahead;

    #ifdef (augmented)
      #declare brick_number_r = time*bricks_speed+1.5;
      #declare brick_number = int(brick_number_r);
      #if (brick_number_r - brick_number < 0.9)
        #declare bricktype = substr (worm, brick_number, 1);
        //#declare textinfo = concat ("#", str(brick_number,0,0), ": ", bricktype);
        #if (bricktype = "A")
          #declare textinfo = "H7:up";
        #else
          #declare textinfo = "H8:right";
        #end
        #debug concat ("\n\nAt time ", str(time,0,-1), " Dorothy is on brick number ", str(brick_number,0,0), " (", str(brick_number_r,0,-1), ") of type ", bricktype, "\n")
        #debug concat ("  she is positioned at (", str(dorothypos.x,0,-1), ",", str(dorothypos.z,0,-1), ")\n=========\n\n")
      #end
      // #ifdef (test)
      #local i = 0; #local j = 0;
      #local k = 0;
      #if (brick_number >= 1)
        #declare history = union {

          /* first square, it is always present */
          cylinder {<i,j,0>, <i,j+1,0>, historythickness}
          sphere { <i, j+1, 0>, historythickness }
          cylinder {<i,j+1,0>, <i+1,j+1,0>, historythickness}
          sphere { <i+1, j+1, 0>, historythickness }
          cylinder {<i+1,j+1,0>, <i+1,j,0>, historythickness}
          sphere { <i+1, j, 0>, historythickness }
          cylinder {<i+1,j,0>, <i,j,0>, historythickness}
          sphere { <i, j, 0>, historythickness }

          #while (k < brick_number - 1)
            #local k = k + 1;
            #if (substr (worm, k, 1) = "A")
              #local j = j + 1;
              cylinder {<i,j,0>, <i,j+1,0>, historythickness}
              sphere { <i, j+1, 0>, historythickness }
              cylinder {<i,j+1,0>, <i+1,j+1,0>, historythickness}
              sphere { <i+1, j+1, 0>, historythickness }
              cylinder {<i+1,j+1,0>, <i+1,j,0>, historythickness}
              //sphere { <i+1, j, 0>, historythickness }
            #else
              #local i = i + 1;
              cylinder {<i,j,0>, <i+1,j,0>, historythickness}
              sphere { <i+1, j, 0>, historythickness }
              cylinder {<i+1,j,0>, <i+1,j+1,0>, historythickness}
              sphere { <i+1, j+1, 0>, historythickness }
              cylinder {<i+1,j+1,0>, <i,j+1,0>, historythickness}
            #end
          #end
        }
      #end
      #local k = k + 1;
      #if (substr (worm, k, 1) = "A")
        #local j = j + (brick_number_r - brick_number);
      #else
        #local i = i + (brick_number_r - brick_number);
      #end
      #declare present = box {<i,j,-1.1*historythickness>,<i+1,j+1,1.1*historythickness>}
      #local k = k + 1;
      #if (i > 55) #declare tgridleft = (i - 55); #end
      #if (j > 34) #declare tgriddown = (j - 34); #end
      // #end
    #end

    #ifdef (debug)
      #debug concat ("REGULAR TIME! camera.y is ", str(camerapos.y,0,-1),"\n")
      #debug concat ("bricks_speed ", str(bricks_speed,0,-1),"\n")
    #end

  #break
#end

sky_sphere {S_Cloud1}

plane {y, 0
  texture {pigment {color DarkGreen}}
}

cylinder {
  dorothypos,
  dorothypos+0.5*y,
  1
  texture {pigment {color Black} finish {tile_Finish}}
}

#ifdef (augmented)
  text {ttf textfont textinfo 0.1 0
    translate 1*x
    rotate -78*y
    scale 2
    translate (tile_thick+0.6)*y
    translate dorothypos
    translate 0*yellowroaddir
    texture {
      pigment {color Blue}
      finish {tile_Finish}
    }
  }
  #declare grid = union {
    #ifdef (history) object {history} #end
    #ifdef (present) object {present} #end
    sphere {<-1,0,0>, raythickness}
    cylinder {<0,1,0>, <100*Phi, 100+1, 0>, raythickness}
    cylinder {<-2,0,0>, <100*Phi, 0, 0>, axisthickness}
    cylinder {<0,-2,0>, <0, 100, 0>, axisthickness}
  }
  object {grid
    translate -1.3*20*x - tgridleft*x - tgriddown*y
    rotate -78*y
    translate (tile_thick+4*axisthickness)*y
    scale 0.35
    translate dorothypos
    translate 5*yellowroaddir
    texture {
      pigment {color Red}
      // Blue_Agate scale 2
      finish {tile_Finish}
    }
    no_shadow
  }
  text {ttf textfont concat("Oz d",str(depth,0,0)) 0.02 0
    translate -1.63*x
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
