/*
 * OBSOLETED!  This was a preliminary step towards "spectrebd.pov"
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

/*
#macro gogo (i)
//  SProtcolorshue (360*phi)
//  SPbuildtiles ()
  SPrec (i, transform {Str[i][depth-1] transform {gtras} translate lift}, depth-1)
#end

#macro gogo2 (i,j)
//  SProtcolorshue (360*phi)
//  SPbuildtiles ()
  SPrec (j, transform {Str[j][depth-2] Str[i][depth-1] transform {gtras} translate lift}, depth-2)
#end
 */

#macro gogo3 (i,j,k)
  SProtcolorshue (360*phi)
  SPbuildtiles ()
  SPrec (k, transform {Str[k][depth-3] Str[j][depth-2] Str[i][depth-1] transform {gtras} translate lift}, depth-3)
  #ifdef (print)
    #debug concat ("ADDRESS: ", str(i,0,0), str(j,0,0), str(k,0,0), "\n")
  #end
#end

#macro tip2_l (i)
  tip2_bay (i)
  gogo3 (i,4,5)
  gogo3 (i,4,6)
  tip3 (i,3)
  tip3_456 (i,2)
  tip3_l (i,1)
#end

#macro tip2_bay (i)
  tip3_67 (i,6)
  tip3_456 (i,5)
  tip3_1234 (i,4)
#end

#macro tip2 (i)
  tip3_456 (i,7)
  tip3_12345 (i,6)
  tip2_l (i)
#end

#macro tip3_1234 (i,j)
  gogo3 (i,j,1)
  gogo3 (i,j,2)
  gogo3 (i,j,3)
  gogo3 (i,j,4)
#end

#macro tip3_12345 (i,j)
  tip3_1234 (i,j)
  gogo3 (i,j,5)
#end

#macro tip3_l (i,j)
  tip3_12345 (i,j)
  gogo3 (i,j,6)
#end

#macro tip3_67 (i,j)
  gogo3 (i,j,6)
  gogo3 (i,j,7)
#end

#macro tip3_456 (i,j)
  gogo3 (i,j,4)
  gogo3 (i,j,5)
  gogo3 (i,j,6)
#end

#macro tip3 (i,j)
  tip3_l (i,j)
  gogo3 (i,j,7)
#end

#local lift = lift + tile_thick*y;

gogo3 (0,0,0)
gogo3 (0,0,1)
gogo3 (0,0,7)
tip3_1234 (0,7)

tip2 (1)
tip2_bay (2)
tip2 (3)
tip2_l (4)
tip2_bay (5)
tip2 (6)
tip2_l (7)
tip3_67 (0,1)

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
