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

// #declare rabbits = array[20]
#declare wormA = array[10]
#declare wormB = array[10]

#macro build_wormAB (depth)
  #declare wormA[0] = "A";
  #declare wormB[0] = "B";

  #local i = 0;
  #while (i < depth)
    #local i = i + 1;
    #declare wormA[i] = concat (wormA[i-1], wormB[i-1]);
    #declare wormB[i] = concat (wormA[i], wormB[i-1]);
  #end
#end

/*
#macro build_rabbits (depth)
  #declare rabbits[0] = "0";
  #declare rabbits[1] = "1";

  #local i = 1;
  #while (i < depth)
    #local i = i + 1;
    #declare rabbits[i] = concat(rabbits[i-1], rabbits[i-2]);
  #end
#end
 */

