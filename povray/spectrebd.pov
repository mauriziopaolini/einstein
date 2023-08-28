/*
 * Parameters (syntax: Declare=param=value in command line)
 *
 * depth=d
 * SPid=0     to get the mystic
 * SPid=2     to get the simplified spectre (continuous boundary)
 * colors=-1  colorful 2D subdivision
 * bdthick    controls thickness of boundary
 * zoomout    zoom level. (= depth to get the overall picture)
 * panup/panright (move point of view; unit is relative to depth)
 * ptsize     size of the four/six subdivision points
 * subpoints=num  draw subdivision points of subtile number num
 */

#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "spectresubdivision.inc"
//#include "spectrebsubdivision.inc"
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

//#ifndef (colors) #declare colors = depth; #end
#if (colors < 90)
  #if (colors <= 0) #declare colors = depth + colors; #end
  SPrec (SPid, transform {transform {gtras} translate lift}, depth)
  #local lift = lift + tile_thick*y;
  SProtcolorshue (360*phi)
  SPbuildtiles ()
#end

#ifndef (bdthick) #declare bdthick = 2; #end

#switch (SPid)
  #case (0)
    SPbmystic (transform {transform {gtras} translate lift}, depth)
    #break
  #case (2)
    SPbsspectre (transform {transform {gtras} translate lift}, depth)
    #break
  #case (1)
  #case (3)
  #case (4)
  #case (5)
  #case (6)
  #case (7)
    SPbspectre (transform {transform {gtras} translate lift}, depth)
    #break
#end

/*
#if (SPid != 0)
  SPbspectre (transform {transform {gtras} translate lift}, depth)
#else
  SPbmystic (transform {transform {gtras} translate lift}, depth)
#end
 */

#ifdef (subdivide)
  #declare bdthick = bdthick/2;
  SPbmystic (transform {transform {Str[0][depth-1] gtras} translate lift}, depth-1)
  #local i = 1;
  #while (i <= 7)
    #if (SPid != 0 | i != 3)
      SPbspectre (transform {transform {Str[i][depth-1] gtras} translate lift}, depth-1)
    #end
    #local i = i + 1;
  #end
#end

#local lift = lift + tile_thick*y;

#macro onepoint (trsf, pcolor)
  cylinder {
    0*y
    1.0*y
    cylt
    //pigment {color Black}
    pigment {color pcolor}
    transform {trsf}
  }
#end

#macro fourpoints (trsf, dpth)
  #local pointAtr = transform {Str[6][dpth-4] Str[6][dpth-3] Str[6][dpth-2] Str[1][dpth-1]}
  #local pointBtr = transform {Str[4][dpth-4] Str[4][dpth-3] Str[4][dpth-2] Str[4][dpth-1]}
  #local pointCtr = transform {Str[6][dpth-4] Str[6][dpth-3] Str[6][dpth-2] Str[6][dpth-1]}
  #local pointDtr = transform {Str[4][dpth-4] Str[4][dpth-3] Str[4][dpth-2] Str[7][dpth-1]}
  onepoint (transform {pointAtr trsf}, color Black)
  onepoint (transform {pointBtr trsf}, color Black)
  onepoint (transform {pointCtr trsf}, color Black)
  onepoint (transform {pointDtr trsf}, color Black)
#end

#macro sixpoints (trsf, dpth)
  #local pointAtr = transform {Str[6][dpth-4] Str[6][dpth-3] Str[6][dpth-2] Str[1][dpth-1]}
  #local pointB2tr = transform {Str[3][dpth-4] Str[3][dpth-3] Str[3][dpth-2] Str[3][dpth-1]}
  #local pointBtr = transform {Str[4][dpth-4] Str[4][dpth-3] Str[4][dpth-2] Str[4][dpth-1]}
  #local pointCtr = transform {Str[6][dpth-4] Str[6][dpth-3] Str[6][dpth-2] Str[6][dpth-1]}
  #local pointC2tr = transform {Str[3][dpth-4] Str[3][dpth-3] Str[3][dpth-2] Str[6][dpth-1]}
  #local pointDtr = transform {Str[4][dpth-4] Str[4][dpth-3] Str[4][dpth-2] Str[7][dpth-1]}
  onepoint (transform {pointAtr trsf}, color Black)
  onepoint (transform {pointB2tr trsf}, color Red)
  onepoint (transform {pointBtr trsf}, color Black)
  onepoint (transform {pointCtr trsf}, color Black)
  onepoint (transform {pointC2tr trsf}, color Green)
  onepoint (transform {pointDtr trsf}, color Black)
#end

#if (depth > 4)

  #ifndef (ptsize) #declare ptsize = 20; #end
  #declare cylt = ptsize;

  #ifdef (draw4points) fourpoints (gtras, depth) #end
  #ifdef (draw6points) sixpoints (gtras, depth) #end

  #ifdef (subpoints)
    #declare cylt = 0.5*cylt;
    fourpoints (transform {Str[0][depth-1] gtras}, depth-1)
    #local i = 1;
    #while (i <= 7)
      fourpoints (transform {Str[i][depth-1] gtras}, depth-1)
      #local i = i + 1;
    #end
  #end

#end

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
