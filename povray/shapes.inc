#declare h = 0.1;

#include "textures.inc"
#include "colors.inc"
#include "math.inc"

#declare phi = (sqrt(5)-1)/2;
#declare Phi = (sqrt(5)+1)/2;
#declare ap = sqrt(3)/2;

//#ifdef (fixedpoint)
//  #declare isotiling = fixedpoint;
//#end
#ifdef (isotiling)
  #declare isotiling_tiles = isotiling;
  #declare isotiling_maps = isotiling;
#end
#ifdef (hexagonal)
  #declare hexagonal_tiles = hexagonal;
  #declare hexagonal_maps = hexagonal;
#end

#local tile_eps=0.05;  /* svaso in cima */
#local tile_f=0.5;     /* pendenza svaso in cima */
#declare tile_thick = (h + tile_eps*tile_f);

#ifdef (hexagonal_tiles)
  #local n = 6;
  #local pointshat=array[n]
  {<1,0>, <1/2,ap>, <-1/2,ap>, <-1,0>, <-1/2,-ap>, <1/2,-ap>}
#else
  #local n = 13;
  #local pointshat=array[n]
  {<0,0>, <3/4,ap/2>, <1/2,ap>, <-1/2,ap>, <-3/4,ap/2>,
   <-3/2,ap>, <-9/4,ap/2>, <-2,0>, <-3/2,0>,
   <-3/2,-ap>, <-3/4,-3/2*ap>, <-1/2,-ap>, <0,-ap>}
#end

#declare SPbddim = 13;
#local pointstile11=array[SPbddim]
//{<0,0>, <-ap,-1/2>, <-ap+1/2,-1/2-ap>, <-ap+1/2+2,-1/2-ap>, <-ap+1/2+2+1/2,-1/2>, <3,-1>, <3+ap,-1/2>,
// <3+ap-1/2,-1/2+ap>, <3+ap-1/2-1,-1/2+ap>, <3+ap-1/2-1,-1/2+ap+1>, <3+ap-1/2-1-ap,-1/2+ap+1+1/2>,
// <1,1>, <0,1>}
{<0,0>, <-ap,-1/2>, <1/2-ap,-1/2-ap>, <5/2-ap,-1/2-ap>, <3-ap,-1/2>, <3,-1>, <3+ap,-1/2>,
 <5/2+ap,-1/2+ap>, <3/2+ap,-1/2+ap>, <3/2+ap,1/2+ap>, <3/2,1+ap>,
 <1,1>, <0,1>}

#declare SPbd = array[SPbddim];
#local i = 0;
#while (i < SPbddim)
  #declare SPbd[i] = <pointstile11[i].y, 0, pointstile11[i].x>;
  /* transformation in definition of tile11:
    scale <-1,1,1>
    rotate 90*y
   */
  #local i = i + 1;
#end

//#local pointsisotileA = <0.813819056071827, 0.10481350480763343>;
//#local pointsisotileB = pointstile11[9];
//#local pointsisotileC = pointstile11[7];
//#local pointsisotileD = pointstile11[5];
#local scl = 1.5;
#local trn = <2,2>;
#local pointsisotileA = scl*<0,0> + trn;
#local pointsisotileB = scl*<2,0> + trn;
#local pointsisotileC = scl*<3/2 + sqrt(15)/6, - sqrt(5)/2 - sqrt(3)/6> + trn;
#local pointsisotileD = scl*<1, -sqrt(5)> + trn;

#declare SPbdisoA = <pointsisotileA.y, 0, pointsisotileA.x>;
#declare SPbdisoB = <pointsisotileB.y, 0, pointsisotileB.x>;
#declare SPbdisoC = <pointsisotileC.y, 0, pointsisotileC.x>;
#declare SPbdisoD = <pointsisotileD.y, 0, pointsisotileD.x>;

/*
 * the fixed point position is <xx,0,yy>
 * taken from the following "maxima" snippet
 *

(%i30) xx;
                                 3/2
                       sqrt(6 - 3   ) sqrt(10) - 2 sqrt(3)
(%o30)               - -----------------------------------
                                        6
(%i31) yy;
                                    3/2
           (sqrt(3) + 3) (sqrt(6 - 3   ) sqrt(10) - 2 sqrt(3))
         - --------------------------------------------------- - 2 sqrt(3) + 4
                                    6
(%o31) - ---------------------------------------------------------------------
                                      sqrt(3) - 3
(%i32) xx,numer;
(%o32)                        0.10481350480763343
(%i33) yy,numer;
(%o33)                         0.813819056071827
(%i34)
 */

#local ttx = 3/4;
#local tty = 0;
#local tt = <ttx,tty>;

#declare hat =
union {
  prism {
    linear_sweep
    linear_spline
    0, // sweep the following shape from here ...
    h, // ... up through here
    n+1, // the number of points making up the shape ...
    #local i = 0;
    #while (i < n)
      pointshat[i]+tt,
      #local i = i + 1;
    #end
    pointshat[0]+tt
  }
  prism {
    conic_sweep
    linear_spline
    1-tile_eps,
    1,
    n+1,
    #local i = 0;
    #while (i < n)
      pointshat[i]+tt,
      #local i = i + 1;
    #end
    pointshat[0]+tt
    scale <1,-1,1>
    translate y
    scale <1,tile_f,1>
    translate h*y
  }
  #ifdef (hexagonal_tiles)
    cone {
      <-0.7*0.5,h,0.8*ap> + tt, 0.1
      <0.9*0.5,h,0.8*ap> + tt, 0
      pigment {Black}
    }
  #end
  translate -ttx*x - tty*z
  // scale 0.8  // make tiles a bit smaller
}

#declare hatr =
object {hat
  scale <-1,1,1>
}

#ifndef (sambient)
  #declare sambient=0.2;
#end
#ifndef (sdiffuse)
  #declare sdiffuse=0.5;
#end

#declare tile_Finish =
finish {
        ambient sambient diffuse sdiffuse
        specular 0.5 roughness 0.05
        phong .75
}

#declare HATpigment = array[6];

#macro HATinitcolors ()
  #declare HATpigment[0] = rgb <1,0,0>;
  #declare HATpigment[1] = rgb <1,0.5,0.5>;
  #declare HATpigment[2] = rgb <1,0.75,0.75>;
  #declare HATpigment[3] = rgb <0,1,0>;
  #declare HATpigment[4] = rgb <0.5,1,0.5>;
  #declare HATpigment[5] = rgb <0.75,1,0.75>;
#end

HATinitcolors ()

#declare h7c1 = HATpigment[0];
#declare h7c2 = HATpigment[1];
#declare h7c3 = HATpigment[2];
#declare h8c1 = HATpigment[3];
#declare h8c2 = HATpigment[4];
#declare h8c3 = HATpigment[5];

#macro h7list (c1, c2, c3)
  object {hatr
    rotate -120*y
    texture { pigment {color c1} finish {tile_Finish} }
  }
  #ifndef (hexagonal_tiles)
    object {hat
      rotate -60*y
      translate 1.5*x
      translate ap*z
      texture { pigment {color c2} finish {tile_Finish} }
    }
  #end
  object {hat
    rotate -60*y
    translate -1.5*x
    translate ap*z
    texture { pigment {color c2} finish {tile_Finish} }
  }
  object {hat
    rotate 60*y
    translate 0*x
    translate 2*ap*z
    texture { pigment {color c2} finish {tile_Finish} }
  }
  object {hat
    rotate 0*y
    translate -1.5*x
    translate 3*ap*z
    texture { pigment {color c3} finish {tile_Finish} }
  }
  object {hat
    rotate -120*y
    translate -1.5*x
    translate -ap*z
    texture { pigment {color c3} finish {tile_Finish} }
  }
  object {hat
    rotate 180*y
    translate 0*x
    translate -2*ap*z
    texture { pigment {color c3} finish {tile_Finish} }
  }
#end

#macro h8list (c1, c2, c3)
  h7list (c1, c2, c3)
  object {hat
    rotate -60*y
    translate -3*x
    translate 2*ap*z
    texture { pigment {color c3} finish {tile_Finish} }
  }
#end

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

#declare h7m = union {
  h7list (h7c1, h7c2, h7c3)
  //finish {tile_Finish}
}

#declare h8m = union {
  h8list (h8c1, h8c2, h8c3)
  //finish {tile_Finish}
}

#declare h7worm = union {
  h7list (Blue, h7c1, h7c2)
  //finish {tile_Finish}
}

#declare h8worm = union {
  h8list (Blue, h8c1, h8c2)
  //finish {tile_Finish}
}

#ifndef (T_hat)
  #declare T_hat = texture {White_Marble}
#end

#ifndef (T_hatr)
  #declare T_hatr = texture {Blue_Agate}
#end

#declare hatm =
object { hat
  texture {T_hat
    finish {tile_Finish}
  }
}

#declare hatrm =
object { hatr
  texture {T_hatr
    finish {tile_Finish}
  }
}

#macro HATbuildtiles ()
  #declare h7m = union {
    h7list (HATpigment[0], HATpigment[1], HATpigment[2])
  }
  #declare h8m = union {
    h8list (HATpigment[3], HATpigment[4], HATpigment[5])
  }
#end

#macro HATrotcolorshue (rot)
  #local i = 0;
  #while (i < 6)
    #local col = HATpigment[i];
    #local cmax = col.x;
    #local cmax = max3 (col.x, col.y, col.z);
    #local cmin = min3 (col.x, col.y, col.z);
    #local chroma = cmax - cmin;
    #if (chroma > 0)
      #if (cmax = col.x)
        #local huep = col.y - col.z;
      #else
        #if (cmax = col.y)
          #local huep = col.z - col.x + 2*chroma;
        #else
          #local huep = col.x - col.y + 4*chroma;
        #end
      #end
      #local huep = huep/chroma + rot/60;
      #if (huep < 0) #local huep = huep + 6; #end
      #if (huep >= 6) #local huep = huep - 6; #end
      #local huepmod2 = mod (huep, 2);
      #local ecs = chroma*(1 - abs(huepmod2 - 1));
      #switch (huep)
        #range (0,1)
          #local rgb1 = <chroma,ecs,0>;
        #break
        #range (1,2)
          #local rgb1 = <ecs,chroma,0>;
        #break
        #range (2,3)
          #local rgb1 = <0,chroma,ecs>;
        #break
        #range (3,4)
          #local rgb1 = <0,ecs,chroma>;
        #break
        #range (4,5)
          #local rgb1 = <ecs,0,chroma>;
        #break
        #range (5,6)
          #local rgb1 = <chroma,0,ecs>;
        #break
      #end
      #declare HATpigment[i] = rgb (rgb1 + <cmin,cmin,cmin>);
    #end
    #local i = i + 1;
  #end
#end

#local ttx11 = 2;
#local tty11 = 0;
#local tt11 = <ttx11,tty11>;

#declare tile11 =
#ifdef (isotiling_tiles)
  union {
    cone {
      //SPbd[7], 0.1
      SPbdisoC, 0.1
      SPbdisoA, 0.05
    }
    cone {
      //SPbd[5], 0.05
      //SPbd[9], 0.1
      SPbdisoD, 0.05
      SPbdisoB, 0.1
    }
#else
  union {
    prism {
      linear_sweep
      linear_spline
      0, // sweep the following shape from here ...
      h, // ... up through here
      n+1, // the number of points making up the shape ...
      #local i = 0;
      #while (i < n)
        pointstile11[i]-tt11,
        #local i = i + 1;
      #end
      pointstile11[0]-tt11
    }
    prism {
      conic_sweep
      linear_spline
      1-tile_eps,
      1,
      n+1,
      #local i = 0;
      #while (i < n)
        pointstile11[i]-tt11,
        #local i = i + 1;
      #end
      pointstile11[0]-tt11
      scale <1,-1,1>
      translate y
      scale <1,tile_f,1>
      translate h*y
    }
    translate ttx11*x + tty11*z
    scale <-1,1,1>
    rotate 90*y
#end
}

//#ifndef (T_spectre) #declare T_spectre = texture {White_Marble} #end
#ifndef (T_spectre) #declare T_spectre = texture {pigment {Pink}} #end
#ifndef (T_mystic) #declare T_mystic = texture {Aluminum} #end
#ifndef (T_mysticb) #declare T_mysticb = texture {Blue_Agate} #end
#ifndef (T_greenspectre) #declare T_greenspectre = texture {pigment {rgb <0.4,0.8,0.4>}} #end
#ifndef (T_greenmystic) #declare T_greenmystic = texture {pigment {rgb <0.7,1.0,0.7>}} #end
#ifndef (T_greenmysticb) #declare T_greenmysticb = texture {pigment {rgb <0.5,1.0,0.5>}} #end
#ifndef (T_grayspectre) #declare T_grayspectre = texture {pigment {rgb <0.09,0.09,0.09>}} #end
#ifndef (T_graymystic) #declare T_graymystic = texture {pigment {rgb 5*<0.06,0.06,0.06>}} #end
#ifndef (T_graymysticb) #declare T_graymysticb = texture {pigment {rgb <0.03,0.03,0.03>}} #end
#ifndef (T_whitespectre) #declare T_whitespectre = texture {pigment {rgb <0.8,0.8,0.8>}} #end
#ifndef (T_whitemystic) #declare T_whitemystic = texture {pigment {rgb <1.00,1.00,1.00>}} #end
#ifndef (T_whitemysticb) #declare T_whitemysticb = texture {pigment {rgb <0.9,0.9,0.9>}} #end

#declare spectre =
object { tile11
  texture {T_spectre
    finish {tile_Finish}
  }
}

#declare greenspectre =
object { tile11
  texture {T_greenspectre
    finish {tile_Finish}
  }
}

#declare grayspectre =
object { tile11
  texture {T_grayspectre
    finish {tile_Finish}
  }
}

#declare whitespectre =
object { tile11
  texture {T_whitespectre
    finish {tile_Finish}
  }
}

#declare mystic_tr = transform {
#ifdef (isotiling_tiles)
  translate 0.1*x
  //rotate -30*y
  //translate -<1/2,0,ap-3>
#else
  translate <-1,0,0>
  rotate -30*y
  translate -<1/2,0,ap-3>
#end
}

#declare mystic = union {
  object { tile11
    transform {mystic_tr}
    //translate <-1,0,0>
    //rotate -30*y
    //translate -<1/2,0,ap-3>
    texture {T_mystic
      finish {tile_Finish}
    }
  }
  object { tile11
    //translate <1/2,0,ap-3>
    //rotate 30*y
    //translate <1,0,0>
    texture {T_mysticb
      finish {tile_Finish}
    }
  }
}

#declare blueyellowmystic = union {
  object { tile11
    transform {mystic_tr}
    texture {pigment {color Yellow}
      finish {tile_Finish}
    }
  }
  object { tile11
    texture {pigment {color Blue} 
      finish {tile_Finish}
    }
  }
}

#declare greenmystic = union {
  object { tile11
    transform {mystic_tr}
    texture {T_greenmystic
      finish {tile_Finish}
    }
  }
  object { tile11
    texture {T_greenmysticb
      finish {tile_Finish}
    }
  }
}

#declare graymystic = union {
  object { tile11
    transform {mystic_tr}
    texture {T_graymystic
      finish {tile_Finish}
    }
  }
  object { tile11
    texture {T_graymysticb
      finish {tile_Finish}
    }
  }
}

#declare whitemystic = union {
  object { tile11
    transform {mystic_tr}
    texture {T_whitemystic
      finish {tile_Finish}
    }
  }
  object { tile11
    texture {T_whitemysticb
      finish {tile_Finish}
    }
  }
}

#declare SPobj = array[8];
#declare SPpigment = array[8];

#ifndef (desertlike) #declare desertlike=0; #end

#macro SPinitcolors ()

  #local i = 1;
  #while (i < 8)
    //#declare SPpigment[i] = rgb <1,1,1>-(1/3-(i-1)/27)*<0,1,1>;

    //#declare SPpigment[i] = rgb <1,1,1>-((i-1+2)/(6+2))*<0,1,1>;
    #declare SPpigment[i] = rgb <1,1,1>-((i-1+2)/(6+2+desertlike))*<0,1,1>;

    //#declare SPpigment[i] = rgb <1,0,0> + (1/(i+0.5))*<0,1,1>;
    #local i = i + 1;
  #end
#end

#macro rotcol (col)
  <col.y, col.z, col.x>
#end

/*
 * rot is in degrees in [0, 360]
 */

#macro SProtcolorshue (rot)
  #local i = 1;
  #while (i < 8)
    #local col = SPpigment[i];
    #local cmax = col.x;
    #local cmax = max3 (col.x, col.y, col.z);
    #local cmin = min3 (col.x, col.y, col.z);
    #local chroma = cmax - cmin;
    #if (chroma > 0)
      #if (cmax = col.x)
        #local huep = col.y - col.z;
      #else
        #if (cmax = col.y)
          #local huep = col.z - col.x + 2*chroma;
        #else
          #local huep = col.x - col.y + 4*chroma;
        #end
      #end
      #local huep = huep/chroma + rot/60;
      #if (huep < 0) #local huep = huep + 6; #end
      #if (huep >= 6) #local huep = huep - 6; #end
      #local huepmod2 = mod (huep, 2);
      #local ecs = chroma*(1 - abs(huepmod2 - 1));
      #switch (huep)
        #range (0,1)
          #local rgb1 = <chroma,ecs,0>;
        #break
        #range (1,2)
          #local rgb1 = <ecs,chroma,0>;
        #break
        #range (2,3)
          #local rgb1 = <0,chroma,ecs>;
        #break
        #range (3,4)
          #local rgb1 = <0,ecs,chroma>;
        #break
        #range (4,5)
          #local rgb1 = <ecs,0,chroma>;
        #break
        #range (5,6)
          #local rgb1 = <chroma,0,ecs>;
        #break
      #end
      #declare SPpigment[i] = rgb (rgb1 + <cmin,cmin,cmin>);
    #end
    #local i = i + 1;
  #end
#end

#macro SProtcolors ()
  #local i = 1;
  #while (i < 8)
    #declare SPpigment[i] = rgb rotcol (SPpigment[i]);
    #local i = i + 1;
  #end
#end

#macro SPdarkencolors (darken)
  #local i = 1;
  #while (i < 8)
    #declare SPpigment[i] = darken*SPpigment[i];
    #local i = i + 1;
  #end
#end

#macro SPbuildtiles ()
  #local i = 1;
  #while (i < 8)
    #declare SPobj[i] = object{spectre
      texture {pigment {SPpigment[i]}}
    }
    #local i = i + 1;
  #end
#end

SPinitcolors()
#ifdef (starthue) SProtcolorshue (starthue) #end

#declare SPobj[0] = object{mystic}

SPbuildtiles ()

/*
#local i = 1;
#while (i < 8)
  // #declare SPpigment[i] = rgb <1,1,1>-(1/3-(i-1)/27)*<0,1,1>;
  #declare SPobj[i] = object{spectre
     //texture {pigment {rgb <1,1,1>-(1/3-(i-1)/27)*<0,1,1>}}
     texture {pigment {SPpigment[i]}}
  }
  #local i = i + 1;
#end
 */
