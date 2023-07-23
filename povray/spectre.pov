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

#ifdef (numbers)
  #declare depth = 1;
  #declare SPid = 1;
  #declare sfondobianco = 1;
#end

#ifndef (depth) #declare depth = 2; #end
#ifndef (SPid) #declare SPid = 1; #end
#ifndef (colors) #declare colors = depth; #end
#if (colors <= 0) #declare colors = depth + colors; #end

#declare magstep = sqrt(4+sqrt(15));
#declare mag = pow (magstep, depth);

#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

#declare textfont = "LiberationMono-Regular.ttf"

#declare gtras = -x-1.5*z;

#ifdef (zoom) #declare zoomfactor = 1/zoom*zoomfactor; #end

#ifdef (fig22)
  #switch (depth)
    #case (0)
      #declare gtras = 0.75*z - 2.0*x;
    #break

    #case (1)
      #declare gtras = 1.7*z - 4.0*x;
    #break

    #case (2)
      #declare gtras = -6*x + 6*z;
    #break

    #case (3)
      #declare gtras = -15*x + 6*z;
    #break

    #case (4)
      #declare gtras = -28*x + 40*z;
    #break

    #case (5)
      #declare gtras = -35*x + 40*z;
    #break

    #case (6)
      #declare gtras = -200*x + 300*z;
    #break
  #end
  #declare gtras = gtras/mag;
#end

#ifdef (figA1)
  #switch (depth)
    #case (0)
      #declare gtras = -2*z + 0.5*x;
    #break

    #case (1)
      #declare gtras = -4*z;
    #break

    #case (2)
      #declare gtras = -8*z;
    #break

    #case (3)
      #declare gtras = -20*x-5*z;
    #break

    #case (4)
      #declare gtras = -0*x-50*z;
    #break

    #case (5)
      #declare gtras = -0*x-50*z;
    #break

    #case (6)
      #declare gtras = -0*x-400*z;
    #break
  #end
  #declare gtras = gtras/mag;
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

#ifdef (sierpinski)
  #declare SPshow=sierpinski;
  SPrec (SPid, transform {transform {pretransform} translate gtras*mag+tile_thick*y}, depth)
  SProtcolorshue (180)
  SPbuildtiles ()
  #declare SPshow=255;
#end

SPrec (SPid, transform {transform {pretransform} translate gtras*mag}, depth)

#ifdef (debug)
  sphere {
    <0,0,0>
    0.4
    pigment {color Black}
    translate gtras*mag
  }
#end

#ifdef (numbers)
  #local i = 0;
  #while (i <= 7 )
    #if (SPid != 0 | i != 3)
      text {ttf textfont str(i,0,0) 0.02, 0
        pigment {color Black}
        translate -0.5*x + 0.5*y
        scale <-1,1,1>
        rotate 90*x
        translate -0.3*x-0.4*z
        scale mag
        transform Str[i][depth-1]
        translate gtras*mag + 2*tile_thick*y
      }
    #end
    #local i = i + 1;
  #end
#end

#declare lookatpos = <0,0,0>;
//#declare mylocation = 0.9*zoomfactor*<0,10,0>;
#declare mylocation = 0.54*mag*<0,10,0>;

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

light_source { mag*<20, 20, -50> color White }
light_source { mag*<-50, 100, -100> color 0.5*White }
//light_source { 2*20*<1, 1, 1> color White }

#ifdef (sfondobianco)
  background {White}
#else
  plane {y, 0 
    texture {pigment {color DarkGreen} finish {tile_Finish}}
  }
#end
