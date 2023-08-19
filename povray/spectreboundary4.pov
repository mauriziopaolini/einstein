/*
 *
 */

#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "spectresubdivision.inc"
#include "spectreworm.inc"

#ifndef (depth) #declare depth = 5; #end // must coincide with the number of digits in signatures
#ifndef (SPid) #declare SPid = 1; #end

#declare magstep = sqrt(4+sqrt(15));
#declare magdepth = pow (magstep, depth);
#declare mag = magdepth;

#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

#declare gtras = transform {rotate 0*y};
#ifdef (rot) #declare gtras = transform {rotate rot*y} #end

#local lift = 0;

//SPrec (SPid, transform {transform {gtras} translate lift}, depth)
//#local lift = lift + tile_thick*y;

//SProtcolorshue (360*phi)
//SPbuildtiles ()

#macro gogo4 (i,j,k,l)
  SProtcolorshue (360*phi)
  SPbuildtiles ()
  SPrec (l, transform {Str[l][depth-4] Str[k][depth-3] Str[j][depth-2] Str[i][depth-1] transform {gtras} translate lift}, depth-4)
  #ifdef (print)
    #debug concat ("ADDRESS: ", str(i,0,0), str(j,0,0), str(k,0,0), str(l,0,0), "\n")
  #end
#end

#macro tip2_l (i)
  tip3_67 (i,6)
  tip3_456 (i,5)
  tip3_12345 (i,4)
  tip4_67 (i,4,6)

  tip3_12345 (i,3)
  tip4 (i,3,6)
  tip4_456 (i,3,7)

  tip3_456 (i,2)
  tip3_12345 (i,1)
  tip4_67 (i,1,6)
#end

#macro tip2_bay (i)
  tip3_67 (i,6)
  tip3_456 (i,5)
  tip4_l (i,4,1)
  tip4_456 (i,4,2)
  tip4 (i,4,3)
  tip4_456 (i,4,4)
#end

#macro tip2 (i)
  tip3_456 (i,7)
  tip3_12345 (i,6)
  tip2_l (i)
#end


#macro tip3_12345 (i,j)
  tip4_l (i,j,1)
  tip4_456 (i,j,2)
  tip4 (i,j,3)
  tip4_l (i,j,4)
  tip4_456 (i,j,5)
#end

#macro tip3_67 (i,j)
  tip4 (i,j,6)
  tip4_456 (i,j,7)
#end

#macro tip3_456 (i,j)
  tip4_1234 (i,j,4)
  tip4_456 (i,j,5)
  tip4_67 (i,j,6)
#end


#macro tip4_1234 (i,j,k)
  gogo4 (i,j,k,1)
  gogo4 (i,j,k,2)
  gogo4 (i,j,k,3)
  gogo4 (i,j,k,4)
#end

#macro tip4_12345 (i,j,k)
  tip4_1234 (i,j,k)
  gogo4 (i,j,k,5)
#end

#macro tip4_l (i,j,k)
  tip4_12345 (i,j,k)
  gogo4 (i,j,k,6)
#end

#macro tip4_67 (i,j,k)
  gogo4 (i,j,k,6)
  gogo4 (i,j,k,7)
#end

#macro tip4_456 (i,j,k)
  gogo4 (i,j,k,4)
  gogo4 (i,j,k,5)
  gogo4 (i,j,k,6)
#end

#macro tip4 (i,j,k)
  tip4_l (i,j,k)
  gogo4 (i,j,k,7)
#end

#local lift = lift + tile_thick*y;

tip4_l (0,1,6)
tip4_456 (0,1,7)

tip4_1234 (0,0,7)

gogo4 (0,0,0,7)
gogo4 (0,0,0,0)
gogo4 (0,0,0,1)
tip4_67 (0,0,1)

tip4_l (0,7,1)
tip4_456 (0,7,2)
tip4 (0,7,3)
tip4_456 (0,7,4)

tip2 (1)
tip2_bay (2)
tip2 (3)
tip2_l (4)
tip2_bay (5)
tip2 (6)
tip2_l (7)

cylinder {
  0*y
  1.0*y
  0.4
  pigment {color Black}
  transform {gtras}
}

#declare lookatpos = <0,0,0>;
#declare mylocation = 0.8*mag*<0,10,0>;

#ifdef (panup)
  #declare lookatpos = lookatpos+magdepth*panup*z;
  #declare mylocation = mylocation+magdepth*panup*z;
#end

#ifdef (panright)
  #declare lookatpos = lookatpos+magdepth*panright*x;
  #declare mylocation = mylocation+magdepth*panright*x;
#end

camera {
  location mylocation
  sky <0,0,1>
  look_at lookatpos
}

light_source { mag*<20, 20, -50> color White }
light_source { mag*<-50, 100, -100> color 0.5*White }
//light_source { 2*20*<1, 1, 1> color White }

background {White}
