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
