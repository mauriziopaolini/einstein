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
#declare yellowroadend = <-1,0,0.5>;
#declare yellowroaddir = vnormalize(yellowroadend - yellowroadstart);

#declare zoomfactor = 20;

#declare startpos = yellowroadstart - zoomfactor*yellowroaddir + zoomfactor*0.5*y;
#declare lookatpos = yellowroadstart;
#declare faraway = yellowroadstart - 20*zoomfactor*yellowroaddir + 5*zoomfactor*y;

#declare eyeshift = 0*x;
#declare skycam = y;
#declare camerapos = startpos;

#ifndef (depth) #declare depth = 5; #end
#ifndef (htile) #declare htile = 8; #end

#if (htile = 7)
  h7rec (transform {scale 1.0}, depth)
  #declare onlyworm = 1;
  h7rec (transform {scale 1.0 + h*y}, depth)
#else
  h8rec (transform {scale 1.0}, depth)
  #declare onlyworm = 1;
  h8rec (transform {scale 1.0 + h*y}, depth)
#end

#switch (clock)
  #range (0,preambletime)
    #declare smoothtime = smoothp(clock/preambletime).x;
    #declare camerapos = (1-smoothtime)*faraway + smoothtime*startpos;
    #debug concat ("smoothtime = ", str(smoothtime,0,-1), "\n")

  #break

  #range (preambletime,endtime)
    #debug concat ("REGULAR TIME!", "\n")

    #declare camerapos = startpos;  // for now!

  #break
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
