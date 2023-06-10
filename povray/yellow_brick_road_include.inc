/*
 * various declarations/splines/macros
 */

#declare smoothp = spline {
  cubic_spline
  -1, 1*x
  0, 0*x
  1, 1*x
  2, 0*x
}

#declare speedup_spline = spline {
  linear_spline
  0, 0*x
  99999, 99999*x
}

#macro build_wormAB (depth)
  #declare wormA = "A";
  #declare wormB = "B";

  #local i = 0;
  #while (i < depth)
    #local i = i + 1;
    #declare wormA = concat (wormA, wormB);
    #declare wormB = concat (wormA, wormB);
  #end
#end

#macro define_speedup_spline (realtime, speedup_time)

  #debug concat ("  define_speedup_spline called with: ", str(realtime,0,-1), " ", str(speedup_time,0,-1), "\n")

  #if (realtime <= speedup_time)

    #declare speedup_spline = spline {
      linear_spline
      0, 0*x
      realtime, realtime*x
    }

  #else  /* for now just the identity */

    #local xx = speedup_time/4;
    #local m = (realtime - 2*xx)/(speedup_time - 2*xx);
    #debug concat ("  ===> First guess at m: ", str(m,0,-1), "\n")
    #local m = int(m+1);
    #debug concat ("  ===> Second guess at m: ", str(m,0,-1), "\n")

    #declare xx1 = (m*speedup_time - realtime)/(2*m - 2);
    #declare xx2 = speedup_time - xx1;
    #debug concat ("  ===>  xx1: ", str(xx1,0,-1), "\n")
    #debug concat ("  ===>  xx2: ", str(xx2,0,-1), "\n")
    #declare speedup_value = m;

    #declare speedup_spline = spline {
      linear_spline
      0, 0*x
      xx1, xx1*x
      xx2, (realtime - xx1)*x
      speedup_time, realtime*x
    }

  #end

#end

#macro castle (aspect, jpgimage)
  #local height = 12;
  #local cwidth = aspect*height;
  box {<0,0,0>,<1,1,0.1>
    pigment {image_map {jpeg jpgimage}}
    translate -0.5*x
    scale 0.5*<cwidth, height, height>
    translate 2*tile_thick*y
    finish {tile_Finish}
  }
#end

#macro roadsign (rstext, rstext2)
  #local height = 4;
  #local postwidth = 0.2;
  #local signwidth = 2;
  #local signheight = 1.2;
  #local signthickness = 0.1;
  #local len1 = strlen (rstext);
  #local len2 = strlen (rstext2);
  #local signwidth = 0.5*max(len1,len2)*0.5+0.2;
  cylinder {0, (height-signheight)*y, postwidth
    texture {T_Wood3
      finish {tile_Finish}
    }
  }
  box {<-0.5*signwidth, height-signheight, -signthickness/2>, <0.5*signwidth, height, signthickness/2>
    texture {T_Wood3
      finish {tile_Finish}
    }
  }
  text {ttf textfont rstext 0.1 0
    translate -0.5*len1*0.6*x
    scale 0.4
    translate height*y - 0.5*y
    translate - 0.5*signthickness*z
    translate - 0.5*0.1*z
    texture {pigment {color Black}
      finish {tile_Finish}
    }
  }
  text {ttf textfont rstext2 0.1 0
    translate -0.5*len2*0.6*x
    scale 0.4
    translate height*y - 1.0*y
    translate - 0.5*signthickness*z
    translate - 0.5*0.1*z
    texture {pigment {color Black}
      finish {tile_Finish}
    }
  }
#end
