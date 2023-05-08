/*
 *
 * sample call:
 *
 * povray +a einstein.pov Declare=htile=<htile> Declare=depth=<depth>
 *
 * where <htile> = either 7 or 8
 *
 */

#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "subdivision.inc"

#ifndef (depth) #declare depth = 2; #end
#ifndef (htile) #declare htile = 7; #end

#declare zoomfactor = 1/phi/phi;
#declare zoomfactor2 = 2.62;
#declare zoomfactor = pow (zoomfactor, depth);

#debug concat ("zoomfactor = ", str(zoomfactor,0,-1), "\n")
#debug concat ("zoomfactor2 = ", str(zoomfactor2,0,-1), "\n")

#declare gtras = zoomfactor/2.62*(4*x-0.2*z);

#if (htile = 7)
  h7rec (transform {scale 1.0 translate gtras}, depth)
  #declare onlyworm = 1;
  h7rec (transform {scale 1.0 translate gtras + h*y}, depth)
#else
  h8rec (transform {scale 1.0 translate gtras}, depth)
  #declare onlyworm = 1;
  h8rec (transform {scale 1.0 translate gtras + h*y}, depth)
#end

#ifdef (debug)
#if (depth = 0)
  sphere {
    <0,0,0>
    0.4
    pigment {color Black}
    translate gtras
  }
#end
#end

#declare lookatpos = <0,0,0>;
#declare mylocation = 0.9*zoomfactor*<0,10,0>;

#ifdef (panleft)
  //#declare lookatpos = -9*x;
  #declare lookatpos = -0.4*zoomfactor*x;
  #if (panleft >= 2)
    #declare lookatpos = -1.2*zoomfactor*x;
  #end
  #declare zoomfactor = zoomfactor/3;
  #declare mylocation = 0.8*zoomfactor*<0,10,0>;
  #if (panleft >= 2)
    #declare mylocation = mylocation - 3*zoomfactor*x;
  #end
#end

camera {
  location mylocation
  sky <0,0,1>
  look_at lookatpos
}

light_source { zoomfactor*<20, 20, -20> color White }
//light_source { 2*20*<1, 1, 1> color White }

#ifdef (sfondobianco)
  background {White}
#end
