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
#ifndef (signature) #declare signature = array[12] {1,1,2,2,2,2,2,2,2,2,2,2} #end

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

#local dpth = 0;
#while (dpth <= depth)

  #declare tiletrans = transform {scale <1,1,1>};
  #local i = 0;
  #while (i < dpth)
    #switch (signature[dpth-i-1])
      #case (0)
        #local rotx = rot0;
        #local trnx = trn0[dpth-i-1];
      #break
      #case (1)
        #local rotx = rot1;
        #local trnx = trn1[dpth-i-1];
      #break
      #case (2)
        #local rotx = rot2;
        #local trnx = trn2[dpth-i-1];
      #break
      #case (3)
        #local rotx = rot3;
        #local trnx = trn3[dpth-i-1];
      #break
      #case (4)
        #local rotx = rot4;
        #local trnx = trn4[dpth-i-1];
      #break
      #case (5)
        #local rotx = rot5;
        #local trnx = trn5[dpth-i-1];
      #break
      #case (6)
        #local rotx = rot6;
        #local trnx = trn6[dpth-i-1];
      #break
      #else
        #local rotx = 15;  // just a random invalid value
        #local trnx = <0,0,0>;
      #break
    #end
    //#declare tiletrans = transform {rotate rot2*y translate trn2[depth-i-1] tiletrans}
    #declare tiletrans = transform {rotate rotx*y translate trnx tiletrans}
    #local i = i + 1;
  #end

  #declare htilex[dpth] = 8;
  #if (signature[dpth] = 0) #declare htilex[dpth] = 7; #end
#local vvv = vtransform (<0,0,0>,tiletrans);
#debug concat("================= depth: ", str(dpth,0,0), " tiletrans:   ", str(vvv.x,0,-1), "\n")
  #declare ttransinv[dpth] = transform {tiletrans inverse}
  #local dpth = dpth + 1;
#end
//#declare tiletransinv = transform {tiletrans inverse}

/*
object {
  #if (htilex[0] = 8)
    h8wormdark
  #else
    h7wormdark
  #end
  transform gtrans0
  translate 2*tile_thick*y
}
 */

#local h7c1 = <1,0,0>;
#local h7c2 = <1,0.5,0.5>;
#local h7c3 = <1,0.75,0.75>;
#local h8c1 = <0,1,0>;
#local h8c2 = <0.5,1,0.5>;
#local h8c3 = <0.75,1,0.75>;

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
   (transform {ttransinv[dpth] gtrans0 translate (depth-dpth)*tile_thick*y}, dpth)
  #local dpth = dpth + 1;
#end

#declare onlyworm = 1;
#declare h7worm = h7wormyellow;
#declare h8worm = h8wormyellow;
h8rec (transform {ttransinv[depth] gtrans0 translate 0.5*tile_thick*y}, depth)

#declare skycam = y;
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
