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
#include "spectresubdivision.inc"

#ifndef (depth) #declare depth = 2; #end
#ifndef (htile) #declare htile = 2; #end

#declare zoomfactor = 1/phi/phi;
#declare zoomfactor2 = 2.62;
#declare zoomfactor = pow (zoomfactor, depth);

#debug concat ("zoomfactor = ", str(zoomfactor,0,-1), "\n")
#debug concat ("zoomfactor2 = ", str(zoomfactor2,0,-1), "\n")

#declare gtras = zoomfactor/2.62*(0*x-0*z);

#ifdef (zoom) #declare zoomfactor = 1/zoom*zoomfactor; #end

#declare prerot = array[maxdepth];
#declare prerot[0] = 0;
#declare prerot[1] = 30;
#declare prerot[2] = 30;

#declare pretransform = transform {scale 1.0};
#ifdef (fig22) #declare pretransform = transform {scale <-1,1,1> rotate 90*y rotate prerot[depth]*y}; #end

#if (htile = 1)
  spectrerec (transform {transform {pretransform} translate gtras}, depth)
//  #declare onlyworm = 1;
//  h7rec (transform {scale 1.0 translate gtras + h*y}, depth)
#else
  mysticrec (transform {transform {pretransform} translate gtras}, depth)
//  #declare onlyworm = 1;
//  h8rec (transform {scale 1.0 translate gtras + h*y}, depth)
#end

#ifdef (debug)
//#if (depth = 0)
  sphere {
    <0,0,0>
    0.4
    pigment {color Black}
    translate gtras
  }
//#end
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

#ifdef (panup)
  #declare lookatpos = +0.4*zoomfactor*z;
  #if (panup >= 2)
    #declare lookatpos = +1.2*zoomfactor*z;
  #end
  //#declare zoomfactor = zoomfactor/3;
  #declare mylocation = 0.8*zoomfactor*<0,10,0>;
  #if (panup >= 2)
    #declare mylocation = mylocation + 3*zoomfactor*z;
  #end
#end

plane {y, 0 
  texture {pigment {color <0,0,0>}}
}

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
