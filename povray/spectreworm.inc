
/*
 * dim: max number of worm tiles in vector
 */

#macro worm_init (wormdim)
  //#declare wormdim = dim;

  #declare wormtr = array[wormdim]
  #declare wormid = array[wormdim]
#end

#macro newwormtile (sig)
  #local sigloc = sig;
  #local sigtail = mod (sigloc, 10);
  #declare wormid[wormi] = sigtail;
  #declare wormtr[wormi] = transform {
  #local ii = 0;
  //#while (sigloc)
  #while (ii < depth)
    #local sigtail = mod (sigloc, 10);
    transform Str[sigtail][ii]
    #local sigloc = int (sigloc/10);
    #local ii = ii + 1;
  #end
  }
  #declare wormi = wormi + 1;
#end

/*
 * max depth possible: 6
 */

#declare follow0 = array[7];
#declare follow0[2] = 0;
#declare follow0[3] = 2;
#declare follow0[5] = 0;
#declare follow0[6] = 5;
#declare follow1 = array[6];
#declare follow1[3] = 46;
#declare follow1[4] = 56;
#declare follow1[5] = 02;
#declare follow2 = array[7];
#declare follow2[2] = 043;
#declare follow2[3] = 233;
#declare follow2[5] = 046;
#declare follow2[6] = 533;
#declare follow3 = array[6];
#declare follow3[3] = 4633;
#declare follow3[4] = 5633;
#declare follow3[5] = 0233;
#declare follow4 = array[7];
#declare follow4[2] = 04333;
#declare follow4[3] = 23333;
#declare follow4[5] = 04633;
#declare follow4[6] = 53333;
#declare follow5 = array[6];
#declare follow5[3] = 463333;
#declare follow5[4] = 563333;
#declare follow5[5] = 023333;

#macro prec_in_worm (sig)
  #local sig10 = int (sig/10);
  #local sym = sig - 10*sig10;
  #if (sym != 0)
    #local sym = follow0[sym];
    #local newsig = 10*sig10 + sym;
    newsig;
  #else
    #local sig100 = int (sig10/10);
    #local sym = sig10 - 10*sig100;
    #if (sym != 0)
      #local sym = follow1[sym];
      #local newsig = 100*sig100 + sym;
      newsig;
    #else
      #local sig1000 = int (sig100/10);
      #local sym = sig100 - 10*sig1000;
      #if (sym != 0)
        #local sym = follow2[sym];
        #local newsig = 1000*sig1000 + sym;
        newsig;
      #else
        #local sig10000 = int (sig1000/10);
        #local sym = sig1000 - 10*sig10000;
        #if (sym != 0)
          #local sym = follow3[sym];
          #local newsig = 10000*sig10000 + sym;
          newsig;
        #else
          #local sig100000 = int (sig10000/10);
          #local sym = sig10000 - 10*sig100000;
          #if (sym != 0)
            #local sym = follow4[sym];
            #local newsig = 100000*sig100000 + sym;
            newsig;
          #else
            #local sig1000000 = int (sig100000/10);
            #local sym = sig100000 - 10*sig1000000;
            #if (sym != 0)
              #local sym = follow5[sym];
              #local newsig = 1000000*sig1000000 + sym;
              newsig;
            #else
              #debug concat ("WARNING: Cannot compute prec of ", str(sig,0,-1), "\n")
              sig;
            #end
          #end
        #end
      #end
    #end
  #end
#end

#declare tripod_center_s = <0,0,2>;
#declare tripod_center = vtransform (tripod_center_s, transform {mystic_tr});
#declare extra_center = <-5/4-ap/2,0,9/4-ap/2>;

#macro SProtmystic (rot)
  translate -tripod_center
  rotate rot*y
  translate tripod_center
#end

#macro SProtspectre (rot)
  translate -extra_center
  rotate rot*y
  translate extra_center
#end
