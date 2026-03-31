
/*
 * dim: max number of worm tiles in vector
 */

#macro worm_init (wormdim)
  //#declare wormdim = dim;

  #declare wormtr = array[wormdim]
  #declare wormid = array[wormdim]
#end

#macro sig2id (sig)
  mod (sig, 10)
#end

#macro sig2tr (sig, sigh)
  #local sigloc = sig;
  #local sigtail = mod (sigloc, 10);
  transform {
  #local ii = 0;
  #while (ii < 6)
    #local sigtail = mod (sigloc, 10);
    Str[sigtail][ii]
    #local sigloc = int (sigloc/10);
    #local ii = ii + 1;
  #end
  #local sigloc = sigh;
  #local sigtail = mod (sigloc, 10);
  #while (sigloc)
    #local sigtail = mod (sigloc, 10);
    Str[sigtail][ii]
    #local sigloc = int (sigloc/10);
    #local ii = ii + 1;
  #end
  }
#end

#macro sig2rot (sig, sigh)
  #local sigloc = sig;
  #local sigtail = mod (sigloc, 10);
  #local myrot = 0;
  #local ii = 0;
  #while (ii < 6)
    #local sigtail = mod (sigloc, 10);
    #local myrot = Srot[sigtail] - myrot; // difference is to compensate for mirroring
    #local sigloc = int (sigloc/10);
    #local ii = ii + 1;
  #end
  #local sigloc = sigh;
  #local sigtail = mod (sigloc, 10);
  #while (sigloc)
    #local sigtail = mod (sigloc, 10);
    #local myrot = Srot[sigtail] - myrot;
    #local sigloc = int (sigloc/10);
    #local ii = ii + 1;
  #end
  myrot
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

/*
#declare follow_eo[0][2] = 0.433333;
#declare follow_eo[0][3] = 2.333333;
#declare follow_eo[0][5] = 0.463333;
#declare follow_eo[0][6] = 5.333333;

#declare follow_eo[1][3] = 4.633333;
#declare follow_eo[1][4] = 5.633333;
#declare follow_eo[1][5] = 0.233333;
 */

#declare follow_eo[0][2] = 1.3/3;  //0.433333;
#declare follow_eo[0][3] = 7/3;    //2.333333;
#declare follow_eo[0][5] = 1.39/3; //0.463333;
#declare follow_eo[0][6] = 16/3;   //5.333333;

#declare follow_eo[1][3] = 13.9/3; //4.633333;
#declare follow_eo[1][4] = 16.9/3; //5.633333;
#declare follow_eo[1][5] = 0.7/3;  //0.233333;

#macro prec_in_worm (sig, wriggly)
  #local tenpow = 1;
  #local sigh = sig;
  #local eo = wriggly; // even if less-wriggly
  #local newsig = -1;
  #while (sigh > 0)

    #local sym = mod(sigh,10);
    #local sigh = int (sigh/10);

    #if (sym > 0)
      #if (follow_eo[eo][sym] = 0)
        #debug concat ("WARNING: undefined follow_eo[", str(eo,0,0), ",", str(sym,0,0), "], sig = ", str(sig,0,0), "\n")
      #end
      #local sym = int(tenpow*follow_eo[eo][sym]);
      #local newsig = 10*tenpow*sigh + sym;
      #break
    #end
    #local tenpow = 10*tenpow;
    #local eo = 1 - eo;
    #if (newsig >= 0) #break #end
  #end

  #if (newsig < 0)
    #debug concat ("WARNING: Cannot compute prec of ", str(sig,0,-1), "\n")
    0;
  #else
    newsig;
  #end

#end

/*
 * the following can be removed as soon as we are confident on the above
 */

#macro prec_in_worm_old (sig,wriggly)
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
              #local sym = mod(sigh,10);
              #local sigh = int (sigh/10);
              #local tenpow = 10*tenpow;  //100000
              #local eo = 1 - eo; // even
              #if (sym = 0)
                #debug concat ("WARNING: Cannot compute prec of ", str(sig,0,-1), "\n")
                sig;
              #else
                //#local sym = int(1000000*follow_eo[eo][sym]);
                //#local newsig = 10000000*sigh + sym;
                #local sym = int(tenpow*follow_eo[eo][sym]);
                #local newsig = 10*tenpow*sigh + sym;
                //#local tenpow = 10*tenpow;  //1000000
                //#local eo = 1 - eo; // even
                newsig;
              #end
            #else
              //#local sym = int(100000*follow_eo[eo][sym]);
              //#local newsig = 1000000*sigh + sym;
              #local sym = int(tenpow*follow_eo[eo][sym]);
              #local newsig = 10*tenpow*sigh + sym;
              //#local tenpow = 10*tenpow;  //1000000
              //#local eo = 1 - eo; // even
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


#declare tripod_center_s = <0,0,2>;
#declare tripod_center = vtransform (tripod_center_s, transform {mystic_tr});
#declare over_neck = (-0.5-ap)*x + ap*z + 1.5*z;
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
  translate -over_neck
  rotate rot*y
  translate over_neck
#end

#macro SProtspectrew (rot)
  translate -tripod_center_s
  rotate rot*y
  translate tripod_center_s
#end
