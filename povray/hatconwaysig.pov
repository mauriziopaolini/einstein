/*
 * usage:
 *  povray +a <self>.pov Declare=Sigh=xxxxxx Declare=Sigl=yyyyyy [Declare=depth=<depth>] [Declare=zoomout=<depth>]
 *
 *  resulting in a [rtol] signature: xxxxxxyyyyyy.
 *
 * x and y must belong to the set {0,1,2,3,4,5,6} and the pair 06 is forbidden
 *
 */

#version 3.7;

global_settings { assumed_gamma 1.0 }

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
    #declare signature[i] = sig - 10*sigq;
    #debug concat("==== BUILDING... signature[", str(i,0,0), "] = ", str(signature[i],0,0), "\n")
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

#debug concat("SIGNATURE: ")
#local i = 12;
#while (i > 0)
  #local i = i - 1;
  #debug str(signature[i],0,0)
#end
#debug ".\n"

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

#declare h7c1 = <1,0,0>;
#declare h7c2 = <1,0.5,0.5>;
#declare h7c3 = <1,0.75,0.75>;
#declare h8c1 = <0,1,0>;
#declare h8c2 = <0.5,1,0.5>;
#declare h8c3 = <0.75,1,0.75>;

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
  rotcolors ()
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
