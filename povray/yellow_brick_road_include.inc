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

#macro build_wormAB (depth)
  #declare wormA = "A";
  #declare wormB = "B";

  #local i = 0;
  #while (i < depth)
    #local i = i + 1;
    // #declare wormBold = wormB;
    // #declare wormA = concat (wormA, wormBold);
    // #declare wormB = concat (wormA, wormBold);
    #declare wormA = concat (wormA, wormB);
    #declare wormB = concat (wormA, wormB);
  #end
#end

