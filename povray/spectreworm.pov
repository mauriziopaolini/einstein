/*
 *
 */

#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "spectresubdivision.inc"
#include "spectreworm.inc"

#ifndef (depth) #declare depth = 5; #end
#ifndef (SPid) #declare SPid = 1; #end

#declare magstep = sqrt(4+sqrt(15));
#declare mag = pow (magstep, depth);

#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

//#declare gtras = -300*x+250*z;
#declare gtras = 0*x - 400*z;
//#declare gtras = 0*x;

#ifdef (zoom) #declare zoomfactor = 1/zoom*zoomfactor; #end

worm_init (500)

//#declare depth = 5; // must coincide with the number of digits in signatures

#declare startsig = 63636;
#declare wormi = 0;

newwormtile (startsig)

#declare basetr = wormtr[0];
#declare basetrinv = transform {basetr inverse}

#local sig = startsig;

#debug concat ("startsig = ", str(startsig,0,0), "\n")

#while (sig != 04500)
  #local sig = prec_in_worm (sig)
  #if (mod (sig, 10) = 0)
    newwormtile (sig)
  #end
#end

#local sig = prec_in_worm (sig)
newwormtile (sig)
#local sig = prec_in_worm (sig)
newwormtile (sig)

#debug concat ("sig = ", str(sig,0,0), "\n")

//newwormtile (04040) // center!

#local sig = 33333;
#while (sig != 00000)
  #local sig = prec_in_worm (sig)
  newwormtile (sig)
#end

#declare wormlen = wormi;

SPrec (SPid, transform {transform {basetrinv} translate gtras}, depth)
//SPwormrec (SPid, transform {transform {basetrinv} translate tile_thick*y translate gtras}, depth)

#local i = 0;
#while (i < wormlen)
//#while (i < 0)
  object {
  #if (wormid[i] = 0) yellowmystic #else yellowspectre #end
    transform wormtr[i]
    transform basetrinv
    translate gtras
    translate 2*tile_thick*y
  }
  #local i = i + 1;
#end

//object {
//#if (wormid[0] = 0) yellowmystic #else yellowspectre #end
//  transform wormtr[1]
//  transform basetrinv
//}

sphere {
  <0,0,0>
  0.4
  pigment {color Black}
  translate gtras
}

#declare lookatpos = <0,0,0>;
#declare mylocation = 0.8*mag*<0,10,0>;

#ifdef (panleft)
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
  #declare lookatpos = lookatpos+panup*z;
  #declare mylocation = mylocation+panup*z;
#end

camera {
  location mylocation
  sky <0,0,1>
  look_at lookatpos
}

light_source { mag*<20, 20, -50> color White }
light_source { mag*<-50, 100, -100> color 0.5*White }
//light_source { 2*20*<1, 1, 1> color White }

background {White}
