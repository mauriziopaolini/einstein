/*
 * usage:
 *  povray +a <self>.pov Declare=Sigh=xxxxxx Declare=Sigl=yyyyyy [Declare=depth=<depth>] [Declare=zoomout=<depth>]
 *
 *  resulting in a [rtol] signature: xxxxxxyyyyyy.
 *
 * x and y must belong to the set {0,1,2,3,4,5,6} and the pair 06 is forbidden
 *
 * other possible options:
 *  Declare=Sigh2=xxxxxx Declare=Sigl2=yyyyyy
 * includes a second tiling with the given signature
 *
 *  Declare=up2=xy Declare=down2=zt
 * transform the second tiling as if the first tiling were transformed with signature xy
 * and the second tiling with signature zt
 *
 * HEXAGONAL TILES VERSION
 */

#version 3.7;

global_settings { assumed_gamma 1.0 }

#ifndef (nohexagonal)
  #declare hexagonal=1;
#end

#include "colors.inc"
#include "skies.inc"
#include "shapes.inc"
#include "subdivision.inc"
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

#ifdef (special63)
  #declare Sigl2 = Sigl;
  #declare Sigh2 = Sigh;
  #declare Sigl3 = Sigl;
  #declare Sigh3 = Sigh;
  #local center63 = -4.0*x;
  #if (special63 = 36)
    #local center63 = -1.5*x-3*ap*z;
  #end
#end

#ifdef (down2)
  #ifndef (Sigl2) #declare Sigl2 = Sigl; #declare Sigh2 = Sigh; #end
#end

#ifdef (Sigl2)
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
#local i = 12;
#while (i > 0)
  #local i = i - 1;
  #local sigstring=concat(sigstring,str(signature[i],0,0))
#end
#local sigstring=concat(sigstring,".")

#debug concat("SIGNATURE: ", sigstring, "\n")

#ifndef (depth) #declare depth = 6; #end

#declare mag = pow(Phi*Phi,depth);
#ifdef (zoomout)
  #declare mag = pow(Phi*Phi,zoomout);
#end

#declare gtrans0 = transform {scale <1,1,1>}

#macro wormcolors (c70, c71, c72, c80, c81, c82)
  #declare h7worm = union {
    h7list (c70, c71, c72)
    texture {finish {tile_Finish}}
  }
  #declare h8worm = union {
    h8list (c80, c81, c82)
    texture {finish {tile_Finish}}
  }
#end

wormcolors (<0.3,0.3,0.5>, <0.5,0.5,0.8>, <0.6,0.6,0.9>,
            <0.4,0.4,0.4>, <0.6,0.6,0.7>, <0.6,0.6,0.9>)
#declare h7wormdark = h7worm;
#declare h8wormdark = h8worm;

wormcolors (<0,0,1>, <0,0.5,1>, <0.2,0.6,1>,
            <0,0,1>, <0,1,0.5>, <0.2,1,0.6>)
#declare h7wormblue = h7worm;
#declare h8wormblue = h8worm;
    
wormcolors (<1,1,0>, <1,0.5,0>, <1,0.6,0.2>,
            <1,1,0>, <0.5,1,0>, <0.6,1,0.2>)
#declare h7wormyellow = h7worm;
#declare h8wormyellow = h8worm;

#declare ttransinv = array[depth+1];
#declare htilex = array[depth+1];

//#declare h7c1 = <1,0,0>;
//#declare h7c2 = <1,0.5,0.5>;
//#declare h7c3 = <1,0.75,0.75>;
#declare h7c1 = <1,1,1>;
#declare h7c2 = <1,0,0>;
#declare h7c3 = <1,0.4,0.4>;
//#declare h8c1 = <0,1,0>;
//#declare h8c2 = <0.5,1,0.5>;
//#declare h8c3 = <0.75,1,0.75>;
#declare h8c1 = <1,1,1>;
#declare h8c2 = <1,0.4,0>;
#declare h8c3 = <1,0.4,0.4>;

#macro rotcol (col)
  <col.y, col.z, col.x>
#end

#macro rotcolors ()
  //#declare h7c1 = rotcol (h7c1);
  #declare h7c2 = rotcol (h7c2);
  #declare h7c3 = rotcol (h7c3);
  //#declare h8c1 = rotcol (h8c1);
  #declare h8c2 = rotcol (h8c2);
  #declare h8c3 = rotcol (h8c3);
#end

#macro build_ttransinv (signature, depth)
 #local dpth = 0;
 #while (dpth <= depth)

  #declare tiletrans = transform {scale <1,1,1>};
  #local i = 0;
  #while (i < dpth)
    #local rotx = rotvec[signature[dpth-i-1]];
    #local trnx = trnvec[signature[dpth-i-1]][dpth-i-1];
    #declare tiletrans = transform {rotate rotx*y translate trnx tiletrans}
    #local i = i + 1;
  #end

  #declare htilex[dpth] = 8;
  #if (signature[dpth] = 0) #declare htilex[dpth] = 7; #end
  #declare ttransinv[dpth] = transform {tiletrans inverse}
  #local dpth = dpth + 1;
 #end
#end

#macro build_tiling (ttransinv, htilex, gtrans0, depth)
 #local dpth = 0;
 #while (dpth <= depth)
  #local dimm = 1/(0.25*dpth+1);
  #declare h7m = union {
    h7list (dimm*h7c1, dimm*h7c2, dimm*h7c3)
  }
  #declare h8m = union {
    h8list (dimm*h8c1, dimm*h8c2, dimm*h8c3)
  }
  #if (htilex[dpth] = 8)
    h8rec
  #else
    h7rec
  #end
   (transform {ttransinv[dpth] gtrans0 translate 2*(depth-dpth)*tile_thick*y}, dpth)
  rotcolors ()
  #local dpth = dpth + 1;
 #end

 #declare onlyworm = 1;
 #declare h7worm = h7wormyellow;
 #declare h8worm = h8wormyellow;

 #local dpth = 0;
 #while (dpth <= depth)
  #if (htilex[dpth] = 8)
    h8rec
  #else
    h7rec
  #end
   (transform {ttransinv[dpth] gtrans0 translate (2*depth-2*dpth+1)*tile_thick*y}, dpth)

  #local dpth = dpth + 1;
 #end
 #undef onlyworm
#end

build_ttransinv (signature, depth)
build_tiling (ttransinv, htilex, gtrans0, depth)

cylinder {
  0*y, 20*tile_thick*y, 1.0
  pigment {color Black}
  finish {tile_Finish}
  transform gtrans0
}

#macro build_up_down (upl, downl)
  #declare uptransf = transform {scale <1,1,1>}
  #declare downtransf = transform {scale <1,1,1>}
  #local dpth = 0;
  #while (upl != downl)
    #local uplhigh = int (upl/10);
    #local downlhigh = int (downl/10);
    #local upllow = upl - 10*uplhigh;
    #local downllow = downl - 10*downlhigh;
    #declare uptransf = transform {uptransf rotate rotvec[upllow]*y translate trnvec[upllow][dpth]}
    #declare downtransf = transform {downtransf rotate rotvec[downllow]*y translate trnvec[downllow][dpth]}
    #local upl = uplhigh;
    #local downl = downlhigh;
    #local dpth = dpth + 1;
  #end
#end

#ifdef (signature2)
  #local sigstring2=""
  #local i = 12;
  #while (i > 0)
    #local i = i - 1;
    #local sigstring2=concat(sigstring2,str(signature2[i],0,0))
  #end
  #local sigstring2=concat(sigstring2,".")

  #ifndef (up2) #declare up2=0; #end
  #ifndef (down2) #declare down2=0; #end
  build_up_down (up2, down2)
  #declare uptransfinv = transform {uptransf inverse}
  #declare placeit = transform {downtransf uptransfinv}

  #ifdef (special63)
    #declare placeit = transform {
      translate -center63
      rotate 120*y
      translate center63
    }
  #end

  #local darken=0.5;
  #declare h7c2 = darken*h7c2;
  #declare h7c3 = darken*h7c3;
  #declare h8c2 = darken*h8c2;
  #declare h8c3 = darken*h8c3;
  build_ttransinv (signature2, depth)
  build_tiling (ttransinv, htilex, transform {placeit gtrans0}, depth)
  cylinder {
    0*y, 20*tile_thick*y, 1.0
    pigment {color Black}
    finish {tile_Finish}
    transform placeit
    transform gtrans0
  }
#end

#ifdef (signature3)
  #local sigstring3=""
  #local i = 12;
  #while (i > 0)
    #local i = i - 1;
    #local sigstring3=concat(sigstring3,str(signature3[i],0,0))
  #end
  #local sigstring3=concat(sigstring3,".")

  #ifndef (up3) #declare up3=0; #end
  #ifndef (down3) #declare down3=0; #end
  build_up_down (up3, down3)
  #declare uptransfinv = transform {uptransf inverse}
  #declare placeit = transform {downtransf uptransfinv}

  #ifdef (special63)
    #declare placeit = transform {
      translate -center63
      rotate -120*y
      translate center63
    }
  #end

  #local darken=0.5;
  #declare h7c2 = darken*h7c2;
  #declare h7c3 = darken*h7c3;
  #declare h8c2 = darken*h8c2;
  #declare h8c3 = darken*h8c3;
  build_ttransinv (signature3, depth)
  build_tiling (ttransinv, htilex, transform {placeit gtrans0}, depth)
  cylinder {
    0*y, 20*tile_thick*y, 1.0
    pigment {color Black}
    finish {tile_Finish}
    transform placeit
    transform gtrans0
  }
#end

#declare textfont = "LiberationMono-Regular.ttf"

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
