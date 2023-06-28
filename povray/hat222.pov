/*
 * Display the result of "[222]." Conway signature
 */

#version 3.7;

global_settings { assumed_gamma 1.0 }

#include "colors.inc"
#include "skies.inc"
#include "shapes.inc"
#include "subdivision.inc"
#include "ambiente.inc"
//#include "yellow_brick_road_include.inc"

#ifndef (depth) #declare depth = 6; #end

#declare mag = pow(Phi*Phi,depth); 
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

#declare tiletrans = transform {scale <1,1,1>};
#local i = 0;
#while (i < depth)
  #declare tiletrans = transform {rotate rot2*y translate trn2[depth-i-1] tiletrans}
  #local i = i + 1;
#end

#declare tiletransinv = transform {tiletrans inverse}

object {h8wormdark
  //transform tiletransinv
  //transform tiletrans
  transform gtrans0
  translate 2*tile_thick*y
}

/*
object {h8wormdark
  transform tiletransinv
  transform gtrans0
  translate 2*tile_thick*y
}
 */

h8rec (transform {tiletransinv gtrans0}, depth)
#declare onlyworm = 1;
#declare h7worm = h7wormyellow;
#declare h8worm = h8wormyellow;
h8rec (transform {tiletransinv gtrans0 translate tile_thick*y}, depth)

#declare skycam = y;
//#declare camerapos = 30*mag*y;
#declare camerapos = 600*y;
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
