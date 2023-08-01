#declare h = 0.1;

#include "textures.inc"
#include "colors.inc"

#declare phi = (sqrt(5)-1)/2;
#declare Phi = (sqrt(5)+1)/2;
#declare ap = sqrt(3)/2;

#local n = 13;
#local tile_eps=0.05;  /* svaso in cima */
#local tile_f=0.5;     /* pendenza svaso in cima */
#declare tile_thick = (h + tile_eps*tile_f);

#local pointshat=array[n]
{<0,0>, <3/4,ap/2>, <1/2,ap>, <-1/2,ap>, <-3/4,ap/2>,
 <-3/2,ap>, <-9/4,ap/2>, <-2,0>, <-3/2,0>,
 <-3/2,-ap>, <-3/4,-3/2*ap>, <-1/2,-ap>, <0,-ap>}

#local pointstile11=array[n]
{<0,0>, <-ap,-1/2>, <-ap+1/2,-1/2-ap>, <-ap+1/2+2,-1/2-ap>, <-ap+1/2+2+1/2,-1/2>, <3,-1>, <3+ap,-1/2>,
 <3+ap-1/2,-1/2+ap>, <3+ap-1/2-1,-1/2+ap>, <3+ap-1/2-1,-1/2+ap+1>, <3+ap-1/2-1-ap,-1/2+ap+1+1/2>,
 <1,1>, <0,1>}

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
  translate -ttx*x - tty*z
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

#local h7c1 = <1,0,0>;
#local h7c2 = <1,0.5,0.5>;
#local h7c3 = <1,0.75,0.75>;
#local h8c1 = <0,1,0>;
#local h8c2 = <0.5,1,0.5>;
#local h8c3 = <0.75,1,0.75>;

#macro h7list (c1, c2, c3)
  object {hatr
    rotate -120*y
    texture { pigment {color c1} finish {tile_Finish} }
  }
  object {hat
    rotate -60*y
    translate 1.5*x
    translate ap*z
    texture { pigment {color c2} finish {tile_Finish} }
  }
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

#local ttx11 = 2;
#local tty11 = 0;
#local tt11 = <ttx11,tty11>;

#declare tile11 =
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
}

//#ifndef (T_spectre) #declare T_spectre = texture {White_Marble} #end
#ifndef (T_spectre) #declare T_spectre = texture {pigment {Pink}} #end
#ifndef (T_mystic) #declare T_mystic = texture {Aluminum} #end
#ifndef (T_mysticb) #declare T_mysticb = texture {Blue_Agate} #end
#ifndef (T_greenspectre) #declare T_greenspectre = texture {pigment {rgb <0.4,0.8,0.4>}} #end
#ifndef (T_greenmystic) #declare T_greenmystic = texture {pigment {rgb <0.7,1.0,0.7>}} #end
#ifndef (T_greenmysticb) #declare T_greenmysticb = texture {pigment {rgb <0.5,1.0,0.5>}} #end
#ifndef (T_grayspectre) #declare T_grayspectre = texture {pigment {rgb <0.09,0.09,0.09>}} #end
#ifndef (T_graymystic) #declare T_graymystic = texture {pigment {rgb <0.03,0.03,0.03>}} #end
#ifndef (T_graymysticb) #declare T_graymysticb = texture {pigment {rgb <0.06,0.06,0.06>}} #end

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

#declare mystic_tr = transform {
  translate <-1,0,0>
  rotate -30*y
  translate -<1/2,0,ap-3>
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

#declare SPobj = array[8];
#declare SPpigment = array[8];

#macro SPinitcolors ()

  #local i = 1;
  #while (i < 8)
    //#declare SPpigment[i] = rgb <1,1,1>-(1/3-(i-1)/27)*<0,1,1>;
    #declare SPpigment[i] = rgb <1,1,1>-((i-1+2)/(6+2))*<0,1,1>;
    //#declare SPpigment[i] = rgb <1,0,0> + (1/(i+0.5))*<0,1,1>;
    #local i = i + 1;
  #end
#end

SPinitcolors()

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
