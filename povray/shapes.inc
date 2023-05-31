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

#ifndef (T_spectre) #declare T_spectre = texture {White_Marble} #end
#ifndef (T_mystic) #declare T_mystic = texture {Aluminum} #end
#ifndef (T_mysticb) #declare T_mysticb = texture {Blue_Agate} #end

#declare spectre =
object { tile11
  texture {T_spectre
    finish {tile_Finish}
  }
}

#declare mystic = union {
  object { tile11
    texture {T_mystic
      finish {tile_Finish}
    }
  }
  object { tile11
    translate <1/2,0,ap-3>
    rotate 30*y
    translate <1,0,0>
    texture {T_mysticb
      finish {tile_Finish}
    }
  }
}


