/*
 *
 * sample call:
 *
 * povray +a spectre.pov Declare=htile=<SPid> Declare=depth=<depth>
 *
 * where <SPid> = 0 (mystic), 1, 2, 3, 4, 5, 6, 7 (spectre)
 *
 */

#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "spectresubdivision.inc"

#ifndef (depth) #declare depth = 2; #end
#ifndef (SPid) #declare SPid = 1; #end
#ifndef (colors) #declare colors = depth - 1; #end
#if (colors <= 0) #declare colors = depth + colors; #end

#declare zoomfactor = 1/phi/phi;
#declare zoomfactor2 = 2.62;
#declare zoomfactor = pow (zoomfactor, depth);

#debug concat ("zoomfactor = ", str(zoomfactor,0,-1), "\n")
#debug concat ("zoomfactor2 = ", str(zoomfactor2,0,-1), "\n")

#declare gtras = zoomfactor/2.62*(0*x-0*z);

#ifdef (zoom) #declare zoomfactor = 1/zoom*zoomfactor; #end

#ifdef (fig22)
  #switch (depth)
    #case (0)
      #declare gtras = gtras + 1.0*z - 2.0*x;
      #declare zoomfactor = zoomfactor/1.5;
    #break

    #case (1)
      #declare gtras = gtras + 1.7*z - 4.0*x;
      #declare zoomfactor = zoomfactor/1.8;
    #break

    #case (2)
      #declare gtras = gtras -6*x + 6*z;
      #declare zoomfactor = zoomfactor/1.5;
    #break

    #case (3)
      #declare gtras = gtras -15*x + 6*z;
      #declare zoomfactor = zoomfactor/1.3;
    #break

    #case (4)
      #declare gtras = gtras -28*x + 40*z;
      #declare zoomfactor = zoomfactor/1.3;
    #break

    #case (5)
      #declare gtras = gtras -35*x + 40*z;
      #declare zoomfactor = zoomfactor/1.2;
    #break

    #case (6)
      #declare gtras = gtras -200*x + 300*z;
      #declare zoomfactor = zoomfactor/1.1;
    #break
  #end
#end

#ifdef (figA1)
  #switch (depth)
    #case (0)
      #declare gtras = gtras - 2*z + 0.5*x;
      #declare zoomfactor = zoomfactor/1.5;
    #break

    #case (1)
      #declare gtras = gtras -4*z;
      #declare zoomfactor = zoomfactor/1.7;
    #break

    #case (2)
      #declare gtras = gtras -8*z;
      #declare zoomfactor = zoomfactor/1.7;
    #break

    #case (3)
      #declare gtras = gtras -20*x-5*z;
      #declare zoomfactor = zoomfactor/1.4;
    #break

    #case (4)
      #declare gtras = gtras -0*x-50*z;
      #declare zoomfactor = zoomfactor/1.3;
    #break

    #case (5)
      #declare gtras = gtras -0*x-50*z;
      #declare zoomfactor = zoomfactor/1.2;
    #break

    #case (6)
      #declare gtras = gtras -0*x-400*z;
      #declare zoomfactor = zoomfactor/1.2;
    #break
  #end
#end



#declare prerotA1 = array[maxdepth];
#declare i = 0;
#while (i < maxdepth)
  #declare prerotA1[i] = 0;
  #declare i = i + 1;
#end
#declare prerotA1[1] = -60;

#declare prerot22 = array[maxdepth];
#declare prerot22[0] = 90;
#declare i = 1;
#while (i < maxdepth)
  #declare prerot22[i] = 90 + 150 - prerot22[i-1];
  #declare i = i + 1;
#end

#declare pretransform = transform {scale 1.0};
#ifdef (fig22) #declare pretransform = transform {scale <-1,1,1> rotate prerot22[depth]*y}; #end
#ifdef (figA1) #declare pretransform = transform {rotate 30*y rotate prerotA1[depth]*y}; #end

//#if (htile = 1)
  //spectrerec (transform {transform {pretransform} translate gtras}, depth)
SPrec (SPid, transform {transform {pretransform} translate gtras}, depth)
//  #declare onlyworm = 1;
//  h7rec (transform {scale 1.0 translate gtras + h*y}, depth)
//#else
  //mysticrec (transform {transform {pretransform} translate gtras}, depth)
//  SPrec (0, transform {transform {pretransform} translate gtras}, depth)
//  #declare onlyworm = 1;
//  h8rec (transform {scale 1.0 translate gtras + h*y}, depth)
//#end

#ifdef (debug)
//#if (depth = 0)
  sphere {
    <0,0,0>
    0.4
    pigment {color Black}
    translate gtras
  }
//#end
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

#ifdef (panup)
  #declare lookatpos = lookatpos+panup*z;
  #declare mylocation = mylocation+panup*z;
#end

camera {
  location mylocation
  sky <0,0,1>
  look_at lookatpos
}

light_source { zoomfactor*<20, 20, -50> color White }
light_source { zoomfactor*<-50, 100, -100> color 0.5*White }
//light_source { 2*20*<1, 1, 1> color White }

#ifdef (sfondobianco)
  background {White}
#else
  plane {y, 0 
    texture {pigment {color DarkGreen} finish {tile_Finish}}
  }
#end
