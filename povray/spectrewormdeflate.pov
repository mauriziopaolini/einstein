/*
 * We try here to compare a tiling originating from a spectre (with given focus
 * described by its Conway signature), of which we only display boundaries, with
 * the result of reverting all tiles along the main worm and also rotating the
 * whole result with respect to the focus.
 *
 * The focus should be a tile along the worm, here the default for depth = 3 is
 * 246.
 */

#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "spectresubdivision.inc"
#include "spectreworm.inc"

#ifndef (depth) #declare depth = 3; #end // must coincide with the number of digits in signatures
#ifndef (tipsig) #declare tipsig = 333333; #end
#ifndef (focussig) #declare focussig=0; #end
//#ifndef (level) #declare level = 1; #end
#ifndef (SPid) #declare SPid = 1; #end
#ifndef (colors) #declare colors = depth; #end
#if (colors <= 0) #declare colors = depth + colors; #end
#ifndef (tailsig) #declare tailsig = 00000; #end
//#ifndef (tailsigw) #declare tailsigw = 00000; #end
//#ifndef (tailsigw2) #declare tailsigw2 = 00000; #end
#ifndef (dontshowall) #declare showall = 1; #end

#declare tipsig = mod (tipsig, pow(10,depth));
#debug concat ("tipsig: ", str(tipsig,0,-1), "\n")

#declare magstep = sqrt(4+sqrt(15));
#declare magdepth = pow (magstep, depth);
//#declare mag = magdepth;
#declare mag = 1;

#ifndef (zoomout) #declare zoomout=0; #end


#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

#declare gtras = transform {scale 1/magdepth translate -1*z};

#ifndef (wriggly) #declare wriggly = 0; #end

#if (mod (depth, 2) = 0)
  #declare gtras = transform {gtras scale <-1,1,1>}
  #declare wriggly = 1 - wriggly;
#end

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

#declare bdthick=0.2;
#if (SPid = 0)
  SPbmystic (transform {basetrinv translate lift gtras}, depth)
#else
  SPbspectre (transform {basetrinv translate lift gtras}, depth)
#end

#local lift = lift + tile_thick*y;

#ifdef (showall)
  SPwormrec (SPid, transform {basetrinv translate lift gtras}, depth)
  #local lift = lift + tile_thick*y;
#end

#declare wormi = 0;

#ifdef (tipsig)
  newwormtile (tipsig)
  #local sig = tipsig;
  #while (sig != tailsig & sig != 0)
    #local sig = prec_in_worm (sig,wriggly)
    #if (mod (sig,1000) = 0)
      #debug concat ("Milestone sig: ", str(sig,0,0), "\n")
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

/*
 * there is still a glitch (see spectreholepropellerw...)
 */

#ifdef (HACK)
  #local hack1 = 10;
  #local hack2 = 39;
  #local hack3 = 50;
#else
  #local hack1 = -1;
  #local hack2 = -2;
  #local hack3 = -3;
#end

#declare wormlen = wormi;
createworm (wormlen, transform {basetrinv translate lift gtras}, 0)

#if (wormlen > 0) #local lift = lift + tile_thick*y; #end

#local lift = lift + tile_thick*y;

#ifndef (nocyl)
  cylinder {
    0*y
    1.0*y
    0.4
    pigment {color Black}
    transform {gtras}
  }
#end

#declare lookatpos = <0,0,0>;
//#declare mylocation = 0.8*mag*<0,10,0>;
#declare mylocation = 7*mag*<0,1,0>;

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
