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
 */

#version 3.7;

global_settings { assumed_gamma 1.0 }

#ifdef (bdthick) #declare doboundary=1; #end

#include "colors.inc"
#include "skies.inc"
#include "shapes.inc"
#include "spectresubdivision.inc"
#include "ambiente.inc"

#ifndef (Sigl) #declare Sigl = 404040; #end
#ifndef (Sigh) #declare Sigh = 404040; #end
#ifndef (depth) #declare depth = 6; #end
#ifndef (zoomout) #declare zoomout = 2; #end

#ifndef (fase) #declare fase = 1; #end

#macro buildsig (sigh, sigl)
  #local sig = sigl;
  #local i = 0;
  #while (i < 12)
    #local sigq = int(sig/10);
    #declare signature[i] =
    sig - 10*sigq;
    #local i = i + 1;
    #local sig = sigq;
    #if (i = 6) #local sig = sigh; #end
  #end
#end

#ifdef (Sigl)
  #declare signature = array[12]
  #ifndef (Sigh) #declare Sigh=404040; #end
  buildsig (Sigh, Sigl)
#end

#ifndef (signature) #declare signature = array[12] {1,1,2,2,2,2,2,2,2,2,2,2} #end

#ifdef (down2)
  #ifndef (Sigl2) #declare Sigl2 = Sigl; #declare Sigh2 = Sigh; #end
#end

#declare darkenvalue = 0.5;

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

#declare Seed=seed(123);

#macro rndcol (myseed)
  #declare rndpigment = rgb <rand(myseed), rand(myseed), rand(myseed)>;
#end

#macro SPrec_infl (tid, trsf, depth)
  #local d = depth-1;
  #if (depth = 0)
    #if (tid = 0)
      object { tile11
        transform {mystic_tr}
        //texture {T_mystic finish {tile_Finish} }
        rndcol (Seed)
        texture {pigment {rndpigment}}
        transform {trsf}
      }

      //object {mystic transform {trsf}}
    #end
    object {spectre
      //texture {pigment {SPpigment[1 + int(rand(Seed)*7)]}}
      rndcol (Seed)
      texture {pigment {rndpigment}}
      transform {trsf}
    }

  #else
    // SPrec (0, transform {Str[0][d] trsf}, d)
    #local i = 0;
    #while (i < 8)
      #if (tid != 0 | i != 3)
        SPrec_infl (i, transform {Str[i][d] trsf}, d)
      #end
      #local i = i + 1;
    #end
    //#if (d >= colors-1) SProtcolorshue (deltahue) SPbuildtiles() #end
  #end
#end

#macro SPrec_infl2 (tid, trsf, depth, ptid)
//#debug concat ("SONO QUI:", str(depth,0,0), "\n")
  #local d = depth-1;
  #if (depth = 0)
    #if (fase >= 4)
      #if (tid != 0 & (tid != 3 | (fase >= 5 & ptid != 0)))
        object { tile11
          texture {pigment {rndpigment}}
          transform {trsf}
        }
      #end
    #end
    #if (tid = 0)
      object { tile11
        transform {mystic_tr}
        //texture {T_mystic finish {tile_Finish} }
        //rndcol (Seed)
        texture {T_mystic finish {tile_Finish} }
        transform {trsf}
      }
      object { tile11
        texture {T_mystic finish {tile_Finish} }
        transform {trsf}
      }
    #end
    #if (tid = 5 & fase = 2)
      object {spectre
        texture {T_mystic finish {tile_Finish} }
        transform {trsf}
      }
    #end
  #else
//#debug concat ("SONO QUI else:", str(depth,0,0), "\n")
    #local i = 0;
    #if (fase >= 4 & d = 0) rndcol (Seed) #end
    #while (i < 8)
      #if (tid != 0 | i != 3)
        SPrec_infl2 (i, transform {Str[i][d] trsf}, d, tid)
      #end
      #local i = i + 1;
    #end
  #end
#end



#macro build_tiling (ttransinv, htilex, gtrans0, depth)
  //#local dimm = 1/(0.25*depth+1);
  //SPbuildtiles ()

  #local i = 1;
  #while (i < 8)
    #declare SPobj[i] = object{spectre
      //texture {pigment {SPpigment[i]}}
      texture {pigment {SPpigment[3]}}
    }
    #local i = i + 1;
  #end

  SPrec_infl (htilex[depth], transform {ttransinv[depth] gtrans0}, depth)
  #if (fase >= 2)
    SPrec_infl2 (htilex[depth], transform {ttransinv[depth] gtrans0 translate 2*tile_thick*y}, depth, 1)
  #end

  //#ifdef (darkenit)
  //  SPdarkencolors (darkenvalue)
  //#else
  //  SProtcolorshue (360*phi)
  //#end
  //#ifdef (darkenit) SPdarkencolors (1/darkenvalue) #end
#end

build_ttransinv (signature, depth)
build_tiling (ttransinv, htilex, gtrans0, depth)

//#declare textfont = "LiberationMono-Regular.ttf"

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
