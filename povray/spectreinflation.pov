#version 3.7;

global_settings { assumed_gamma 1.0 }

//#ifdef (bdthick) #declare doboundary=1; #end

#include "colors.inc"
#include "skies.inc"
#include "shapes.inc"
#include "spectresubdivision.inc"
#include "ambiente.inc"

#declare Sigval=6;

#ifndef (depth) #declare depth = 6; #end
#declare magstep = sqrt(4+sqrt(15));
#declare mag = pow (magstep, depth);
#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

#declare gtrans0 = transform {scale <1,1,1>}

#declare tiletrans = transform {scale <1,1,1>};
#local i = 0;
#while (i < depth)
  #local strx = Str[Sigval][depth-i-1];
  #declare tiletrans = transform {strx tiletrans}
  #local i = i + 1;
#end

#declare htilex = Sigval;
#declare ttransinv = transform {tiletrans inverse}

#macro build_tiling (htilex, gtrans0, depth)
  SPbuildtiles ()
  SPrec (htilex, transform {ttransinv gtrans0}, depth)
  #ifdef (bdthick) SPbgen (htilex, transform {ttransinv gtrans0 translate tile_thick*y}, depth) #end
  SProtcolorshue (360*phi)
#end

#declare placeit1 = transform {scale <1,1,1>}

#declare uptransf = transform {Str[6][0]}
#declare uptransf = transform {uptransf Str[0][1]}
#declare downtransf = transform {Str[7][0]}
#declare downtransf = transform {downtransf Str[2][1]}
#declare uptransfinv = transform {uptransf inverse}
#declare placeit2 = transform {downtransf uptransfinv}

#declare uptransf = transform {Str[1][0]}
#declare uptransf = transform {uptransf Str[0][1]}
#declare downtransf = transform {Str[1][0]}
#declare downtransf = transform {downtransf Str[7][1]}
#declare uptransfinv = transform {uptransf inverse}
#declare placeit3 = transform {downtransf uptransfinv}

build_tiling (htilex, transform {placeit1 gtrans0}, depth)
build_tiling (htilex, transform {placeit2 gtrans0}, depth)
build_tiling (htilex, transform {placeit3 gtrans0}, depth)

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
