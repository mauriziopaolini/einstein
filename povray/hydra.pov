/*
 *
 */

#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "spectresubdivision.inc"
#include "spectreworm.inc"

#ifndef (depth) #declare depth = 5; #end // must coincide with the number of digits in signatures
#switch (depth)
  #case (5)
    #ifndef (tipsig) #declare tipsig = 63333; #end
    #ifndef (tipsigw) #declare tipsigw = 33333; #end
    #ifndef (focussig) #declare focussig=55555; #end
    #ifndef (focussig2) #declare focussig2=33333; #end
  #break
  #case (6)
    #ifndef (tipsig) #declare tipsig = 333333; #end
    #ifndef (tipsigw) #declare tipsigw = 633333; #end
    #ifndef (focussig) #declare focussig=555555; #end
    #ifndef (focussig2) #declare focussig2=333333; #end
  #break
#end
#ifndef (tailsig) #declare tailsig = 00000; #end
#ifndef (tailsig2) #declare tailsig2 = 00000; #end
#ifndef (tailsigw) #declare tailsigw = 00000; #end
#ifndef (tailsigw2) #declare tailsigw2 = 00000; #end
#ifndef (SPid) #declare SPid = 5; #end
#ifndef (rotworm)
  #declare rotworm = 180*clock;
#end

#ifndef (up2) #declare up2=05; #end
#ifndef (down2) #declare down2=27; #end

#macro build_up_down (upl, downl)
  #declare uptransf = transform {scale <1,1,1>}
  #declare downtransf = transform {scale <1,1,1>}
  #local dpth = 0;
  #while (upl != downl)
    #local uplhigh = int (upl/10);
    #local downlhigh = int (downl/10);
    #local upllow = upl - 10*uplhigh;
    #local downllow = downl - 10*downlhigh;
    #declare uptransf = transform {uptransf Str[upllow][dpth]}
    #declare downtransf = transform {downtransf Str[downllow][dpth]}
    #local upl = uplhigh;
    #local downl = downlhigh;
    #local dpth = dpth + 1;
  #end
#end

#declare magstep = sqrt(4+sqrt(15));
#declare magdepth = pow (magstep, depth);
#declare mag = magdepth;

#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

#ifndef (rot) #declare rot = -20; #end
#declare gtras = transform {rotate rot*y}

worm_init (2000)
#declare wormi = 0;

newwormtile (focussig)
newwormtile (focussig2)

#declare basetr = wormtr[0];
#declare basetrinv = transform {basetr inverse}
#declare basetr2 = wormtr[1];
#declare basetrinv2 = transform {basetr2 inverse}

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

build_up_down (up2, down2)
#declare uptransfinv = transform {uptransf inverse}
#declare placeit = transform {downtransf uptransfinv}

SProtcolorshue (360*phi)
SPbuildtiles ()
SPrec (SPid, transform {transform {basetrinv2 placeit} transform {gtras} translate lift}, depth)

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
    #if (mod (sig, 10) = 0)
      newwormtile (sig)
    #end
  #end
#end

#declare wormlen = wormi;

#local i = 0;
#while (i < wormlen)
  object {
    #if (wormid[i] = 0)
      graymystic
      #ifdef (rotworm)
        #local rotsign = 0;
        #if (wormid[i-1] = 5) #local rotsign = 1; #end
        #if (wormid[i-1] = 2) #local rotsign = -1; #end
        SProtmystic (rotsign*rotworm/180*120)
      #end
    #else
      grayspectre
      #ifdef (rotworm)
        SProtspectre (rotworm)
      #end
    #end
    transform wormtr[i]
    transform basetrinv
    transform {gtras}
    translate lift
  }
  #local i = i + 1;
#end

#if (wormlen > 0) #local lift = lift + tile_thick*y; #end

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
          SProtmysticw (rotsign*rotwormw/180*120)
        #end
      #else
        whitespectre
        #ifdef (rotwormw)
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
