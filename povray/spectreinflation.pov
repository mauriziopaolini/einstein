/*
 * usage:
 *  povray +a <self>.pov Declare=fase=<n>
 *
 *  The starting tiling is built based on the signature "[40]." but the idea is that it could resemble
 * a random tiling.
 *
 * a signature is a string of digits taken from
 * the set {0,1,2,3,4,5,6,7} and the pair 03 is forbidden
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
#ifndef (Sigl2) #declare Sigl2 = 040404; #end
#ifndef (Sigh2) #declare Sigh2 = 040404; #end
#ifndef (depth) #declare depth = 5; #end
#ifndef (zoomout) #declare zoomout = 2; #end

#ifndef (fase) #declare fase = 1; #end

#macro buildsigs (sigh, sigl, sigh2, sigl2)
  #local sig = sigl;
  #local sig2 = sigl2;
  #local i = 0;
  #while (i < 12)
    #local sigq = int(sig/10);
    #local sigq2 = int(sig2/10);
    #declare signature[i] = sig - 10*sigq;
    #declare signature2[i] = sig2 - 10*sigq2;
    #local i = i + 1;
    #local sig = sigq;
    #local sig2 = sigq2;
    #if (i = 6) #local sig = sigh; #local sig2 = sigh2; #end
  #end
#end

#declare signature = array[12]
#declare signature2 = array[12]
buildsigs (Sigh, Sigl, Sigh2, Sigl2)

//#declare darkenvalue = 0.5;

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

//#declare darkenvalue = 0.8;

#declare Seed=seed(123);

#macro rndcol (myseed)
  #declare rndpigment = <rand(myseed), rand(myseed), rand(myseed)>;
#end

#macro SPrec_infl (tid, trsf, depth)
  #local d = depth-1;
  #if (depth = 0)
    #if (tid = 0)
      object { tile11
        transform {mystic_tr}
        //texture {T_mystic finish {tile_Finish} }
        rndcol (Seed)
        texture {pigment {rgb rndpigment}} finish {tile_Finish}
        transform {trsf}
      }

      //object {mystic transform {trsf}}
    #end
    object {spectre
      //texture {pigment {SPpigment[1 + int(rand(Seed)*7)]}}
      rndcol (Seed)
      texture {pigment {rgb rndpigment}}
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

#macro SPrec_sparse (tid, trsf, depth)
  #local d = depth-1;
  #if (depth = 0)
    #if (tid = 0)
      object { tile11
        transform {mystic_tr}
        texture {T_mystic finish {tile_Finish} }
        //rndcol (Seed)
        //texture {pigment {rgb rndpigment}} finish {tile_Finish}
        transform {trsf}
      }

      //object {mystic transform {trsf}}
    #end
    object {spectre
      //texture {pigment {SPpigment[1 + int(rand(Seed)*7)]}}
      rndcol (Seed)
      texture {pigment {rgb rndpigment}}
      transform {trsf}
    }

  #else
    // SPrec (0, transform {Str[0][d] trsf}, d)
    #local i = 0;
    #while (i < 8)
      #if (tid != 0 | i != 3)
        SPrec_sparse (i, transform {Str[i][d+1] trsf}, d)
      #end
      #local i = i + 1;
    #end
    //#if (d >= colors-1) SProtcolorshue (deltahue) SPbuildtiles() #end
  #end
#end

#macro SPrec_infl2 (tid, trsf, depth, ptid)
  #local d = depth-1;
  #if (depth = 0)
    #if (fase >= 4)
      #if (tid != 0 & tid != 3)
        object { tile11
          texture {pigment {rgb darkenfactor*rndpigment}}
          finish {tile_Finish}
          transform {trsf}
        }
      #end
    #end
    #if (fase >= 5 & tid = 3 & ptid != 0)
        object { tile11
          texture {pigment {rgb 0.7*darkenfactor*rndpigment}}
          finish {tile_Finish}
          transform {trsf}
        }
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
    #if (fase >= 4 & d = 0) rndcol (Seed) #end
    #local i = 0;
    #while (i < 8)
      #if (tid != 0 | i != 3)
        SPrec_infl2 (i, transform {Str[i][d] trsf}, d, tid)
      #end
      #local i = i + 1;
    #end
  #end
#end


#macro SPrec_infl3 (tid, trsf, depth)
  #local d = depth-1;
  #if (depth = 1)
    rndcol (Seed)
    #if (tid = 0)
      object { mystic
        //texture {pigment {rgb rndpigment}}
        finish {tile_Finish}
        scale 1.5                          // ADJUST!
        transform {Str[0][0] trsf}
      }
    #else
      object { tile11
        texture {pigment {rgb rndpigment}}
        finish {tile_Finish}
        scale 1.5                          // ADJUST!
        transform {Str[0][0] trsf}
      }
    #end
  #else
    #local i = 0;
    #while (i < 8)
      #if (tid != 0 | i != 3)
        SPrec_infl3 (i, transform {Str[i][d] trsf}, d)
      #end
      #local i = i + 1;
    #end
  #end
#end



build_ttransinv (signature, depth)

#if (fase <= 4)
  SPrec_infl (htilex[depth], transform {ttransinv[depth] gtrans0}, depth)
#end
#if (fase >= 2 & fase <= 6)
  #declare Seed=seed(123);
  #declare darkenfactor = 1.0;
  #if (fase >= 6) #declare darkenfactor = 0.3; #end
  SPrec_infl2 (htilex[depth], transform {ttransinv[depth] gtrans0 translate 2*tile_thick*y}, depth, 1)
#end
#if (fase >= 6)
  #declare Seed=seed(123);
  SPrec_infl3 (htilex[depth], transform {ttransinv[depth] gtrans0 translate 4*tile_thick*y}, depth)
#end
#if (fase >= 7)
  build_ttransinv (signature2, depth - 1)
  #declare Seed=seed(123);
  //SPrec_sparse (htilex[depth-1], transform {ttransinv[depth-1] gtrans0 scale <-1,1,1> translate 6*tile_thick*y+0*(2*x+z)}, depth-1)
  SPrec_sparse (htilex[depth-1], transform {scale <-1,1,1> ttransinv[depth-1] gtrans0 translate 6*tile_thick*y-8.0*z+2.5*x}, depth-1)
#end
#if (fase >= 8)
  #declare Seed=seed(123);
  //SPrec_infl (htilex[depth-1], transform {ttransinv[depth-1] gtrans0 scale <-1,1,1> translate 6*tile_thick*y+20*(2*x-z)}, depth-1)
  SPrec_infl (htilex[depth-1], transform {ttransinv[depth-1] gtrans0 scale <-1,1,1> translate 8*tile_thick*y}, depth-1)
#end


//build_tiling (ttransinv, htilex, gtrans0, depth)

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
