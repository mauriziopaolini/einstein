#declare h = 0.1;

#include "textures.inc"
#include "colors.inc"

#declare phi = (sqrt(5)-1)/2;
#declare ap = sqrt(3)/2;

#local n = 13;
#local tile_eps=0.05;  /* svaso in cima */
#local tile_f=0.5;     /* pendenza svaso in cima */

#local pointshat=array[n]
{<0,0>, <3/4,ap/2>, <1/2,ap>, <-1/2,ap>, <-3/4,ap/2>,
 <-3/2,ap>, <-9/4,ap/2>, <-2,0>, <-3/2,0>,
 <-3/2,-ap>, <-3/4,-3/2*ap>, <-1/2,-ap>, <0,-ap>}

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
  translate -ttx*x - tty*y
}

#declare hatr =
object {hat
  scale <-1,1,1>
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
    pigment {color c1}
  }
  object {hat
    rotate -60*y
    translate 1.5*x
    translate ap*z
    pigment {color c2}
  }
  object {hat
    rotate -60*y
    translate -1.5*x
    translate ap*z
    pigment {color c2}
  }
  object {hat
    rotate 60*y
    translate 0*x
    translate 2*ap*z
    pigment {color c2}
  }
  object {hat
    rotate 0*y
    translate -1.5*x
    translate 3*ap*z
    pigment {color c3}
  }
  object {hat
    rotate -120*y
    translate -1.5*x
    translate -ap*z
    pigment {color c3}
  }
  object {hat
    rotate 180*y
    translate 0*x
    translate -2*ap*z
    pigment {color c3}
  }
#end

#declare h7m = union {
  h7list (h7c1, h7c2, h7c3)

}

#declare h8m = union {
  h7list (h8c1, h8c2, h8c3)

  object {hat
    rotate -60*y
    translate -3*x
    translate 2*ap*z
    pigment {color h8c3}
  }
}

#declare h7worm = union {
  h7list (Blue, h7c1, h7c2)
}

#declare h8worm = union {
  h7list (Blue, h8c1, h8c2)

  object {hat
    rotate -60*y
    translate -3*x
    translate 2*ap*z
    pigment {color h8c2}
  }
}

#ifndef (sambient)
  #declare sambient=0.3;
#end
#ifndef (sdiffuse)
  #declare sdiffuse=1;
#end

#ifndef (T_hat)
  #declare T_hat = texture {White_Marble}
#end

#ifndef (T_hatr)
  #declare T_hatr = texture {Blue_Agate}
#end

#declare tile_Finish =
finish {
        ambient sambient diffuse sdiffuse
        specular 0.5 roughness 0.05
        phong .75
}

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


