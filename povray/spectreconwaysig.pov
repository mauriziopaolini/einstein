/*
 * usage:
 *  povray +a <self>.pov Declare=Sigh=xxxxxx Declare=Sigl=yyyyyy [Declare=depth=<depth>] [Declare=zoomout=<depth>]
 *
 *  resulting in a [rtol] signature: xxxxxxyyyyyy.
 *
 * x and y must belong to the set {0,1,2,3,4,5,6,7} and the pair 03 is forbidden
 *
 * other possible options:
 *  Declare=Sigh2=xxxxxx Declare=Sigl2=yyyyyy
 * includes a second tiling with the given signature
 *
 *  Declare=up2=xy Declare=down2=zt
 * transform the second tiling as if the first tiling were transformed with signature xy
 * and the second tiling with signature zt
 *
 * To get the relative positioning of the base tiles of two tilings corresponding to given values
 * of up2 and down2 you can use options "Declare=depth=0 Declare=zoomout=0.7 Declare=bdthick=0.1"
 *
 * some useful values of up2 and down2 are:
 *  04 27          : back-to-back
 *  05 27 or 27 05 : head-to-nape
 *  06 27 or 27 06 : head-to-throath
 *  03 02 or 02 03 : tower
 */

#version 3.7;

global_settings { assumed_gamma 1.0 }

#ifdef (bdthick) #declare doboundary=1; #end

#include "colors.inc"
#include "skies.inc"
#include "shapes.inc"
#include "spectresubdivision.inc"
#include "ambiente.inc"

#macro buildsig (sigh, sigl)
  #local sig = sigl;
  #local i = 0;
  #while (i < 12)
    #local sigq = int(sig/10);
    #ifdef (signature3)
      #declare signature3[i] =
    #else
      #ifdef (signature2)
        #declare signature2[i] =
      #else
        #declare signature[i] =
      #end
    #end
    sig - 10*sigq;
    //#debug concat("==== BUILDING... signature[", str(i,0,0), "] = ", str(signature[i],0,0), "\n")
    #local i = i + 1;
    #local sig = sigq;
    #if (i = 6) #local sig = sigh; #end
  #end
#end

#ifdef (Sigl)
  #declare signature = array[12]
  #ifndef (Sigh) #declare Sigh=222222; #end
  buildsig (Sigh, Sigl)
#end

#ifndef (signature) #declare signature = array[12] {1,1,2,2,2,2,2,2,2,2,2,2} #end

#ifdef (down2)
  #ifndef (Sigl2) #declare Sigl2 = Sigl; #declare Sigh2 = Sigh; #end
#end

#declare darkenvalue = 0.5;
#ifdef (Sigl2)
  //#declare darkenvalue = 0.8;
  //#declare darkenit = 1;
  #declare signature2 = array[12]
  #ifndef (Sigh2) #declare Sigh2=222222; #end
  buildsig (Sigh2, Sigl2)
#end
#ifdef (Sigl3)
  #declare signature3 = array[12]
  #ifndef (Sigh3) #declare Sigh3=222222; #end
  buildsig (Sigh3, Sigl3)
#end

#local sigstring=""
#local i = depth+1;
#while (i > 0)
  #local i = i - 1;
  #local sigstring=concat(sigstring,str(signature[i],0,0))
#end

#local sigstring=concat("...", sigstring,".")

#debug concat("SIGNATURE: ", sigstring, "\n")

#ifndef (depth) #declare depth = 5; #end

#declare magstep = sqrt(4+sqrt(15));
#declare mag = pow (magstep, depth);

#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

#declare gtrans0 = transform {scale <1,1,1>}

#declare ttransinv = array[depth+1];
#declare htilex = array[depth+1];

#macro build_ttransinv (signature, depth)
 #local dpth = 0;
 #while (dpth <= depth)

  #declare tiletrans = transform {scale <1,1,1>};
  #local i = 0;
  #while (i < dpth)
    #local strx = Str[signature[dpth-i-1]][dpth-i-1];
    #declare tiletrans = transform {strx tiletrans}
    #local i = i + 1;
  #end

  #declare htilex[dpth] = signature[dpth];
  #declare ttransinv[dpth] = transform {tiletrans inverse}
  #local dpth = dpth + 1;
 #end
#end

#declare darkenvalue = 0.8;

#macro build_tiling (ttransinv, htilex, gtrans0, depth)
  #local dpth = 0;
  #while (dpth <= depth)
    #local dimm = 1/(0.25*dpth+1);
    SPbuildtiles ()
    SPrec (htilex[dpth], transform {ttransinv[dpth] gtrans0 translate 2*(depth-dpth)*tile_thick*y}, dpth)

    #ifdef (drawworm) SPwormrec (htilex[dpth], transform {ttransinv[dpth] gtrans0 translate 2*(depth-dpth+1)*tile_thick*y}, dpth) #end
    #ifdef (drawwormw)
      #declare wriggly=1;
      SPwormrec (htilex[dpth], transform {ttransinv[dpth] gtrans0 translate 2*(depth-dpth+1)*tile_thick*y}, dpth)
      #declare wriggly=0;
    #end
    #ifdef (darkenit)
      SPdarkencolors (darkenvalue)
    #else
      SProtcolorshue (360*phi)
    #end
    #local dpth = dpth + 1;
  #end
  #ifdef (doboundary) SPbgen (htilex[depth], transform {ttransinv[depth] gtrans0 translate (2*depth)*tile_thick*y}, depth) #end
  #ifdef (darkenit)
    #local dpth = 0;
    #while (dpth <= depth)
      SPdarkencolors (1/darkenvalue)
      #local dpth = dpth + 1;
    #end
  #end
#end

build_ttransinv (signature, depth)
build_tiling (ttransinv, htilex, gtrans0, depth)

#local cylradius = 1.0;
#if (zoomout = 3) #local cylradius = 5; #end

#declare textfont = "LiberationMono-Regular.ttf"

#ifndef (nocyl)
  #if (depth > 0)
    cylinder {
      0*y, 20*tile_thick*y, cylradius
      pigment {color Black}
      finish {tile_Finish}
      transform gtrans0
    }
  #else
    text {ttf textfont str(down2,0,0) 0.02, 0
      rotate 90*x
      scale 0.5*mag*<1,1,1>
      pigment {color Black}
      transform gtrans0
      translate 20*y
    }
  #end
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

#ifdef (signature2)
  #local sigstring2=""
  #local i = depth+1;
  #while (i > 0)
    #local i = i - 1;
    #local sigstring2=concat(sigstring2,str(signature2[i],0,0))
  #end
  #local sigstring2=concat("...",sigstring2,".")

  #ifndef (up2) #declare up2=0; #end
  #ifndef (down2) #declare down2=0; #end
  #local up2s = up2;
  build_up_down (up2, down2)
  #declare uptransfinv = transform {uptransf inverse}
  #declare placeit = transform {downtransf uptransfinv}
  #ifdef (darkenit)
    SProtcolorshue (360*phi)
  #else
    SPdarkencolors (darkenvalue)
  #end
  build_ttransinv (signature2, depth)
  build_tiling (ttransinv, htilex, transform {placeit gtrans0}, depth)
  #ifndef (nocyl)
    #if (depth > 0)
      cylinder {
        0*y, 20*tile_thick*y, 1.0
        pigment {color Black}
        finish {tile_Finish}
        transform placeit
        transform gtrans0
      }
    #else
      text {ttf textfont str(up2s,0,0) 0.02, 0
        rotate 90*x
        scale 0.5*mag*<1,1,1>
        pigment {color Blue}
        transform placeit
        transform gtrans0
        translate 20*y
      }
    #end
  #end
#end

#ifdef (signature3)
  #local sigstring3=""
  #local i = depth+1;
  #while (i > 0)
    #local i = i - 1;
    #local sigstring3=concat(sigstring3,str(signature3[i],0,0))
  #end
  #local sigstring3=concat("...",sigstring3,".")

  #ifndef (up3) #declare up3=0; #end
  #ifndef (down3) #declare down3=0; #end
  build_up_down (up3, down3)
  #declare uptransfinv = transform {uptransf inverse}
  #declare placeit = transform {downtransf uptransfinv}
  SPdarkencolors (darkenvalue)
  build_ttransinv (signature3, depth)
  build_tiling (ttransinv, htilex, transform {placeit gtrans0}, depth)
  #ifndef (nocyl)
    cylinder {
      0*y, 20*tile_thick*y, 1.0
      pigment {color Black}
      finish {tile_Finish}
      transform placeit
      transform gtrans0
    }
  #end
#end

#if (depth > 0)
  text {ttf textfont sigstring 0.02, 0
    rotate 90*x
    scale 0.5*mag*<1,1,1>
    pigment {color Black}
    translate mag*(-4*x+3*z)
    translate 20*y
    no_shadow
  }

  #ifdef (sigstring2)
    text {ttf textfont sigstring2 0.02, 0
      rotate 90*x
      translate -z
      scale 0.5*mag*<1,1,1>
      pigment {color Black}
      translate mag*(-4*x+3*z)
      translate 20*y
      no_shadow
    }
  #end

  #ifdef (sigstring3)
    text {ttf textfont sigstring3 0.02, 0
      rotate 90*x
      translate -2*z
      scale 0.5*mag*<1,1,1>
      pigment {color Black}
      translate mag*(-4*x+3*z)
      translate 20*y
      no_shadow
    }
  #end
#end

background {White}

#declare skycam = z;
#declare camerapos = 30*mag*y;
//#declare camerapos = 600*y;
#declare lookatpos = <0,0,0>;

camera {
  #ifdef (AspectWide)
    angle 20*4/3
    right 16/9*x
  #else
    angle 20
  #end
  location camerapos
  look_at lookatpos
  sky skycam
}

light_source { 100*<20, 20, -20> color White }
//light_source { 2*20*<1, 1, 1> color White }
  
#ifdef (sfondobianco) 
  background {White}
#end
