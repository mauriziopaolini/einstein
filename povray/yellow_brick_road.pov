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
#declare allotted_em0 = 50;
#declare allotted_em1 = 60;
#declare allotted_ww0 = 20;
#declare allotted_ww2 = 50;
#declare allotted_ww3 = 60;

#ifndef (dirchangeduration) #declare dirchangeduration = 4; #end
#ifndef (dorothyspeed)
  #declare dorothyspeed = 6;
  #if (depth >= 6) #declare dorothyspeed = 8; #end
#end
#ifndef (speedup_time) #declare speedup_time = 3000/25; #end
#declare meters = 10;

#ifndef (htile)
  #declare htile = 7;
#end

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

#declare mag = pow(Phi*Phi,depth);
#declare pathtime = clock - preambleduration; 

#if (depth > 0)
  #declare crossing1 = vtransform (<0,0,0>, transform {trcrossing rotate rot2*y translate trn2[depth-1]});
  #declare emeraldpos = vtransform (<0,0,0>, transform {tremerald rotate rot2*y translate trn2[depth-1]});
  #declare wickedwitchpos = vtransform (<0,0,0>, transform {trwicked rotate rot3*y translate trn3[depth-1]});

  #declare trcrossing = transform {trcrossing rotate rot3*y translate trn3[depth-1] gtrans};
  #declare crossing2 = vtransform (<0,0,0>, trcrossing);
  #declare path0dir = vnormalize (crossing1 - yellowroadstart);
  #declare path1dir = path0dir;
  #declare path2dir = vnormalize (crossing2 - crossing1);
  #declare path3dir = vtransform (path2dir, transform {rotate 60*y});

  #declare quakefreezeduration = 3;
  #ifndef (quakeduration) #declare quakeduration = 12; #end
  /* This is taylored at depth=6, dorothyspeed=8 */
  #declare quakeendtime = 48 + 12 - 3;
  #declare quakestarttime = quakeendtime - quakeduration + quakefreezeduration;

  #if (htile = 7) calc_fibo (2*depth) #else calc_fibo (2*depth+1) #end
  #declare lastbrick = fiboval;
  calc_fibo (2*depth-2)
  #declare quake1brickend = fiboval - 1;
  calc_fibo (2*depth-6)
  #declare quake1brickstart = quake1brickend - fiboval;
  #declare quake2brickend = lastbrick - quake1brickend - 2;
  #declare quake2brickstart = quake2brickend - fiboval;

  //#declare bricks_speed = 0.7/4*dorothyspeed*1.021430283490544*233.5/233.875389; // adjusted may 29, 2023
  #declare bricks_size = vlength(emeraldpos)/(lastbrick-1);
  #declare bricks_speed = dorothyspeed/bricks_size;

  #if (depth = 5 & htile = 8)
    #declare bricks_speed = 0.7/4*dorothyspeed*1.021430283490544; // adjusted may 25, 2023
  #end

  #ifdef (dark)
    #declare yellowroadstart = trn3[depth-1];
  #end

  #declare path0duration = vlength(crossing1 - yellowroadstart)/dorothyspeed;
  #declare path0durationgross = path0duration + 2*quakefreezeduration;
  #declare path1duration = vlength(emeraldpos - crossing1)/dorothyspeed;
  #declare path1durationgross = path1duration + 2*quakefreezeduration;
  #declare path2duration = vlength(crossing2 - crossing1)/dorothyspeed;
  #declare path3duration = vlength(wickedwitchpos - crossing2)/dorothyspeed;
  #debug concat("path0 computed duration: ", str (path0duration,0,-1), "\n")
  #debug concat("path1 computed duration: ", str (path1duration,0,-1), "\n")
  #debug concat("path2 computed duration: ", str (path2duration,0,-1), "\n")
  #debug concat("path3 computed duration: ", str (path3duration,0,-1), "\n")
#end

#ifdef (emeraldpath)
  #declare allottedgross = allotted_em0 + 2*quakefreezeduration;
  #if (path0durationgross < allottedgross) #declare allottedgross = path0durationgross; #end
  #declare movietime = clock - preambleduration; 
  #if (movietime <= allottedgross)
    #declare path = 0;
    define_speedup_spline (path0durationgross, allottedgross)
    #declare pathtime = speedup_spline (movietime).x;
    #declare quakeendtime = bricks_size*quake1brickend/dorothyspeed + 2*quakefreezeduration;  // 'movietime' units
    #declare quakestarttime = quakeendtime - quakeduration;
    define_freeze_spline (path0durationgross, quakestarttime, quakeendtime, quakefreezeduration)
    #declare walktime = freeze_spline (pathtime).x;
  #else
    #declare movietime = movietime - allottedgross;
    #declare allottedgross = allotted_em1 + 2*quakefreezeduration;
    #if (path1durationgross < allottedgross) #declare allottedgross = path1durationgross; #end
    #declare path = 1;
    #declare preambleduration = dirchangeduration;
    #declare movietime = movietime - preambleduration;
    define_speedup_spline (path1durationgross, allottedgross)
    #declare pathtime = speedup_spline (movietime).x;
    #declare quakeendtime = bricks_size*quake2brickend/dorothyspeed;
    #declare quakestarttime = quakeendtime - quakeduration;
    define_freeze_spline (path1durationgross, quakestarttime, quakeendtime, quakefreezeduration)
    #declare walktime = freeze_spline (pathtime).x;
  #end
#end

#ifdef (witchpath)
  //#declare path0duration = 62.4;  // [case depth=6]
  //#declare path2duration = 62.4;  // [case depth=6]
  //#declare path3duration = 100.2;  // [case depth=6]
  #declare allottedgross = allotted_ww0 + 2*quakefreezeduration;
  #if (path0durationgross < allottedgross) #declare allottedgross = path0durationgross; #end
  #declare movietime = clock - preambleduration;
  #if (movietime <= allottedgross)
    #declare path = 0;
    define_speedup_spline (path0durationgross, allottedgross)
    #declare pathtime = speedup_spline (movietime).x;
    #declare quakeendtime = bricks_size*quake1brickend/dorothyspeed + 2*quakefreezeduration;
    #declare quakestarttime = quakeendtime - quakeduration;
    define_freeze_spline (path0durationgross, quakestarttime, quakeendtime, quakefreezeduration)
    #declare walktime = freeze_spline (pathtime).x;
  #else
    #declare movietime = movietime - allottedgross;
    #declare allotted = allotted_ww2;
    #if (path2duration < allotted) #declare allotted = path2duration; #end
    #declare preambleduration = dirchangeduration;
    #declare movietime = movietime - preambleduration;
    #if (movietime <= allotted)
      #declare path = 2;
      define_speedup_spline (path2duration, allotted)
      #declare pathtime = speedup_spline (movietime).x;
      #declare walktime = pathtime;
    #else
      #declare movietime = movietime - allotted;
      #declare allotted = allotted_ww3;
      #if (path3duration < allotted) #declare allotted = path3duration; #end
      #declare path = 3;
      #declare preambleduration = dirchangeduration;
      #declare movietime = movietime - preambleduration;
      define_speedup_spline (path3duration, allotted)
      #declare pathtime = speedup_spline (movietime).x;
      #declare walktime = pathtime;
    #end
  #end
#end

#ifdef (path)
  #debug concat("path: ", str(path,0,0), " pathtime=", str(pathtime,0,-1), " walktime=", str(walktime,0,-1), "\n")
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
  #ifndef (FIGURINES) #declare FIGURINES = 1; #end
  #if (path <= 1)
    #ifndef (earthquake) #declare earthquake = 1; #end
  #end
#end

#ifndef (earthquake) #declare quakestarttime = 99999; #end

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

#if (depth > 0)
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
#end

#declare dorothystartpos = yellowroadstart + 2*tile_thick*y;
#ifdef (yellowroaddir)
  #declare lookatpos = yellowroadstart + ahead;
  #declare faraway = yellowroadstart - 40*meters*yellowroaddir + 10*meters*y;
#end

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
    //#declare projected_realtimeend = 325;
    #declare projected_realtimeend = 162.465910;
  #break

  #default
    #declare projected_realtimeend = speedup_time;
  #break
#end

#ifdef (dofastforward)
  define_speedup_spline (projected_realtimeend, speedup_time)
#end

/*
 * se non ho sbagliato i conti Dorothy impiega 1/0.7 secondi per avanzare di un
 * cluster, avanzando a velocita' 4
 */

#ifdef (lastbrick)
  #declare realtimeend = (lastbrick - 1.0)/bricks_speed;

  #ifdef (debug)
    #debug concat ("worm = ", worm, "\n")
    #debug concat ("  last element: ", substr(worm, lastbrick, 1), "\n")
  #end
  #debug concat ("\n=========\nnumber of H clusters in the yellow brick road = ", str(lastbrick,0,0), "\n")
  #debug concat ("   The center of last tile will be reached at realtime = ", str(realtimeend,0,-1), "\n")
#end

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

#declare dorothydetour = 0*y;

#if (path = 0 & pathtime <= 10) #declare buildtheback = 1; #end

#declare rotquake = 0;

#if (htile = 7)
  h7rec (transform {gtrans}, depth)

  #ifdef (buildtheback)
    #local invtrans = transform {transform {rotate rot6*y translate trn6[depth+1] rotate rot0*y translate trn0[depth]} inverse}
    #local dirtransleft = transform {rotate rot6*y translate trn6[depth] rotate rot2*y translate trn2[depth+1]}
    #local dirtranstop = transform {rotate rot4*y translate trn4[depth] rotate rot5*y translate trn5[depth+1]}
    h8rec (transform {dirtransleft invtrans gtrans}, depth)
    h8rec (transform {dirtranstop invtrans gtrans}, depth)
  #end

  #declare onlyworm = 1;
  #declare h7worm = h7wormyellow;
  #declare h8worm = h8wormyellow;
//  #ifdef (buildtheback) h8rec (transform {translate -trn6[depth]+trn2[depth] gtrans translate tile_thick*y}, depth) #end
  #ifdef (buildtheback) h8rec (transform {dirtransleft invtrans gtrans translate tile_thick*y}, depth) #end
  #ifdef (quakeduration)
    #declare relquake = (pathtime - quakestarttime)/quakeduration;
    #if (relquake > 0 & relquake < 1)
      #local dim = strlen (worm);
      buildwormrecvec (dim, depth)
      #debug concat ("### during earthquake, dim = ", str(dim,0,0), " wormveci = ", str(wormveci,0,0), "\n")
      #declare rotquake = 180*quakerotlift(relquake).x;
      #local lift = 10*quakerotlift(relquake).y;
      #declare dorothydetour = dorothydetour + lift*tile_thick*y;
      wormbyvec (rotquake, transform {gtrans translate (1+lift)*tile_thick*y})
    #else
      h7rec (transform {gtrans translate tile_thick*y}, depth)
    #end
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

#ifdef (augmented)
  #declare historythickness = 0.2;
  #declare raythickness = 0.14;
  #declare axisthickness = 0.12;
  #declare textinfo = "";
  #declare bricktype = "?"
  #declare tgridleft = 0;
  #declare tgriddown = 0;
#end

#ifdef (yellowroaddir) #declare pathdir = yellowroaddir; #end
#declare rotpreamble = 0;
#switch (path)
  #case (1)
    //#declare pathdir = yellowroaddir;
    //#declare behind = vtransform (behind, transform {rotate -120*y});
    //#declare ahead = vtransform (ahead, transform {rotate -120*y});
    #declare dorothystartpos = crossing0 + 2*tile_thick*y;
  #break
  #case (2)
    //#declare pathdir = vnormalize (crossing2 - crossing1);
    #declare rotpreamble = -120;
    #declare pathdir = path2dir;
    #declare behind = vtransform (behind, transform {rotate -120*y});
    #declare ahead = vtransform (ahead, transform {rotate -120*y});
    #declare dorothystartpos = crossing1 + 2*tile_thick*y;
  #break
  #case (3)
    #declare rotpreamble = -60;
    #declare pathdir = path2dir;
    #declare pathdir = vtransform (pathdir, transform {rotate 60*y});
    #declare behind = vtransform (behind, transform {rotate -60*y});
    #declare ahead = vtransform (ahead, transform {rotate -60*y});
    #declare dorothystartpos = crossing2 + 2*tile_thick*y;
  #break
#end

#declare dorothypos = dorothystartpos;

#if (pathtime < 0)
  #declare reltime = -pathtime/preambleduration;  // in [0,1]
  #declare smoothtime = smoothp(1 - reltime).x;
  #ifdef (debug)
    #debug concat ("smoothtime = ", str(smoothtime,0,-1), "\n")
  #end
  #switch (path)
    #case (0)
      #declare endtime = 128.8 - preambleduration;
    #case (-1)
      #ifndef (topview)
        #declare camerapos = (1-smoothtime)*faraway + smoothtime*dorothystartpos + behind;
        #declare lookatpos = dorothystartpos + (4*reltime + 1)*ahead;
      #end
      #declare bricktype = "A";
    #break

    #case (1)  // rest of path to emerald castle
      #declare endtime = 204.5 - preambleduration;
      #declare rotpreamble = -120*indecisa (reltime).x;
      #declare behind = vtransform (behind, transform {rotate rotpreamble*y});
      #declare ahead = vtransform (ahead, transform {rotate rotpreamble*y});
      #declare camerapos = crossing1 + behind;
      #declare dorothystartpos = crossing1 + 2*tile_thick*y;
      #declare lookatpos = dorothystartpos + ahead;
    #break

    #case (2)
      #declare rotpreamble = (reltime-1)*120;
      #declare endtime = 128.8 - preambleduration;
      #declare behind = vtransform (behind, transform {rotate reltime*120*y});
      #declare ahead = vtransform (ahead, transform {rotate reltime*120*y});
      #declare camerapos = crossing1 + behind;
      #declare dorothystartpos = crossing1 + 2*tile_thick*y;
      #declare lookatpos = dorothystartpos + ahead;
    #break

    #case (3)
      #declare rotpreamble = (1-reltime)*60-120;
      #declare endtime = 204.5 - preambleduration;
      #declare behind = vtransform (behind, transform {rotate -reltime*60*y});
      #declare ahead = vtransform (ahead, transform {rotate -reltime*60*y});
      #declare camerapos = crossing2 + behind;
      #declare dorothystartpos = crossing2 + 2*tile_thick*y;
      #declare lookatpos = dorothystartpos + ahead;
    #break

    #else
      #debug "SHOULD NOT BE HERE!\n")
  #end

#else

  //#declare realtime = pathtime;  /* this takes into account possible time speedup */
  #ifndef (walktime) #declare walktime = pathtime; #end
  #ifdef (dofastforward)
    #declare walktime = speedup_spline (pathtime).x;
    #ifdef (xx1)
      #if (pathtime > xx1 & pathtime < xx2)
        #declare augmentedff = concat (">>", str(speedup_value,0,0),"x");
        #debug concat("==================> FAST FORWARDING: ", augmentedff, " <==============\n")
      #end
    #end
  #end

  #declare dorothypos = dorothystartpos + dorothyspeed*walktime*pathdir;
  #declare camerapos = dorothypos + behind;
  #declare lookatpos = dorothypos + ahead;

  #ifdef (augmented)
    #declare brick_number_r = walktime*bricks_speed+1.5;
    #declare brick_number = int(brick_number_r);
    #if (brick_number_r - brick_number < 0.9)
      #declare bricktype = substr (worm, brick_number, 1);
      //#declare textinfo = concat ("#", str(brick_number,0,0), ": ", bricktype);
      #if (bricktype = "A")
        #declare textinfo = "H7:up";
      #else
        #declare textinfo = "H8:right";
      #end
      #debug concat ("\n\nAt time ", str(walktime,0,-1), " Dorothy is on brick number ", str(brick_number,0,0), " (", str(brick_number_r,0,-1), ") of type ", bricktype, "\n")
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

#end

sky_sphere {S_Cloud1}

plane {y, 0
  texture {pigment {color DarkGreen}}
}

#ifdef (FIGURINES)
  #declare dorothyplate = object {
    figurine (130/225, "images/dorothyback.jpg", "images/dorothyfront.jpg")
    rotate 100*y
  }

  object {dorothyplate
    rotate rotpreamble*y
    rotate rotquake*y
    translate dorothypos
    translate dorothydetour
  }
#end

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
#ifdef (zoom) #declare camerapos = zoom*camerapos; #end

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
