/*
 *
 */

#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "spectresubdivision.inc"
#include "spectreworm.inc"

#ifndef (depth) #declare depth = 5; #end // must coincide with the number of digits in signatures

#ifdef (hydra2) // made of three partial tilings

  #switch (depth)
    #case (5)
      #ifndef (tipsig) #declare tipsig = 63333; #end
      #ifndef (tipsig2) #declare tipsig2 = 33333; #end
      #ifndef (tipsigw) #declare tipsigw = 33333; #end
      #ifndef (tipsigw3) #declare tipsigw3 = 33333; #end
      #ifndef (focussig) #declare focussig=0; #end
      #ifndef (focussig2) #declare focussig2=33333; #end
      #ifndef (focussig3) #declare focussig3=33333; #end
    #break
    #case (6)
      #ifndef (tipsig) #declare tipsig = 333333; #end
      //#ifndef (tipsig2) #declare tipsig2 = 633333; #end
      #ifndef (tipsig2) #declare tipsig2 = 333333; #end
      #ifndef (tipsigw) #declare tipsigw = 633333; #end
      #ifndef (tipsigw3) #declare tipsigw3 = 333333; #end
      #ifndef (focussig) #declare focussig=0; #end
      #ifndef (focussig2) #declare focussig2=333333; #end
      #ifndef (focussig3) #declare focussig3=333333; #end
    #break
  #end
  //#ifndef (SPid) #declare SPid = 0; #end
  #ifndef (SPid) #declare SPid = 1; #end
  #ifndef (SPid2) #declare SPid2 = 3; #end
  #ifndef (SPid3) #declare SPid3 = 3; #end
  #ifndef (up2) #declare up2=03; #end
  #ifndef (down2) #declare down2=02; #end
  #ifndef (up3) #declare up3=10; #end
  #ifndef (down3) #declare down3=06; #end
  #ifndef (rot) #declare rot = -20+180; #end

#else

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
  #ifndef (SPid) #declare SPid = 5; #end
  #ifndef (SPid2) #declare SPid2 = 3; #end
  #ifndef (up2) #declare up2=05; #end
  #ifndef (down2) #declare down2=27; #end
  #ifndef (rot) #declare rot = -20; #end

#end

#ifndef (tailsig) #declare tailsig = 00000; #end
#ifndef (tailsig2) #declare tailsig2 = 00000; #end
#ifndef (tailsigw) #declare tailsigw = 00000; #end
#ifndef (tailsigw2) #declare tailsigw2 = 00000; #end
#ifndef (tailsigw3) #declare tailsigw3 = 00000; #end
#ifndef (rotworm)
  #declare rotworm = 180*clock;
#end

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

#declare gtras = transform {rotate rot*y}

#declare whiterspectre = object { tile11
  texture {T_whitemysticb
    finish {tile_Finish}
  }
}

#declare whitermystic = object { tile11
  texture {T_whitemystic
    finish {tile_Finish}
  }
}

worm_init (2000)
#declare wormi = 0;

newwormtile (focussig)
newwormtile (focussig2)

#declare basetr = wormtr[0];
#declare basetrinv = transform {basetr inverse}
#declare basetr2 = wormtr[1];
#declare basetrinv2 = transform {basetr2 inverse}
#ifdef (focussig3)
  newwormtile (focussig3)
  #declare basetr3 = wormtr[2];
  #declare basetrinv3 = transform {basetr3 inverse}
#end

#declare SPobj[0] = object { tile11
  texture {T_mysticb
    finish {tile_Finish}
  }
}

#local lift = 0;

SPrec (SPid, transform {transform {basetrinv} transform {gtras} translate lift}, depth)

build_up_down (up2, down2)
#declare uptransfinv = transform {uptransf inverse}
#declare placeit2 = transform {downtransf uptransfinv}

SProtcolorshue (360*phi)
SPbuildtiles ()
SPrec (SPid2, transform {transform {basetrinv2 placeit2} transform {gtras} translate lift}, depth)

#ifdef (focussig3)
  build_up_down (up3, down3)
  #declare uptransfinv = transform {uptransf inverse}
  #declare placeit3 = transform {downtransf uptransfinv}

  SProtcolorshue (360*phi)
  SPbuildtiles ()
  SPrec (SPid3, transform {transform {basetrinv3 placeit3} transform {gtras} translate lift}, depth)
#end

#local lift = lift + tile_thick*y;

#ifdef (showall)
  SPwormrec (SPid, transform {transform {basetrinv} translate lift transform {gtras}}, depth)
  #ifdef (focussig2)
    SPwormrec (SPid2, transform {transform {basetrinv2 placeit2} translate lift transform {gtras}}, depth)
  #end
  #ifdef (focussig3)
    SPwormrec (SPid3, transform {transform {basetrinv3 placeit3} translate lift transform {gtras}}, depth)
  #end
  #local lift = lift + tile_thick*y;
#end

#ifdef (showallw)
  #declare wriggly = 1;
  SPwormrec (SPid, transform {transform {basetrinv} translate lift transform {gtras}}, depth)
  #ifdef (focussig2)
    SPwormrec (SPid2, transform {transform {basetrinv2 placeit2} translate lift transform {gtras}}, depth)
  #end
  #ifdef (focussig3)
    SPwormrec (SPid3, transform {transform {basetrinv3 placeit3} translate lift transform {gtras}}, depth)
  #end
  #local lift = lift + tile_thick*y;
  #declare wriggly = 0;
#end

#declare wormi = 0;

#ifdef (tipsigw)
  #declare wormi = 0;
  newwormtile (tipsigw)
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
        whitermystic
        #ifdef (rotwormw)
          #local rotsign = 0;
          #if (wormid[i-1] = 5) #local rotsign = 1; #end
          #if (wormid[i-1] = 2) #local rotsign = -1; #end
/* TODO see activityhole.pov for a possible implementation */
          SProtmysticw (rotsign*rotwormw/180*120)
        #end
      #else
        whiterspectre
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

#ifdef (tipsigw3)
#debug "SONO IN tipsigw3\n"
  #declare wormi = 0;
  newwormtile (tipsigw3)
  #local sig = tipsigw3;
  #while (sig != tailsigw3 & sig != 0)
    #local sig = prec_in_worm (sig,1)
    #if (mod (sig,1000) = 0)
      #debug concat ("Milestone sigw3: ", str(sig,0,0), "\n")
    #end
    newwormtile (sig)
  #end

  #declare wormlen = wormi;

  #local i = 0;
  #while (i < wormlen)
    object {
      #if (wormid[i] = 0)
        whitermystic
        #ifdef (rotwormw)
          #local rotsign = 0;
          #if (wormid[i-1] = 5) #local rotsign = 1; #end
          #if (wormid[i-1] = 2) #local rotsign = -1; #end
/* TODO see activityhole.pov for a possible implementation */
          SProtmysticw (rotsign*rotwormw/180*120)
        #end
      #else
        whiterspectre
        #ifdef (rotwormw)
/* TODO see activityhole.pov for a possible implementation */
          SProtspectrew (rotwormw)
        #end
      #end
      transform wormtr[i]
      transform {basetrinv3 placeit3}
      transform {gtras}
      translate lift
    }
    #local i = i + 1;
  #end
  #local lift = lift + tile_thick*y;
#end

#ifdef (tipsig2)
  #declare wormi = 0;
  newwormtile (tipsig2)
  #local sig = tipsig2;
  #while (sig != tailsig2 & sig != 0)
    #local sig = prec_in_worm (sig,0)
    #if (mod (sig,1000) = 0)
      #debug concat ("Milestone sig2: ", str(sig,0,0), "\n")
    #end
    newwormtile (sig)
  #end

  #declare wormlen = wormi;

  #local i = 0;
  #while (i < wormlen)
    object {
      #if (wormid[i] = 0)
        graymystic
        #ifdef (rotwormw)
          #local rotsign = 0;
          #if (wormid[i-1] = 5) #local rotsign = 1; #end
          #if (wormid[i-1] = 2) #local rotsign = -1; #end
/* TODO see activityhole.pov for a possible implementation */
          SProtmysticw (rotsign*rotwormw/180*120)
        #end
      #else
        grayspectre
        #ifdef (rotwormw)
/* TODO see activityhole.pov for a possible implementation */
          SProtspectrew (rotwormw)
        #end
      #end
      transform wormtr[i]
      transform {basetrinv2 placeit2}
      transform {gtras}
      translate lift
    }
    #local i = i + 1;
  #end
#end

#ifdef (tipsig)
  #declare wormi = 0;
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
