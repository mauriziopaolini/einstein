#version 3.7;

global_settings { assumed_gamma 1.0 }

#include "colors.inc"
#include "skies.inc"
#include "shapes.inc"
#include "spectresubdivision.inc"
#include "ambiente.inc"

#ifndef (depth) #declare depth = 0; #end
//#ifndef (fdepth) #declare fdepth = 0; #end
#ifndef (numsectors) #declare numsectors = 6; #end

#declare magstep = sqrt(4+sqrt(15));
#declare mag = pow (magstep, depth);

#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

#declare gtrans0 = transform {translate 4*x-3*z}

#ifdef (alt)
  #local gtr0 = transform {Str[7][0] inverse}
  #local gtr0 = transform {gtr0 rotate 30*y translate 2*z}
#else
  #local gtr0 = transform {Str[1][0] inverse}
  #local gtr0 = transform {gtr0 rotate -30*y translate -x-z rotate 30*y translate -2*z}
#end
#local gtr0 = transform {gtr0 rotate -120*y}
#ifdef (mirror) #local gtr0 = transform {gtr0 scale <1,1,-1> rotate -60*y} #end

sphere {
  4*tile_thick*y, 0.5
  texture {pigment {color Black}}
}

#local darkenvalue = 0.8;

/*
 * this should be a part of [0]. partial tiling where
 * the last symbol alternates between "1" and "6+7"
 */

#local isodd = mod (depth,2);
#ifdef (alt) #local isodd = 1 - isodd; #end
#local height = 0*y;

#local tiletransinv = transform {scale <1,1,1>}
#if (isodd) #local tiletransinv = transform {scale <-1,1,1>} #end
//#ifdef (mirror) #local tiletransinv = transform {tiletransinv scale <-1,1,1>} #end

/*
 * print a complete [0].
 * just as a background
 *
 * we rely here to the fact that Str[0][*] = scale <-1,1,1>

SPrec (0, transform {tiletransinv gtr0}, depth)
SProtcolorshue (phi*360)
SPbuildtiles ()

 */

#local height = height + tile_thick*y;
#local dpth = depth-1;
#while (dpth >= 0)
  #local i = 0;
  #while (i < numsectors)
    #if (isodd)
      SPrec (1, transform {Str[1][dpth] tiletransinv gtr0 rotate -i*60*y translate height}, dpth)
    #else
      SPrec (6, transform {Str[6][dpth] tiletransinv gtr0 rotate -i*60*y translate height}, dpth)
      SPrec (7, transform {Str[7][dpth] tiletransinv gtr0 rotate -i*60*y translate height}, dpth)
    #end
    SPdarkencolors (darkenvalue)
    SPbuildtiles ()
    #local i = i+1;
  #end
  #local i = 0;
  #while (i < numsectors)
    SPdarkencolors (1/darkenvalue)
    #local i = i+1;
  #end
  SProtcolorshue (phi*360)
  SPbuildtiles ()
  #local height = height + tile_thick*y;
  #local isodd = 1 - isodd;
  #local tiletransinv = transform {tiletransinv scale <-1,1,1>}
  #local dpth = dpth - 1;
#end

background {White}

#declare skycam = z;
#declare camerapos = 15*mag*y;
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
