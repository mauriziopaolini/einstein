/*
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

#ifndef (activity) #declare activity = 0; #end
#declare sfondobianco = 1;

#declare SPobj[0] = blueyellowmystic;

#switch (activity)
  #case (0)
  #case (1)
    #declare depth = 0;
    #ifndef (SPid) #declare SPid = 7; #end
    #break

  #case (2)
    #declare depth = 0;
    #declare zoomout = 0.2;
    #ifndef (SPid) #declare SPid = 7; #end
    #break

  #case (3)
    #declare depth = 0;
    #ifndef (SPid) #declare SPid = 0; #end
    #break

  #case (4)
    #declare depth = 1;
    #ifndef (SPid) #declare SPid = 1; #end
    #break

  #case (5)
    #declare depth = 2;
    #declare colors = 1;
    #declare bdthick = 0.2;
    #declare zoomout = 0.85;
    #ifndef (SPid) #declare SPid = 1; #end
    #break

  #case (6)
    #declare depth = 3;
    #declare colors = 1;
    #declare bdthick = 0.3;
    #declare zoomout = 1.4;
    #ifndef (SPid) #declare SPid = 1; #end
    #break
#end

#ifndef (depth) #declare depth = 2; #end
#ifndef (SPid) #declare SPid = 1; #end
#ifndef (colors) #declare colors = depth; #end
#if (colors <= 0) #declare colors = depth + colors; #end

#declare magstep = sqrt(4+sqrt(15));
#declare magdepth = pow (magstep, depth);
#declare mag = magdepth;

#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

#declare gtrans = transform {scale 1/mag*<-1,1,1> translate -1.5*z rotate -30*y};

#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

#declare textfont = "LiberationMono-Regular.ttf"

#ifdef (gray)
  #declare gtrans = transform {gtrans scale <-1,1,1>}
  #declare SPpigment[SPid] = rgb 0.5*<1,1,1>;
  SPbuildtiles ()
#end

#ifdef (zoom) #declare zoomfactor = 1/zoom*zoomfactor; #end

#macro SPdetails (ltrans, depth)
  SPbmystic (transform {transform {Str[0][depth-1] ltrans}}, depth-1)
  SPrec (0, transform {Str[0][depth-2] Str[0][depth-1] ltrans}, depth-2)
  #local j = 1;
  #while (j <= 7)
    SPbspectre (transform {transform {Str[j][depth-1] ltrans}}, depth-1)
    #local j = j + 1;
  #end
#end

#switch (activity)
  #case (0)
  #case (1)
    SPrec (SPid, transform {gtrans}, depth)
    #break

  #case (2)
    #declare gtrans = transform {gtrans translate -1.5*x - 1.5*z}
    #declare trinv = transform {Str[5][0] inverse}
    #declare tower = transform {Str[6][0] trinv}
    SPrec (5, transform {gtrans}, 0)
    SPrec (6, transform {tower gtrans}, 0)
    SPrec (7, transform {tower tower gtrans}, 0)
    #break

  #case (3)
    #declare gtrans = transform {gtrans translate -1.0*z}
    object {blueyellowmystic
      transform {gtrans}
    }
    #break

  #case (4)
    #declare gtrans = transform {gtrans scale <-1,1,1> rotate -60*y translate -1.5*x - 2*z}
    SPrec (SPid, transform {gtrans}, depth)
    #break

  #case (5)
    #declare gtrans = transform {gtrans translate -2.80*z}
    SPrec (SPid, transform {gtrans}, depth)
    //SPbspectre (transform {gtrans}, depth)
    SPbmystic (transform {transform {Str[0][depth-1] gtrans}}, depth-1)
    #local i = 1;
    #while (i <= 7)
      #if (SPid != 0 | i != 3)
        SPbspectre (transform {transform {Str[i][depth-1] gtrans}}, depth-1)
      #end
      #local i = i + 1;
    #end
    #break

  #case (6)
    #declare gtrans = transform {gtrans scale <-1,1,1> rotate -60*y translate -1.0*x - 4.8*z}
    //SPrec (SPid, transform {gtrans}, depth)
    //SPbspectre (transform {gtrans}, depth)
    SPrec (0, transform {transform {Str[0][depth-1] gtrans}}, depth-1)
    SPbmystic (transform {transform {Str[0][depth-1] gtrans}}, depth-1)
    #local i = 1;
    #while (i <= 7)
      #if (SPid != 0 | i != 3)
        SPbspectre (transform {transform {Str[i][depth-1] gtrans}}, depth-1)
      #end
      #local i = i + 1;
    #end
    #declare bdthick = 0.5*bdthick;
    SPdetails (transform {Str[2][depth-1] gtrans}, depth-1)
    SPdetails (transform {Str[4][depth-1] gtrans}, depth-1)
    SPdetails (transform {Str[5][depth-1] gtrans}, depth-1)
    #break
#end

#ifdef (debug)
  sphere {
    <0,0,0>
    0.4
    pigment {color Black}
    transform {gtrans}
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
        transform {gtrans}
        translate 2*tile_thick*y
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
