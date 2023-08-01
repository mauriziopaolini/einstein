/*
 *
 */

#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "spectresubdivision.inc"
#include "spectreworm.inc"

#ifndef (depth) #declare depth = 5; #end // must coincide with the number of digits in signatures
#ifndef (SPid) #declare SPid = 1; #end
#ifndef (tipsig) #declare tipsig = 33333; #end
#ifndef (tailsig) #declare tailsig = 00000; #end
//#ifndef (tipsig2) #declare tipsig2 = 63636; #end
//#ifndef (tailsig2) #declare tailsig2 = 04500; #end

#declare magstep = sqrt(4+sqrt(15));
#declare magdepth = pow (magstep, depth);
#declare mag = magdepth;

#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

//#declare gtras = 0*x - 1.5*mag*z;
#declare gtras = 0*x;

#ifdef (zoom) #declare zoomfactor = 1/zoom*zoomfactor; #end

worm_init (2000)
#declare wormi = 0;

#ifdef (focussig)
  newwormtile (focussig)
#else
  newwormtile (0)
#end

#declare basetr = wormtr[0];
#declare basetrinv = transform {basetr inverse}

#declare wormi = 0;

#ifdef (tipsig2)
  #ifndef (tailsig2) #declare tailsig2=0; #end
  #local sig = tipsig2;

  #debug concat ("tipsig2 = ", str(sig,0,0), "\n")

  #while (sig != tailsig2 & sig != 0)
    #local sig = prec_in_worm (sig)
    #if (mod (sig, 10) = 0)
      newwormtile (sig)
    #end
  #end
#end

//#local sig = prec_in_worm (sig)
//newwormtile (sig)
//#local sig = prec_in_worm (sig)
//newwormtile (sig)

//newwormtile (04040) // center!

#local sig = tipsig;
#while (sig != tailsig & sig != 0)
  #local sig = prec_in_worm (sig)
  #if (mod (sig,1000) = 0)
    #debug concat ("Milestone sig: ", str(sig,0,0), "\n")
  #end
  newwormtile (sig)
#end

#declare wormlen = wormi;

SPrec (SPid, transform {transform {basetrinv} translate gtras}, depth)
#ifdef (showall)
  SPwormrec (SPid, transform {transform {basetrinv} translate tile_thick*y translate gtras}, depth)
#end

#local i = 0;
#while (i < wormlen)
  object {
  #if (wormid[i] = 0) graymystic #else grayspectre #end
    transform wormtr[i]
    transform basetrinv
    translate gtras
    translate 2*tile_thick*y
  }
  #local i = i + 1;
#end

sphere {
  <0,0,0>
  0.4
  pigment {color Black}
  translate gtras
}

#declare lookatpos = <0,0,0>;
#declare mylocation = 0.8*mag*<0,10,0>;

#ifdef (panup)
  #declare lookatpos = lookatpos+magdepth*panup*z;
  #declare mylocation = mylocation+magdepth*panup*z;
#end

#ifdef (panright)
  #declare lookatpos = lookatpos+magdepth*panright*x;
  #declare mylocation = mylocation+magdepth*panright*x;
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
