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
#ifndef (colors) #declare colors = depth; #end
#if (colors <= 0) #declare colors = depth + colors; #end
//#ifndef (tipsig) #declare tipsig = 33333; #end
#ifndef (tailsig) #declare tailsig = 00000; #end
#ifndef (tailsig2) #declare tailsig2 = 00000; #end
#ifndef (tailsigw) #declare tailsigw = 00000; #end
#ifndef (tailsigw2) #declare tailsigw2 = 00000; #end
#ifndef (rotworm)
  #declare rotworm = 180*clock;
#end
//#ifndef (tipsig2) #declare tipsig2 = 63636; #end
//#ifndef (tailsig2) #declare tailsig2 = 04500; #end

#declare magstep = sqrt(4+sqrt(15));
#declare magdepth = pow (magstep, depth);
#declare mag = magdepth;

#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

//#declare gtras = 0*x - 1.5*mag*z;
#declare gtras = transform {rotate 0*y};
#ifdef (rot) #declare gtras = transform {rotate rot*y} #end

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

#local lift = 0;

SPrec (SPid, transform {transform {basetrinv} transform {gtras} translate lift}, depth)
#local lift = lift + tile_thick*y;

#ifdef (showall)
  SPwormrec (SPid, transform {transform {basetrinv} translate lift transform {gtras}}, depth)
  #local lift = lift + tile_thick*y;
#end

#ifdef (showallw)
  #declare wriggly = 1;
  SPwormrec (SPid, transform {transform {basetrinv} translate lift transform {gtras}}, depth)
  #local lift = lift + tile_thick*y;
  #declare wriggly = 0;
#end

#declare wormi = 0;

#ifdef (tipsig)
  newwormtile (tipsig)
  #local sig = tipsig;
  #while (sig != tailsig & sig != 0)
    #local sig = prec_in_worm (sig,0)
    #if (mod (sig,1000) = 0)
      #debug concat ("Milestone sig: ", str(sig,0,0), "\n")
    #end
    newwormtile (sig)
  #end
#end

#ifdef (tipsig2)
  newwormtile (tipsig2)
  #local sig = tipsig2;
  #while (sig != tailsig2 & sig != 0)
    #local sig = prec_in_worm (sig,0) // 0: less wriggly
    #if (mod (sig,1000) = 0)
      #debug concat ("Milestone sig2: ", str(sig,0,0), "\n")
    #end
    newwormtile (sig)
  #end
#end

#macro createworm (wormlen, ltrans, rotworm)
  #local i = 0;
  #while (i < wormlen)
    object {
      #if (wormid[i] = 0)
        graymystic
        #if (rotworm != 0)
          #local rotsign = 0;
          #if (wormid[i-1] = 5) #local rotsign = 1; #end
          #if (wormid[i-1] = 2) #local rotsign = -1; #end
          SProtmystic (rotsign*rotworm/180*120)
        #end
      #else
        grayspectre
        #if (rotworm != 0)
          SProtspectre (rotworm)
        #end
      #end
      transform {wormtr[i]}
      transform {ltrans}
    }
    #local i = i + 1;
  #end
#end

#declare wormlen = wormi;
#ifndef (rotworm) #declare rotworm = 0; #end
createworm (wormlen, transform {basetrinv gtras translate lift}, rotworm)

#ifdef (tipsig3)
  #declare wormi = 0;
  newwormtile (tipsig3)
  #local sig = tipsig3;
  #while (sig != tailsig3 & sig != 0)
    #local sig = prec_in_worm (sig,0) // 0: less wriggly
    #if (mod (sig,1000) = 0)
      #debug concat ("Milestone sig2: ", str(sig,0,0), "\n")
    #end
    newwormtile (sig)
  #end

  #declare wormlen = wormi;
  #ifndef (rotworm3) #declare rotworm3 = 0; #end
  createworm (wormlen, transform {basetrinv gtras translate lift}, rotworm3)

#end

#if (wormlen > 0) #local lift = lift + tile_thick*y; #end

/*
 * allow the third worm to be rotated independently
 * This allows to get the symmetric tripod using
 *
 * Declare=depth=5 Declare=tipsig=33333 Declare=tailsig=4042 Declare=focussig=04040
 *    Declare=tipsig2=63333 Declare=tailsig2=4045 Declare=tipsig3=4056 Declare=tailsig3=0 Declare=rotworm3=180
 */

#ifdef (tipsigw)
  newwormtile (tipsigw)
  #declare wormi = 0;
  #local sig = tipsigw;
  #while (sig != tailsigw & sig != 0)
    #local sig = prec_in_worm (sig,1)
    #if (mod (sig,1000) = 0)
      #debug concat ("Milestone sigw: ", str(sig,0,0), "\n")
    #end
    newwormtile (sig)
  #end

  #declare wormlen = wormi;

  #local i = 0;
  #while (i < wormlen)
    object {
      #if (wormid[i] = 0)
        whitemystic
        #ifdef (rotwormw)
          #local rotsign = 0;
          #if (wormid[i-1] = 5) #local rotsign = 1; #end
          #if (wormid[i-1] = 2) #local rotsign = -1; #end
/* TODO see activityhole.pov for a possible implementation */
          SProtmysticw (rotsign*rotwormw/180*120)
        #end
      #else
        whitespectre
        #ifdef (rotwormw)
/* TODO see activityhole.pov for a possible implementation */
          SProtspectrew (rotwormw)
        #end
      #end
      transform wormtr[i]
      transform basetrinv
      transform {gtras}
      translate lift
    }
    #local i = i + 1;
  #end
  #local lift = lift + tile_thick*y;
#end

#ifdef (tipsigw2)
  newwormtile (tipsigw2)
  #declare wormi = 0;
  #local sig = tipsigw2;
  #while (sig != tailsigw2 & sig != 0)
    #local sig = prec_in_worm (sig,1)
    #if (mod (sig,1000) = 0)
      #debug concat ("Milestone sigw2: ", str(sig,0,0), "\n")
    #end
    newwormtile (sig)
  #end

  #declare wormlen = wormi;

  #local i = 0;
  #while (i < wormlen)
    object {
      #if (wormid[i] = 0)
        whitemystic
        #ifdef (rotwormw)
          #local rotsign = 0;
          #if (wormid[i-1] = 5) #local rotsign = 1; #end
          #if (wormid[i-1] = 2) #local rotsign = -1; #end
/* TODO see activityhole.pov for a possible implementation */
          SProtmysticw (rotsign*rotwormw/180*120)
        #end
      #else
        whitespectre
        #ifdef (rotwormw)
/* TODO see activityhole.pov for a possible implementation */
          SProtspectrew (rotwormw)
        #end
      #end
      transform wormtr[i]
      transform basetrinv
      transform {gtras}
      translate lift
    }
    #local i = i + 1;
  #end
  #local lift = lift + tile_thick*y;
#end

cylinder {
  0*y
  1.0*y
  0.4
  pigment {color Black}
  transform {gtras}
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
