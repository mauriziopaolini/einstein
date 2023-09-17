
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

#declare follow_eo = array[2][7];

#declare follow_eo[0][2] = 0.43333;
#declare follow_eo[0][3] = 2.33333;
#declare follow_eo[0][5] = 0.46333;
#declare follow_eo[0][6] = 5.33333;

#declare follow_eo[1][3] = 4.63333;
#declare follow_eo[1][4] = 5.63333;
#declare follow_eo[1][5] = 0.23333;

#macro prec_in_worm (sig,wriggly)
  #local tenpow = 1;
  #local sigh = sig;
  #local eo = wriggly; // even if less-wriggly

  #local sym = mod(sigh,10);
  #local sigh = int (sigh/10);
  #if (sym = 0)
    #local sym = mod(sigh,10);
    #local sigh = int (sigh/10);
    #local tenpow = 10*tenpow;  //10
    #local eo = 1 - eo; // odd
    #if (sym = 0)
      #local sym = mod(sigh,10);
      #local sigh = int (sigh/10);
      #local tenpow = 10*tenpow;  //100
      #local eo = 1 - eo; // even
      #if (sym = 0)
        #local sym = mod(sigh,10);
        #local sigh = int (sigh/10);
        #local tenpow = 10*tenpow;  //1000
        #local eo = 1 - eo; // odd
        #if (sym = 0)
          #local sym = mod(sigh,10);
          #local sigh = int (sigh/10);
          #local tenpow = 10*tenpow;  //10000
          #local eo = 1 - eo; // even
          #if (sym = 0)
            #local sym = mod(sigh,10);
            #local sigh = int (sigh/10);
            #local tenpow = 10*tenpow;  //100000
            #local eo = 1 - eo; // odd
            #if (sym = 0)
              #debug concat ("WARNING: Cannot compute prec of ", str(sig,0,-1), "\n")
              sig;
            #else
              #local sym = int(100000*follow_eo[eo][sym]);
              #local newsig = 1000000*sigh + sym;
              #local tenpow = 10*tenpow;  //1000000
              #local eo = 1 - eo; // even
              newsig;
            #end
          #else
            #local sym = int(tenpow*follow_eo[eo][sym]);
            #local newsig = 10*tenpow*sigh + sym;
            newsig;
          #end
        #else
          #local sym = int(tenpow*follow_eo[eo][sym]);
          #local newsig = 10*tenpow*sigh + sym;
          newsig;
        #end
      #else
        #local sym = int(tenpow*follow_eo[eo][sym]);
        #local newsig = 10*tenpow*sigh + sym;
        newsig;
      #end
    #else
      #local sym = int(tenpow*follow_eo[eo][sym]);
      #local newsig = 10*tenpow*sigh + sym;
      newsig;
    #end
  #else
    #local sym = int(tenpow*follow_eo[eo][sym]);
    #local newsig = 10*tenpow*sigh + sym;
    newsig;
  #end
#end

/*
#macro prec_in_worm (sig)
  #local sig10 = int (sig/10);
  #local sym = sig - 10*sig10;
  #if (sym != 0)
    #local sym = int(follow_e[sym]);
    #local newsig = 10*sig10 + sym;
    newsig;
  #else
    #local sig100 = int (sig10/10);
    #local sym = sig10 - 10*sig100;
    #if (sym != 0)
      #local sym = int(10*follow_o[sym]);
      #local newsig = 100*sig100 + sym;
      newsig;
    #else
      #local sig1000 = int (sig100/10);
      #local sym = sig100 - 10*sig1000;
      #if (sym != 0)
        #local sym = int(100*follow_e[sym]);
        #local newsig = 1000*sig1000 + sym;
        newsig;
      #else
        #local sig10000 = int (sig1000/10);
        #local sym = sig1000 - 10*sig10000;
        #if (sym != 0)
          #local sym = int(1000*follow_o[sym]);
          #local newsig = 10000*sig10000 + sym;
          newsig;
        #else
          #local sig100000 = int (sig10000/10);
          #local sym = sig10000 - 10*sig100000;
          #if (sym != 0)
            #local sym = int(10000*follow_e[sym]);
            #local newsig = 100000*sig100000 + sym;
            newsig;
          #else
            #local sig1000000 = int (sig100000/10);
            #local sym = sig100000 - 10*sig1000000;
            #if (sym != 0)
              #local sym = int(100000*follow_o[sym]);
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
 */

#declare tripod_center_s = <0,0,2>;
#declare tripod_center = vtransform (tripod_center_s, transform {mystic_tr});
#declare waist_center = 1.5*z - 0.5*x;
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

#macro SProtmysticw (rot)
  translate -waist_center
  rotate rot*y
  translate waist_center
#end

#macro SProtspectrew (rot)
  translate -extra_center
  rotate 0*rot*y
  translate extra_center
#end
