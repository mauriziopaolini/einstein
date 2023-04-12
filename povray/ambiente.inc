#include "woods.inc"

#declare tavolo = plane {
  y,0
  texture {T_Wood10 scale 2 rotate 25*y}
}

#declare landa_desolata = plane { 
  y,0
  pigment { color Gray }
}

#macro luci ()
  light_source { 20*<1, 1, -1> color 0.5*White }
  light_source { 25*<-1, 1, 1> color White }
#end

#macro lucitop ()
  light_source { 20*<1, 1, -1> color 0.5*White }
  light_source { 25*<-1, 1, 0.1> color White }
#end

#macro vista45gradi ()
  camera {
    angle 20
    location 8*<0, 6, -6>
    look_at <0, 0, 0>
  }
#end

#macro vistaaerea ()
  camera {
    angle 20
    location 2*Phi*<0.5, 14, -2>
    look_at <0, 0, 0>
  }
#end

#declare Tex_Dark_Table =
texture {
  pigment {
    wood
    color_map {
      [ 0.0000  color rgb<0.6431, 0.3176, 0.0824> ]
      [ 0.1000  color rgb<0.6196, 0.2824, 0.0588> ]
      [ 0.2000  color rgb<0.7137, 0.3725, 0.1529> ]
      [ 0.3000  color rgb<0.7529, 0.4157, 0.1922> ]
      [ 0.4000  color rgb<0.8157, 0.4941, 0.2588> ]
      [ 0.5000  color rgb<0.7686, 0.4745, 0.2196> ]
      [ 0.6000  color rgb<0.8471, 0.5647, 0.2980> ]
      [ 0.7000  color rgb<0.8627, 0.5843, 0.3137> ]
      [ 0.8000  color rgb<0.8902, 0.6314, 0.3529> ]
      [ 0.9000  color rgb<0.8627, 0.6118, 0.3294> ]
      [ 1.0000  color rgb<0.8392, 0.5922, 0.3098> ]
    }

    turbulence <0.075, 0.075, 0.65>
    scale      <0.04, 0.04, 0.6>

    scale 0.27
    rotate 91*y
    translate -0.1*z
  }
  finish {
    ambient 0.0
    diffuse 0.4
    specular 0.3
    roughness 0.025

    reflection {
      0.17
      metallic
    }
  }
  normal {
    granite 0.015
    scale <0.02, 0.02, 0.06>
    rotate 91*y
    accuracy 0.007
    scale 4
  }
}

/*
 * a parte il fatto che e' illimitato, questo e' esattamente
 * il tavolo che si trova sotto i tasselli nella sequenza
 * "ricorsione".  Puo' essere opportunamente riscalato e
 * ruotato per maggiore effetto.
 */

#declare tavolo_ricorsione = plane {
  y,0
  texture {Tex_Dark_Table
    translate -0.43*z
    rotate -90*x
    //scale 8/1.5*pow(Phi,5+1)
    scale 95.70278352
  }
}

#declare tavolo2 = object {
  tavolo_ricorsione
  scale 0.5
  rotate -20*y
}

#ifndef (Fast)
  #declare Fast = 0;
#end

#declare tavolobianco =
plane
{ y, 0
  #if(Fast)
    pigment { rgb <1, .9, .7> }
  #else
    texture
    { average texture_map
      { #declare S = seed(0);
        #local ReflColor = .8*<1, .9, .7> + .2*<1,1,1>;
        #declare Ind = 0;
        #while(Ind < 20)
          [1 pigment { rgb <1, .9, .7> }
             normal { bumps .1 translate <rand(S),rand(S),rand(S)>*100 scale .001 }
             finish { reflection { ReflColor*.1, ReflColor*.5 } }
          ]
          #declare Ind = Ind+1;
        #end
      }
    }
  #end
}
