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

#ifndef (preambletime) #declare preambletime = 4; #end
#declare endtime = 10000;

#declare time = clock;

#declare smoothp = spline {
  cubic_spline
  -1, 1*x
  0, 0*x
  1, 1*x
  2, 0*x
}

#if (clock >= preambletime)
  #declare time = clock - preambletime;
#end

#declare yellowroadstart = <0,0,0>;
/*
 * this is the end of the worm in case depth=5
 */
#declare yellowroadend = <-775.5, 0, 200.051868>;
#declare yellowroaddir = vnormalize(yellowroadend - yellowroadstart);
#ifndef (dorothyspeed) #declare dorothyspeed = 4; #end

#declare meters = 10;

//#declare behind = -1*meters*yellowroaddir + 1*meters*y;
#declare behind = -6*meters*yellowroaddir + 2*meters*y;
#declare ahead = 4*meters*yellowroaddir;
#declare dorothystartpos = yellowroadstart;
#declare lookatpos = yellowroadstart + ahead;
#declare faraway = yellowroadstart - 40*meters*yellowroaddir + 10*meters*y;

#declare eyeshift = 0*x;
#declare skycam = y;
#declare dorothypos = dorothystartpos;

#ifndef (depth) #declare depth = 5; #end
#ifndef (htile) #declare htile = 8; #end

#declare h7worm = union {
  h7list (Yellow, <1,0,0>, <1,0.5,0.5>)
}

#declare h8worm = union {
  h8list (Yellow, <0,1,0>, <0.5,1,0.5>)
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

#switch (clock)
  #range (0,preambletime)
    #declare smoothtime = smoothp(clock/preambletime).x;
    #declare camerapos = (1-smoothtime)*faraway + smoothtime*dorothystartpos + behind;
    #debug concat ("smoothtime = ", str(smoothtime,0,-1), "\n")

  #break

  #range (preambletime,endtime)

    #declare dorothypos = dorothystartpos + dorothyspeed*time*yellowroaddir;
    #declare camerapos = dorothypos + behind;
    #declare lookatpos = dorothypos + ahead;

    #debug concat ("REGULAR TIME! camera.y is", str(camerapos.y,0,-1),"\n")

  #break
#end

cylinder {
  dorothypos,
  dorothypos+0.5*y,
  1
  pigment {color Black}
}

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
