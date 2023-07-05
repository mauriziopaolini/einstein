#version 3.7;

global_settings { assumed_gamma 1.0 }

#include "colors.inc"
#include "skies.inc"
#include "shapes.inc"
#include "subdivision.inc"
#include "ambiente.inc"

#declare h7c1 = <1,1,1>;
#declare h7c2 = <1,0,0>;
#declare h7c3 = <1,0.4,0.4>;
#declare h8c1 = <1,1,1>;
#declare h8c2 = <1,0.4,0>;
#declare h8c3 = <1,0.4,0.4>;

#ifndef (depth) #declare depth = 5; #end

#declare mag = pow(Phi*Phi,depth);
#ifdef (zoomout)
  #declare mag = pow(Phi*Phi,zoomout);
#end

#declare gtrans0 = transform {scale <1,1,1>}

#declare ttransinv = array[depth+1];
#declare htilex = array[depth+1];

#macro build_up_down (upl, downl)
  #declare uptransf = transform {scale <1,1,1>}
  #declare downtransf = transform {scale <1,1,1>}
  #local dpth = 0;
  #while (upl != downl)
    #local uplhigh = int (upl/10);
    #local downlhigh = int (downl/10);
    #local upllow = upl - 10*uplhigh;
    #local downllow = downl - 10*downlhigh;
    #declare uptransf = transform {uptransf rotate rotvec[upllow]*y translate trnvec[upllow][dpth]}
    #declare downtransf = transform {downtransf rotate rotvec[downllow]*y translate trnvec[downllow][dpth]}
    #local upl = uplhigh;
    #local downl = downlhigh;
    #local dpth = dpth + 1;
  #end
#end

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

#macro build_ttransinv6 (depth)
 #local dpth = 0;
 #while (dpth <= depth)
  
  #declare tiletrans = transform {scale <1,1,1>};
  #local i = 0; 
  #while (i < dpth)
    #local rotx = rotvec[6];
    #local trnx = trnvec[6][dpth-i-1];
    #declare tiletrans = transform {rotate rotx*y translate trnx tiletrans}
    #local i = i + 1;
  #end
  
  #declare htilex[dpth] = 8;
  #declare ttransinv[dpth] = transform {tiletrans inverse}
  #local dpth = dpth + 1; 
 #end
#end

build_up_down (60, 26)
build_ttransinv6 (depth)

#declare uptransfinv = transform {uptransf inverse}
#declare placeit = transform {downtransf uptransfinv}

#local i = 0;
#while (i < 6)
  #local dimm = 1;
  #local dpth = 0;
  #while (dpth <= depth)
    #declare h7m = union {
      h7list (dimm*h7c1, dimm*h7c2, dimm*h7c3)
    }
    #declare h8m = union {
      h8list (dimm*h8c1, dimm*h8c2, dimm*h8c3)
    }
    h8rec (transform {ttransinv[dpth] placeit rotate i*60*y translate 2*(depth-dpth)*tile_thick*y gtrans0}, dpth)
    #local dpth = dpth + 1;
    #local dimm = 0.5*dimm;
  #end  

  rotcolors ()
  #local i = i + 1;
#end

background {White}

#declare skycam = z;
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
