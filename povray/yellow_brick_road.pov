/*
 * sullo stile di "sorvolo" si percorre il worm semiinfinito che si ottiene
 * per deflazione a partire da un H7
 * H7 = 0, H8 = 1
 *
 * clock is in seconds
 * per depth=6 Dorothy raggiungerebbe la fine al clock=329 (time = 325)
 */
/*
#finalclock 164
#numseconds 164
#durata 165
#coda 1
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

#ifndef (depth) #declare depth = 6; #end
#ifndef (preambleduration) #declare preambleduration = 4; #end
#ifndef (dorothyspeed)
  #declare dorothyspeed = 4;
  #if (depth >= 6) #declare dorothyspeed = 8; #end
#end
#ifndef (speedup_time) #declare speedup_time = 4000/25; #end
#declare meters = 10;


#ifndef (htile)
  #declare htile = 7;
#end

#declare preamblestart = 0;
#declare preambleend = preamblestart + preambleduration;
//#declare dofastforward = 1;
#declare endtime = 99999;  /* that's +infinity */

#declare gtrans = transform {scale 1};
#declare yellowroadstart = <0,0,0>;

#declare trcrossing = transform {rotate rot0*y translate trn0[0]};
#declare tremerald = transform {rotate rot0*y translate trn6[0]};
#declare trwicked = transform {rotate rot0*y translate trn6[0]};
#local i = 1;
#while (i < depth-1)
  #declare trcrossing = transform {trcrossing rotate rot0*y translate trn0[i]};
  #declare tremerald = transform {tremerald rotate rot6*y translate trn6[i]};
  #declare trwicked = transform {trwicked rotate rot6*y translate trn6[i]};
  #local i = i + 1;
#end
#declare crossing1 = vtransform (<0,0,0>, transform {trcrossing rotate rot2*y translate trn2[depth-1]});
#declare emeraldpos = vtransform (<0,0,0>, transform {tremerald rotate rot2*y translate trn2[depth-1]});
#declare wickedwitchpos = vtransform (<0,0,0>, transform {trwicked rotate rot3*y translate trn3[depth-1]});

#declare trcrossing = transform {trcrossing rotate rot3*y translate trn3[depth-1] gtrans};
#declare crossing2 = vtransform (<0,0,0>, trcrossing);
#declare path0dir = vnormalize (crossing1 - yellowroadstart);
#declare path1dir = path0dir;
//#declare emeraldpos = crossing1 + (204.5-preambleend)*dorothyspeed*path1dir;
#declare path2dir = vnormalize (crossing2 - crossing1);
#declare path3dir = vtransform (path2dir, transform {rotate 60*y});
//#declare wickedwitchpos = crossing2 + (204.5-preambleend)*dorothyspeed*path3dir;

#declare mag = pow(Phi*Phi,depth);

#ifdef (dark)
  #declare yellowroadstart = trn3[depth-1];
#end

/*
 * possible paths:
 * -1: standard walk along the yellow brick road
 *  0: from yellowroadstart to crossing1
 *  1: from crossing1 to end of yellow road
 *  2: from crossing1 to crossing2
 *  3: from crossing2 to wicked witch
 */
#ifndef (path) #declare path=-1; #end
#if (path >= 0)
  #ifndef (ROADS) #declare ROADS = 1; #end
  #ifndef (ROADSIGNS) #declare ROADSIGNS = 1; #end
  #ifndef (CASTLES) #declare CASTLES = 1; #end
  #ifndef (earthquake) #declare earthquake = 1; #end
#end

#ifdef (topview)
  #declare arrowthick = 0.05*mag;
  #if (topview = 3)
    union {
      sphere {yellowroadstart, arrowthick}
      cylinder { yellowroadstart, crossing1, arrowthick }
      sphere {crossing1, 0.05*mag}
      cylinder { crossing1, crossing2, arrowthick }
      sphere {crossing2, arrowthick}
      cone { crossing2, arrowthick, wickedwitchpos, 0 }
      translate 4*tile_thick*y
      pigment {color Black}
    }
  #end
  #if (topview = 2)
    union {
      sphere {yellowroadstart, arrowthick}
      cylinder { yellowroadstart, crossing1, arrowthick }
      sphere { crossing1, arrowthick}
      cone { crossing1, arrowthick, emeraldpos, 0 }
      translate 4*tile_thick*y
      pigment {color Black}
    }
  #end
  #if (topview >= 2) #declare ROADS=1; #declare CASTLES=1; #end
#end

#ifndef (earthquakeduration) #declare earthquakeduration = 12; #end
#ifdef (earthquake)
  /* This is taylored at depth=6, dorothyspeed=8 */
  #ifndef (earthquakestarttime) #declare earthquakestarttime = 48; #end
#end
#ifndef (earthquakestarttime) #declare earthquakestarttime = 99999; #end

/*
 * this is the end of the worm in case depth=5 htype 8
 * (trovato con trial and error)
 * depth = 5, htile=8: #declare yellowroadend = <-775.5, 0, 200.051868>;
 */
/* questo invece si riferisce a depth=6, htype 7
 */
//#declare yellowroadend = <-1258.79, 0, 324.724>;
#declare yellowroadend = emeraldpos;
#if (depth = 5 & htile = 8) #declare yellowroadend = <-775.5, 0, 200.051868>; #end
#declare yellowroaddir = vnormalize(yellowroadend - yellowroadstart);
//#declare yellowroaddirrot90 = vtransform (yellowroaddir, -90*y);

//#declare behind = -1*meters*yellowroaddir + 1*meters*y;
#declare behind = -7*meters*yellowroaddir + 2*meters*y;
#declare ahead = 4*meters*yellowroaddir;
#declare dorothystartpos = yellowroadstart + 2*tile_thick*y;
#declare lookatpos = yellowroadstart + ahead;
#declare faraway = yellowroadstart - 40*meters*yellowroaddir + 10*meters*y;
#declare textfont = "LiberationMono-Regular.ttf"

#declare eyeshift = 0*x;
#declare skycam = y;
#declare dorothypos = dorothystartpos;

build_wormAB (depth)

#declare worm = wormA;
#if (htile = 8)
  #declare worm = wormB;
#end

#switch (depth)
  #case (4)
    #declare projected_realtimeend = 46.227968;
    #break

  #case (5)
    #declare projected_realtimeend = 123.274583;
    #if (htile = 8)
      #declare projected_realtimeend = 200;
    #end
    #break

  #case (6)
    #declare projected_realtimeend = 325;
  #break

  #default
    #declare projected_realtimeend = speedup_time;
  #break
#end

#ifdef (dofastforward)
  define_speedup_spline (projected_realtimeend, speedup_time)
#end

#declare lastbrick = strlen(worm);

/*
 * se non ho sbagliato i conti Dorothy impiega 1/0.7 secondi per avanzare di un
 * cluster, avanzando a velocita' 4
 */

#declare bricks_speed = 0.7/4*dorothyspeed*1.021430283490544*233.5/233.875389; // adjusted may 29, 2023
//#declare bricks_speed = 233.5/233.875389*bricks_speed; // adjusted for depth=6 may 29, 2023
#if (depth = 5 & htile = 8)
  #declare bricks_speed = 0.7/4*dorothyspeed*1.021430283490544; // adjusted may 25, 2023
#end

#declare realtimeend = (lastbrick - 1.0)/bricks_speed;

#ifdef (debug)
  #debug concat ("worm = ", worm, "\n")
  #debug concat ("  last element: ", substr(worm, lastbrick, 1), "\n")
#end
#debug concat ("\n=========\nnumber of H clusters in the yellow brick road = ", str(lastbrick,0,0), "\n")
#debug concat ("   The center of last tile will be reached at realtime = ", str(realtimeend,0,-1), "\n")

#macro wormcolors (c70, c71, c72, c80, c81, c82)
  #declare h7worm = union {
    h7list (c70, c71, c72)
    texture {finish {tile_Finish}}
  }
  #declare h8worm = union { 
    h8list (c80, c81, c82)
    texture {finish {tile_Finish}}
  }
#end

wormcolors (<0.3,0.3,0.5>, <0.5,0.5,0.8>, <0.6,0.6,0.9>,
            <0.4,0.4,0.4>, <0.6,0.6,0.7>, <0.6,0.6,0.9>)
#declare h7wormdark = h7worm;
#declare h8wormdark = h8worm;

wormcolors (<0,0,1>, <0,0.5,1>, <0.2,0.6,1>,
            <0,0,1>, <0,1,0.5>, <0.2,1,0.6>)
#declare h7wormblue = h7worm;
#declare h8wormblue = h8worm;

wormcolors (<1,1,0>, <1,0.5,0>, <1,0.6,0.2>,
            <1,1,0>, <0.5,1,0>, <0.6,1,0.2>)
#declare h7wormyellow = h7worm;
#declare h8wormyellow = h8worm;

//#declare MaxPosLeft = <0,0,0>;

#declare dorothydetour = 0*y;

#declare movietime = clock - preambleend;
#if (movietime <= 10) #declare buildtheback = 1; #end

#if (htile = 7)
  h7rec (transform {gtrans}, depth)

  //#ifdef (buildtheback) h7rec (transform {translate -trn2[depth] gtrans}, depth) #end
  #ifdef (buildtheback) h8rec (transform {rotate rot2*y translate trn2[depth]-trn6[depth] gtrans}, depth) #end
  #ifdef (buildtheback) h8rec (transform {rotate rot5*y translate trn5[depth]-trn6[depth] gtrans}, depth) #end

  #declare onlyworm = 1;
  #declare h7worm = h7wormyellow;
  #declare h8worm = h8wormyellow;
  //#ifdef (buildtheback) h7rec (transform {translate -trn2[depth] gtrans translate tile_thick*y}, depth) #end
  #ifdef (buildtheback) h8rec (transform {translate -trn6[depth]+trn2[depth] gtrans translate tile_thick*y}, depth) #end
  #declare relquake = (movietime - earthquakestarttime)/earthquakeduration;
  //#if (movietime - earthquakestarttime > 0 & movietime - earthquakestarttime < earthquakeduration)
  #if (relquake > 0 & relquake < 1)
    #local dim = strlen (worm);
    buildwormrecvec (dim, depth)
    #debug concat ("### during earthquake, dim = ", str(dim,0,0), " wormveci = ", str(wormveci,0,0), "\n")
    #local rot = 180*quakerotlift(relquake).x;
    #local lift = 10*quakerotlift(relquake).y;
    #declare dorothydetour = dorothydetour + lift*tile_thick*y;
    wormbyvec (rot, transform {gtrans translate (1+lift)*tile_thick*y})
  #else
    h7rec (transform {gtrans translate tile_thick*y}, depth)
  #end
  #ifdef (ROADS)
    /* display worms at level depth-1 */
    #declare gtransup = transform {gtrans translate 2*tile_thick*y};
    #declare d = depth-1;

    #declare h7worm = h7wormdark;
    #declare h8worm = h8wormdark;
    h8rec (transform {rotate rot4*y translate trn4[d] gtransup}, d)

    #declare h7worm = h7wormblue;
    #declare h8worm = h8wormblue;
    h8rec (transform {rotate rot4*y translate trn4[d-1]
                      rotate rot2*y translate trn2[d] gtransup}, d-1)
    #if (depth > 2) h8rec (transform {rotate rot4*y translate trn4[d-2]
                      rotate rot0*y translate trn0[d-1]
                      rotate rot2*y translate trn2[d] gtransup}, d-2) #end
    #if (depth > 3) h8rec (transform {rotate rot4*y translate trn4[d-3]
                      rotate rot0*y translate trn0[d-2]
                      rotate rot0*y translate trn0[d-1]
                      rotate rot2*y translate trn2[d] gtransup}, d-3) #end
    #if (depth >= 6)
      h8rec (transform {rotate rot4*y translate trn4[d-4]
                        rotate rot0*y translate trn0[d-3]
                        rotate rot0*y translate trn0[d-2]
                        rotate rot0*y translate trn0[d-1]
                        rotate rot2*y translate trn2[d] gtransup}, d-4)
    #end
    #declare h7worm = h7wormdark;
    #declare h8worm = h8wormdark;
    h8rec (transform {rotate rot1*y translate trn1[d] gtransup}, d)
    h8rec (transform {rotate rot3*y translate trn3[d-1]
                      rotate rot0*y translate trn0[d] gtransup}, d-1)
    h8rec (transform {rotate rot3*y translate trn3[d] gtransup}, d)
    h8rec (transform {rotate rot5*y translate trn5[d] gtransup}, d)
  #end
  #ifdef (CASTLES)
    object {castle (1.85, "emeraldcity.jpg")
      rotate 45*x
      rotate -80*y
      translate emeraldpos
    }
    object {castle (1.5, "wickedwitchcastle.jpg")
      rotate 45*x
      rotate (-80-60)*y
      translate wickedwitchpos
    }
    object {castle (284/177, "house.jpg")
      rotate 45*x
      translate -6*x
      rotate -70*y
      translate yellowroadstart + 2*tile_thick*y
    }
  #end
#else
  h8rec (transform {scale 1.0}, depth)
  #declare onlyworm = 1;
  h8rec (transform {translate tile_thick*y}, depth)
#end

#ifdef (ROADSIGNS)
  union {
    roadsign ("To Emerald", "City")
    translate yellowroadstart + 2.5*x
    rotate -80*y
    translate -10*x+4*z
    translate 3*yellowroaddir
  }
  #declare crossing0 = vtransform (<0,0,0>, transform {translate trn2[depth-1]});
  #declare crossing = crossing0 + vtransform (<0,0,0>, transform {translate trn3[0] rotate rot3*y});
  #declare crossingrot = rot3*y;
  union {
    roadsign ("To Wicked Witch", "of the West")
    rotate -80*y
    translate crossing + 2.5*x
  }
  union {
    roadsign ("To Wicked Witch", "of the West")
    rotate 180*y
    translate crossing2 - 2.5*x - 10.0*z
  }
  //h8rec (transform {translate 2*tile_thick*y rotate crossingrot translate crossing}, 0)
  //sphere {crossing, 1
  //  texture {pigment {color Black}}
  //}
  //#declare crossing = crossing0 + vtransform (<0,0,0>, transform {translate trn6[0] rotate rot6*y});
  //h8rec (transform {translate 2*tile_thick*y rotate crossingrot translate crossing}, 0)
#end

/*
#ifdef (debug)
  #debug concat ("MaxPosLeft.x = ", str(MaxPosLeft.x,0,-1), "\n")
  #debug concat ("MaxPosLeft.z = ", str(MaxPosLeft.z,0,-1), "\n")
  // this gives <-775.5, 0, 200.051868> for depth = 5
#end
 */

#ifdef (augmented)
  #declare historythickness = 0.2;
  #declare raythickness = 0.14;
  #declare axisthickness = 0.12;
  #declare textinfo = "";
  #declare bricktype = "?"
  #declare tgridleft = 0;
  #declare tgriddown = 0;
#end

#declare pathdir = yellowroaddir;
#switch (path)
  #case (1)
    //#declare pathdir = yellowroaddir;
    //#declare behind = vtransform (behind, transform {rotate -120*y});
    //#declare ahead = vtransform (ahead, transform {rotate -120*y});
    #declare dorothystartpos = crossing0 + 2*tile_thick*y;
  #break
  #case (2)
    //#declare pathdir = vnormalize (crossing2 - crossing1);
    #declare pathdir = path2dir;
    #declare behind = vtransform (behind, transform {rotate -120*y});
    #declare ahead = vtransform (ahead, transform {rotate -120*y});
    #declare dorothystartpos = crossing1 + 2*tile_thick*y;
  #break
  #case (3)
    #declare pathdir = path2dir;
    #declare pathdir = vtransform (pathdir, transform {rotate 60*y});
    #declare behind = vtransform (behind, transform {rotate -60*y});
    #declare ahead = vtransform (ahead, transform {rotate -60*y});
    #declare dorothystartpos = crossing2 + 2*tile_thick*y;
  #break
#end

#declare dorothypos = dorothystartpos;

#switch (clock)
  #range (preamblestart,preambleend)
    #declare reltime = (preambleend - clock)/preambleduration;
    #declare smoothtime = smoothp((clock-preamblestart)/preambleduration).x;
    #ifdef (debug)
      #debug concat ("smoothtime = ", str(smoothtime,0,-1), "\n")
    #end
    #switch (path)
      #case (0)
        #declare endtime = 128.8 - preambleend;
      #case (-1)
        #ifndef (topview)
          #declare camerapos = (1-smoothtime)*faraway + smoothtime*dorothystartpos + behind;
          #declare lookatpos = dorothystartpos + (4*reltime + 1)*ahead;
        #end
        #declare bricktype = "A";
      #break

      #case (1)  // rest of path to emerald castle
        #declare endtime = 204.5 - preambleend;
        #declare rotangle = -120*indecisa (reltime).x;
        #declare behind = vtransform (behind, transform {rotate rotangle*y});
        #declare ahead = vtransform (ahead, transform {rotate rotangle*y});
        #declare camerapos = crossing1 + behind;
        #declare dorothystartpos = crossing1 + 2*tile_thick*y;
        #declare lookatpos = dorothystartpos + ahead;
      #break

      #case (2)
        #declare endtime = 128.8 - preambleend;
        #declare behind = vtransform (behind, transform {rotate reltime*120*y});
        #declare ahead = vtransform (ahead, transform {rotate reltime*120*y});
        #declare camerapos = crossing1 + behind;
        #declare dorothystartpos = crossing1 + 2*tile_thick*y;
        #declare lookatpos = dorothystartpos + ahead;
      #break

      #case (3)
        #declare endtime = 204.5 - preambleend;
        #declare behind = vtransform (behind, transform {rotate -reltime*60*y});
        #declare ahead = vtransform (ahead, transform {rotate -reltime*60*y});
        #declare camerapos = crossing2 + behind;
        #declare dorothystartpos = crossing2 + 2*tile_thick*y;
        #declare lookatpos = dorothystartpos + ahead;
      #break

      #else
        #debug "SHOULD NOT BE HERE!\n")
    #end

  #break

  #range (preambleend,endtime)

    // #declare movietime = clock - preambleend;
    #declare realtime = movietime;  /* this takes into account possible time speedup */
    #ifdef (dofastforward)
      #declare realtime = speedup_spline (movietime).x;
      #ifdef (xx1)
        #if (movietime > xx1 & movietime < xx2)
          #declare augmentedff = concat (">>", str(speedup_value,0,0),"x");
          #debug concat("==================> FAST FORWARDING: ", augmentedff, " <==============\n")
        #end
      #end
    #end

    #declare dorothypos = dorothystartpos + dorothyspeed*realtime*pathdir;
    #declare camerapos = dorothypos + behind;
    #declare lookatpos = dorothypos + ahead;

    #ifdef (augmented)
      #declare brick_number_r = realtime*bricks_speed+1.5;
      #declare brick_number = int(brick_number_r);
      #if (brick_number_r - brick_number < 0.9)
        #declare bricktype = substr (worm, brick_number, 1);
        //#declare textinfo = concat ("#", str(brick_number,0,0), ": ", bricktype);
        #if (bricktype = "A")
          #declare textinfo = "H7:up";
        #else
          #declare textinfo = "H8:right";
        #end
        #debug concat ("\n\nAt time ", str(realtime,0,-1), " Dorothy is on brick number ", str(brick_number,0,0), " (", str(brick_number_r,0,-1), ") of type ", bricktype, "\n")
        #debug concat ("  she is positioned at (", str(dorothypos.x,0,-1), ",", str(dorothypos.z,0,-1), ")\n=========\n\n")
      #end
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
    #end

    #ifdef (debug)
      #debug concat ("REGULAR TIME! camera.y is ", str(camerapos.y,0,-1),"\n")
      #debug concat ("bricks_speed ", str(bricks_speed,0,-1),"\n")
    #end

  #break
#end
#ifdef (zoom) #declare camerapos = zoom*camerapos; #end

sky_sphere {S_Cloud1}

plane {y, 0
  texture {pigment {color DarkGreen}}
}

cylinder {
  dorothypos,
  dorothypos+0.5*y,
  1
  translate dorothydetour
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
    #ifdef (augmentedff)
      text {ttf textfont augmentedff 0.02 0
        scale 4
        translate 8*x + tgridleft*x + tgriddown*y
      }
    #end
  }
  object {grid
    translate -1.3*20*x - tgridleft*x - tgriddown*y
    rotate -78*y
    scale 0.35
    translate (tile_thick+4*axisthickness)*y
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

#ifdef (topview)
  #declare camerapos = 30*y;
  #declare mag = pow(Phi*Phi,depth);
  #declare camerapos = mag * camerapos;
  #declare skycam = z;
  #declare lookatpos = 0*x;
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
