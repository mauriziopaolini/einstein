/*
 *
 * sample call:
 *
 * povray +a einstein.pov Declare=htile=<htile> Declare=depth=<depth>
 *
 * where <htile> = either 7 or 8
 *
 */

#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "subdivision.inc"

#ifdef (numbers)
  #declare depth = 1;
  #declare htile = 8;
  background {White}
  wormcolors (<1,1,0>, <1,0.5,0>, <1,0.6,0.2>,
              <1,1,0>, <0.5,1,0>, <0.6,1,0.2>)
  #declare shownumbers = 1;
#end

#ifndef (depth) #declare depth = 2; #end
#ifndef (htile) #declare htile = 7; #end

#ifndef (noworm)
  #if (depth >= 0) #declare alsoworm = 1; #end
#end

#declare zoomfactor = 1/phi/phi;
#declare zoomfactor2 = 2.62;
#declare zoomfactor = pow (zoomfactor, depth);
#ifdef (zoomout)
  #declare zoomfactor = zoomfactor*zoomout;
#end

#declare textfont = "LiberationMono-Regular.ttf"

#debug concat ("zoomfactor = ", str(zoomfactor,0,-1), "\n")
#debug concat ("zoomfactor2 = ", str(zoomfactor2,0,-1), "\n")

#declare gtras = zoomfactor/2.62*(4*x-0.2*z);

#if (htile = 7)
  h7rec (transform {scale 1.0 translate gtras}, depth)
  #ifdef (alsoworm)
    #declare onlyworm = 1;
    h7rec (transform {scale 1.0 translate gtras + h*y}, depth)
  #end
#else
  h8rec (transform {scale 1.0 translate gtras}, depth)
  #ifdef (alsoworm)
    #declare onlyworm = 1;
    h8rec (transform {scale 1.0 translate gtras + h*y}, depth)
  #end
#end

#ifdef (shownumbers)
  #local trnx = array[7]
  #local trnx[0] = trn0[depth-1];
  #local trnx[1] = trn1[depth-1];
  #local trnx[2] = trn2[depth-1];
  #local trnx[3] = trn3[depth-1];
  #local trnx[4] = trn4[depth-1];
  #local trnx[5] = trn5[depth-1];
  #local trnx[6] = trn6[depth-1];
  #local i = 0;
  #while (i <= htile-2 )
    text {ttf textfont str(i,0,0) 0.02, 0
      pigment {color Black}
      rotate 90*x
      translate -0.3*x-0.4*z
      scale zoomfactor
      translate trnx[i]
      translate gtras + 2*tile_thick*y
    }
    #local i = i + 1;
  #end
#end

#ifdef (arrow)
  #local arbase = trn0[depth-1];
  #local arpoint = trn6[depth-1];
  #local arcbase = 0.3*arbase + 0.7*arpoint;
  union {
    cone {arcbase, 0.2*zoomfactor, arpoint, 0}
    cylinder {arbase, arcbase, 0.1*zoomfactor}
    translate 0*0.3*x + 1.0*z
    translate gtras + 2.5*tile_thick*y
    pigment {color Black}
    finish {tile_Finish}
  }
#end

#ifdef (debug)
#if (depth = 0)
  sphere {
    <0,0,0>
    0.4
    pigment {color Black}
    translate gtras
  }
#end
#end

#declare lookatpos = <0,0,0>;
#declare mylocation = 0.9*zoomfactor*<0,10,0>;

#ifdef (panleft)
  //#declare lookatpos = -9*x;
  #declare lookatpos = -0.4*zoomfactor*x;
  #if (panleft >= 2)
    #declare lookatpos = -1.2*zoomfactor*x;
  #end
  #declare zoomfactor = zoomfactor/3;
  #declare mylocation = 0.8*zoomfactor*<0,10,0>;
  #if (panleft >= 2)
    #declare mylocation = mylocation - 3*zoomfactor*x;
  #end
#end

camera {
  location mylocation
  sky <0,0,1>
  look_at lookatpos
}

light_source { zoomfactor*<20, 20, -20> color White }
//light_source { 2*20*<1, 1, 1> color White }

#ifdef (sfondobianco)
  background {White}
#end
