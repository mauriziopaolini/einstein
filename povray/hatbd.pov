/*
 * Parameters (syntax: Declare=param=value in command line)
 *
 * depth=d
 * htile=7     to get the H7
 * colors=-1  colorful 2D subdivision
 * bdthick    controls thickness of boundary
 * zoomout    zoom level. (= depth to get the overall picture)
 * panup/panright (move point of view; unit is relative to depth)
 * XXX ptsize     size of the four/six subdivision points
 * subpoints=num  draw subdivision points of subtile number num
 */

#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "subdivision.inc"

#ifndef (depth) #declare depth = 5; #end // must coincide with the number of digits in signatures
#ifndef (htile) #declare htile = 8; #end

#declare magstep = Phi*Phi;
#declare magdepth = pow (magstep, depth);
#declare mag = magdepth;

#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

#declare gtras = transform {rotate 0*y};
#ifdef (rot) #declare gtras = transform {rotate rot*y} #end

#local lift = 0;

//#ifndef (colors) #declare colors = depth; #end
#if (colors = 90)
  HATrec (htile, transform {transform {gtras} translate lift}, depth)
  #local lift = lift + tile_thick*y;
#end

#if (colors < 90)
  #declare HATpigment[4] = HATpigment[3];
  #declare HATpigment[5] = HATpigment[3];
  #declare HATpigment[0] = HATpigment[3];
  #declare HATpigment[1] = HATpigment[4];
  #declare HATpigment[2] = HATpigment[5];
  HATbuildtiles ();

  #if (colors <= 0) #declare colors = depth + colors; #end
  HATrec (htile, transform {transform {gtras} translate lift}, depth)
  #local lift = lift + tile_thick*y;
  HATrotcolorshue (360*phi)
  HATbuildtiles ()
#end

#ifndef (bdthick) #declare bdthick = 2; #end

#ifdef (which)
  HATbrec (which, transform {transform {gtras} translate lift}, depth)
#else
  #if (htile != 7)
    HATbh8rec (transform {transform {gtras} translate lift}, depth)
  #else
    HATbh7rec (transform {transform {gtras} translate lift}, depth)
  #end
#end

#ifdef (subdivide)
  #declare bdthick = bdthick/2;
  HATbh7rec (transform {rotate rot0*y translate trn0[depth-1] gtras translate lift}, depth-1)
  #local i = 1;
  #while (i <= 6)
    #if (htile != 7 | i != 6)
      HATbh8rec (transform {rotate rotvec[i]*y translate trnvec[i][depth-1] gtras translate lift}, depth-1)
    #end
    #local i = i + 1;
  #end
  #if (subdivide > 1)
    #declare bdthick = bdthick/2;
    HATbh7rec (transform {rotate rot0*y translate trn0[depth-2] rotate rot0*y translate trn0[depth-1] gtras translate lift}, depth-2)
    #local i = 1;
    #while (i <= 5)
      HATbh8rec (transform {rotate rotvec[i]*y translate trnvec[i][depth-2] rotate rot0*y translate trn0[depth-1] gtras translate lift}, depth-2)
      #local i = i + 1;
    #end
    #local i = 1;
    #while (i <= 6)
      #if (htile != 7 | i != 6)
        HATbh7rec (transform {rotate rot0*y translate trn0[depth-2] rotate rotvec[i]*y translate trnvec[i][depth-1] gtras translate lift}, depth-2)
        #local j = 1;
        #while (j <= 6)
          HATbh8rec (transform {rotate rotvec[j]*y translate trnvec[j][depth-2] rotate rotvec[i]*y translate trnvec[i][depth-1] gtras translate lift}, depth-2)
          #local j = j + 1;
        #end
      #end
      #local i = i + 1;
    #end
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

#macro threepoints (trsf, dpth)
  #local pointAtr = transform {
    rotate rotvec[6]*y translate trnvec[6][dpth-4]
    rotate rotvec[3]*y translate trnvec[3][dpth-3]
    rotate rotvec[6]*y translate trnvec[6][dpth-2]
    rotate rotvec[1]*y translate trnvec[1][dpth-1]
  }
  #local pointBtr = transform {
    rotate rotvec[3]*y translate trnvec[3][dpth-4]
    rotate rotvec[6]*y translate trnvec[6][dpth-3]
    rotate rotvec[3]*y translate trnvec[3][dpth-2]
    rotate rotvec[4]*y translate trnvec[4][dpth-1]
  }
  #local pointCtr = transform {
    rotate rotvec[6]*y translate trnvec[6][dpth-4]
    rotate rotvec[3]*y translate trnvec[3][dpth-3]
    rotate rotvec[6]*y translate trnvec[6][dpth-2]
    rotate rotvec[3]*y translate trnvec[3][dpth-1]
  }
  onepoint (transform {pointAtr trsf}, color Black)
  onepoint (transform {pointBtr trsf}, color Black)
  onepoint (transform {pointCtr trsf}, color Black)
#end

#macro fourpoints (trsf, dpth)
  threepoints (trsf, dpth)
  #local pointDtr = transform {
    rotate rotvec[3]*y translate trnvec[3][dpth-4]
    rotate rotvec[6]*y translate trnvec[6][dpth-3]
    rotate rotvec[3]*y translate trnvec[3][dpth-2]
    rotate rotvec[6]*y translate trnvec[6][dpth-1]
  }
  onepoint (transform {pointDtr trsf}, color Black)
#end

#if (depth > 4)

  #ifndef (ptsize) #declare ptsize = 20; #end
  #declare cylt = ptsize;

  #ifdef (draw4points)
    #if (htile != 7) fourpoints (gtras, depth) #else threepoints (gtras, depth) #end
  #end

  #ifdef (subpoints)
    #declare cylt = 0.5*cylt;
    threepoints (transform {rotate rot0*y translate trn0[depth-1] gtras}, depth-1)
    #local i = 1;
    #while (i <= 6)
      #if (htile != 7 | i != 6) fourpoints (transform {rotate rotvec[i]*y translate trnvec[i][depth-1] gtras}, depth-1) #end
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
