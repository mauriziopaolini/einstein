/*
 * usage:
 *  povray +a <self>.pov Declare=fase=<n>
 *
 *  The starting tiling is built based on the signature "[40]." but the idea is that it could resemble
 * a random tiling.
 *
 * a signature is a string of digits taken from
 * the set {0,1,2,3,4,5,6,7} and the pair 03 is forbidden
 */
/*
#finalclock 164
#numseconds 164
#durata 165
#coda 1
#titolo 5
 */

#version 3.7;

global_settings { assumed_gamma 1.0 }

#ifdef (bdthick) #declare doboundary=1; #end

#include "colors.inc"
#include "skies.inc"
#include "shapes.inc"
#include "spectresubdivision.inc"
#include "ambiente.inc"

#local duration_pre1 = 3; #local tpre1 = duration_pre1; #local duration_1 = 5; #local t1 = tpre1 + duration_1;
#local duration_pre2 = 2; #local tpre2 = t1 + duration_pre2; #local duration_2 = 5; #local t2 = tpre2 + duration_2;
#local duration_pre3 = 2; #local tpre3 = t2 + duration_pre3; #local duration_3 = 5; #local t3 = tpre3 + duration_3;
#local duration_pre4 = 2; #local tpre4 = t3 + duration_pre4; #local duration_4 = 5; #local t4 = tpre4 + duration_4;
#local duration_pre5 = 2; #local tpre5 = t4 + duration_pre5; #local duration_5 = 5; #local t5 = tpre5 + duration_5;
#local duration_pre6 = 2; #local tpre6 = t5 + duration_pre6; #local duration_6 = 5; #local t6 = tpre6 + duration_6;
#local duration_pre7 = 2; #local tpre7 = t6 + duration_pre7; #local duration_7 = 5; #local t7 = tpre7 + duration_7;
#local duration_pre8 = 5; #local tpre8 = t7 + duration_pre8; #local duration_8 = 5; #local t8 = tpre8 + duration_8;

#local duration_pre9 = 2; #local tpre9 = t8 + duration_pre9; #local duration_9 = 5; #local t9 = tpre9 + duration_9;
#local duration_pre10 = 1.5; #local tpre10 = t9 + duration_pre10; #local duration_10 = 4; #local t10 = tpre10 + duration_10;
#local duration_pre11 = 1.5; #local tpre11 = t10 + duration_pre11; #local duration_11 = 4; #local t11 = tpre11 + duration_11;
#local duration_pre12 = 1.5; #local tpre12 = t11 + duration_pre12; #local duration_12 = 4; #local t12 = tpre12 + duration_12;
#local duration_pre13 = 1.5; #local tpre13 = t12 + duration_pre13; #local duration_13 = 4; #local t13 = tpre13 + duration_13;
#local duration_pre14 = 1.5; #local tpre14 = t13 + duration_pre14; #local duration_14 = 4; #local t14 = tpre14 + duration_14;
#local duration_pre15 = 1.5; #local tpre15 = t14 + duration_pre15; #local duration_15 = 4; #local t15 = tpre15 + duration_15;
#local duration_pre16 = 4; #local tpre16 = t15 + duration_pre16; #local duration_16 = 4; #local t16 = tpre16 + duration_16;

#local duration_pre17 = 2; #local tpre17 = t16 + duration_pre17; #local duration_17 = 4; #local t17 = tpre17 + duration_17;
#local duration_pre18 = 1; #local tpre18 = t17 + duration_pre18; #local duration_18 = 3; #local t18 = tpre18 + duration_18;
#local duration_pre19 = 1; #local tpre19 = t18 + duration_pre19; #local duration_19 = 3; #local t19 = tpre19 + duration_19;
#local duration_pre20 = 1; #local tpre20 = t19 + duration_pre20; #local duration_20 = 3; #local t20 = tpre20 + duration_20;
#local duration_pre21 = 1; #local tpre21 = t20 + duration_pre21; #local duration_21 = 3; #local t21 = tpre21 + duration_21;
#local duration_pre22 = 1; #local tpre22 = t21 + duration_pre22; #local duration_22 = 3; #local t22 = tpre22 + duration_22;
#local duration_pre23 = 1; #local tpre23 = t22 + duration_pre23; #local duration_23 = 3; #local t23 = tpre23 + duration_23;
#local duration_pre24 = 3; #local tpre24 = t23 + duration_pre24; #local duration_24 = 4; #local t24 = tpre24 + duration_24;

#local duration_pre25 = 2; #local tpre25 = t24 + duration_pre25; #local duration_25 = 5; #local t25 = tpre25 + duration_25;

/*
 * times (tprex and tx) indicate the END time of the relative stage
 */

#debug concat ("=============== tpre1 = ", str(tpre1,0,-1), "\n")
#debug concat ("=============== tpre2 = ", str(tpre2,0,-1), "\n")
#debug concat ("=============== tpre3 = ", str(tpre3,0,-1), "\n")
#debug concat ("=============== tpre4 = ", str(tpre4,0,-1), "\n")
#debug concat ("=============== tpre5 = ", str(tpre5,0,-1), "\n")
#debug concat ("=============== tpre6 = ", str(tpre6,0,-1), "\n")
#debug concat ("=============== tpre7 = ", str(tpre7,0,-1), "\n")
#debug concat ("=============== tpre8 = ", str(tpre8,0,-1), "\n")
#debug concat ("=============== tpre9 = ", str(tpre9,0,-1), "\n")
#debug concat ("=============== tpre10 = ", str(tpre10,0,-1), "\n")
#debug concat ("=============== tpre11 = ", str(tpre11,0,-1), "\n")
#debug concat ("=============== tpre12 = ", str(tpre12,0,-1), "\n")
#debug concat ("=============== tpre13 = ", str(tpre13,0,-1), "\n")
#debug concat ("=============== tpre14 = ", str(tpre14,0,-1), "\n")
#debug concat ("=============== tpre15 = ", str(tpre15,0,-1), "\n")
#debug concat ("=============== tpre16 = ", str(tpre16,0,-1), "\n")
#debug concat ("=============== tpre17 = ", str(tpre17,0,-1), "\n")
#debug concat ("=============== tpre18 = ", str(tpre18,0,-1), "\n")
#debug concat ("=============== tpre19 = ", str(tpre19,0,-1), "\n")
#debug concat ("=============== tpre20 = ", str(tpre20,0,-1), "\n")
#debug concat ("=============== tpre21 = ", str(tpre21,0,-1), "\n")
#debug concat ("=============== tpre22 = ", str(tpre22,0,-1), "\n")
#debug concat ("=============== tpre23 = ", str(tpre23,0,-1), "\n")
#debug concat ("=============== tpre24 = ", str(tpre24,0,-1), "\n")
#debug concat ("=============== tpre25 = ", str(tpre25,0,-1), "\n")
#debug concat ("=============== Total duration in seconds: ", str(t25,0,-1), "\n")

#declare deftilerotaterate = 10;
#ifndef (tilerotate)
  #declare tilerotate = 0;
  #ifdef (animate)
    #if (animate > 1) #declare tilerotate = deftilerotaterate; #end // 20 degres per second 
  #end
#end

#declare minterp = 0;

/*
 * minterp in in [0,1] and decreasing inside the transition interval (tx - tprex, tx)
 */

#ifdef (animate)
  #local time = clock;
  #if (time < tpre1) #declare minterp = (tpre1-time)/duration_pre1; #declare fase = 1; #elseif (time < t1) #declare fase = 1;;
  #elseif (time < tpre2) #declare minterp = (tpre2-time)/duration_pre2; #declare fase = 2; #elseif (time < t2) #declare fase = 2;
  #elseif (time < tpre3) #declare minterp = (tpre3-time)/duration_pre3; #declare fase = 3; #elseif (time < t3) #declare fase = 3;
  #elseif (time < tpre4) #declare minterp = (tpre4-time)/duration_pre4; #declare fase = 4; #elseif (time < t4) #declare fase = 4;
  #elseif (time < tpre5) #declare minterp = (tpre5-time)/duration_pre5; #declare fase = 5; #elseif (time < t5) #declare fase = 5;
  #elseif (time < tpre6) #declare minterp = (tpre6-time)/duration_pre6; #declare fase = 6; #elseif (time < t6) #declare fase = 6;
  #elseif (time < tpre7) #declare minterp = (tpre7-time)/duration_pre7; #declare fase = 7; #elseif (time < t7) #declare fase = 7;
  #elseif (time < tpre8) #declare minterp = (tpre8-time)/duration_pre8; #declare fase = 8; #elseif (time < t8) #declare fase = 8;

  #elseif (time < tpre9) #declare minterp = (tpre9-time)/duration_pre9; #declare fase = 9; #elseif (time < t9) #declare fase = 9;
  #elseif (time < tpre10) #declare minterp = (tpre10-time)/duration_pre10; #declare fase = 10; #elseif (time < t10) #declare fase = 10;
  #elseif (time < tpre11) #declare minterp = (tpre11-time)/duration_pre11; #declare fase = 11; #elseif (time < t11) #declare fase = 11;
  #elseif (time < tpre12) #declare minterp = (tpre12-time)/duration_pre12; #declare fase = 12; #elseif (time < t12) #declare fase = 12;
  #elseif (time < tpre13) #declare minterp = (tpre13-time)/duration_pre13; #declare fase = 13; #elseif (time < t13) #declare fase = 13;
  #elseif (time < tpre14) #declare minterp = (tpre14-time)/duration_pre14; #declare fase = 14; #elseif (time < t14) #declare fase = 14;
  #elseif (time < tpre15) #declare minterp = (tpre15-time)/duration_pre15; #declare fase = 15; #elseif (time < t15) #declare fase = 15;
  #elseif (time < tpre16) #declare minterp = (tpre16-time)/duration_pre16; #declare fase = 16; #elseif (time < t16) #declare fase = 16;

  #elseif (time < tpre17) #declare minterp = (tpre17-time)/duration_pre17; #declare fase = 17; #elseif (time < t17) #declare fase = 17;
  #elseif (time < tpre18) #declare minterp = (tpre18-time)/duration_pre18; #declare fase = 18; #elseif (time < t18) #declare fase = 18;
  #elseif (time < tpre19) #declare minterp = (tpre19-time)/duration_pre19; #declare fase = 19; #elseif (time < t19) #declare fase = 19;
  #elseif (time < tpre20) #declare minterp = (tpre20-time)/duration_pre20; #declare fase = 20; #elseif (time < t20) #declare fase = 20;
  #elseif (time < tpre21) #declare minterp = (tpre21-time)/duration_pre21; #declare fase = 21; #elseif (time < t21) #declare fase = 21;
  #elseif (time < tpre22) #declare minterp = (tpre22-time)/duration_pre22; #declare fase = 22; #elseif (time < t22) #declare fase = 22;
  #elseif (time < tpre23) #declare minterp = (tpre23-time)/duration_pre23; #declare fase = 23; #elseif (time < t23) #declare fase = 23;
  #elseif (time < tpre24) #declare minterp = (tpre24-time)/duration_pre24; #declare fase = 24; #elseif (time < t24) #declare fase = 24;

  #elseif (time < tpre25) #declare minterp = (tpre25-time)/duration_pre25; #declare fase = 25; #elseif (time < t25) #declare fase = 25;

  #else #declare fase = 25;
  #end

  #declare gtrans0 = transform {rotate tilerotate*clock*y}
#else
  #declare gtrans0 = transform {rotate tilerotate*y}
#end


/*
 * splines definitions =================================================================
 */

#declare updown = spline {
  quadratic_spline
  0, 0*y
  0.5, 1*y
  1, 0*y
}

/*
 * Here is the signature that designates the "random" tiling ===========================
 */

#ifndef (Sigl) #declare Sigl = 404040; #end
#ifndef (Sigh) #declare Sigh = 404040; #end
//#ifndef (Sigl2) #declare Sigl2 = 040404; #end
//#ifndef (Sigh2) #declare Sigh2 = 040404; #end
#ifndef (depth) #declare depth = 5; #end
#ifndef (zoomout) #declare zoomout = 2; #end
#ifndef (minterp) #declare minterp = 1; #end

#ifndef (fase) #declare fase = 1; #end
#declare deltafase = 8;

#if (fase = 0.5) #declare minterp = clock; #declare fase = 1; #end
#if (fase = 0.5 + deltafase) #declare minterp = clock; #declare fase = 1+deltafase; #end
#if (fase = 0.5 + 2*deltafase) #declare minterp = clock; #declare fase = 1+2*deltafase; #end

#if (fase = 7.5)
  #declare minterp = clock;
  #declare fase = 8;
#end

#if (fase = 7.5 + deltafase)
  #declare minterp = clock;
  #declare fase = 8+deltafase;
#end

#if (fase = 7.5 + 2*deltafase)
  #declare minterp = clock;
  #declare fase = 8+2*deltafase;
#end

#declare tile_Finishb = finish {
        ambient 2*sambient diffuse 2*sdiffuse
        specular 0.5 roughness 0.05
        phong .75
}

//#macro buildsigs (sigh, sigl, sigh2, sigl2)
#macro buildsig (sigh, sigl)
  #local sig = sigl;
//  #local sig2 = sigl2;
  #local i = 0;
  #while (i < 12)
    #local sigq = int(sig/10);
//    #local sigq2 = int(sig2/10);
    #declare signature[i] = sig - 10*sigq;
    #local i = i + 1;
    #local sig = sigq;
//    #local sig2 = sigq2;
    #if (i = 6)
      #local sig = sigh;
//      #local sig2 = sigh2;
    #end
  #end
#end

/*
 * the rotational part of the tiles transformations is the same at all
 * depth levels
 */

#declare rots = array[8]
#declare rots[0] = 0;
#declare rots[1] = 120;
#declare rots[2] = 60;
#declare rots[3] = 60;
#declare rots[4] = 0;
#declare rots[5] = -60;
#declare rots[6] = -60;
#declare rots[7] = -120;

#declare Stran = array[8][maxdepth];

#local i = 0;
#while (i < maxdepth)
  #local j = 0;
  #while (j < 8)
    #declare Stran[j][i] = vtransform (<0,0,0>, transform {Str[j][i] scale <-1,1,1>});
    //#declare Str[j][i] = transform {rotate rots[j]*y translate Stran[j][i] scale <-1,1,1>};
    #local j = j + 1;
  #end
  #local i = i + 1;
#end

#declare signature = array[12]
//buildsigs (Sigh, Sigl, Sigh2, Sigl2)
buildsig (Sigh, Sigl)

#declare blow_up_scale = 2.805883701475779;

//#declare darkenvalue = 0.5;

#local sigstring=""
#local i = depth+1;
#while (i > 0)
  #local i = i - 1;
  #local sigstring=concat(sigstring,str(signature[i],0,0))
#end

#local sigstring=concat("...", sigstring,".")

#debug concat("SIGNATURE: ", sigstring, "\n")

#ifndef (depth) #declare depth = 5; #end

#declare magstep = sqrt(4+sqrt(15));
#declare mag = pow (magstep, depth);

#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

#declare ttransinv = array[depth][depth+2];
#declare tiletrans = array[depth];
#declare htilex = array[depth+2];

#macro build_ttransinv (signature, depth)
  #local dpth = 0;
  #while (dpth <= depth)

    #local k = 0;
    #while (k < depth)
      #declare tiletrans[k] = transform {scale <1,1,1>};
      #local k = k + 1;
    #end
    #local i = 0;
    #while (i < dpth)
      #local k = 0;
      #while (k < depth)
        #local strx = Str[signature[dpth-i-1+k]][dpth-i-1];
        #declare tiletrans[k] = transform {strx tiletrans[k]}
        #local k = k + 1;
      #end
      #local i = i + 1;
    #end

    #declare htilex[dpth] = signature[dpth];
    #local k = 0;
    #while (k < depth)
      #declare ttransinv[k][dpth] = transform {tiletrans[k] inverse}
      #local k = k + 1;
    #end
    #local dpth = dpth + 1;
  #end
#end

#declare Seed=seed(123);
#declare Seedm=seed(123);

#macro rndcol (myseed)
  #declare rndpigment = <rand(myseed), rand(myseed), rand(myseed)>;
#end

#macro brighten (amount)
  #declare rndpigment = <1,1,1> - amount*(<1,1,1> - rndpigment);
#end

#macro SPrec_infl (tid, trsf, depth)
  #local d = depth-1;
  #if (depth = 0)
    #if (tid = 0)
      object { tile11
        transform {mystic_tr}
        rndcol (Seed)
        texture {pigment {rgb rndpigment}} finish {tile_Finish}
        transform {trsf}
      }
    #end
    object {spectre
      rndcol (Seed)
      texture {pigment {rgb rndpigment}} finish {tile_Finish}
      transform {trsf}
    }

  #else
    #local i = 0;
    #while (i < 8)
      #if (tid != 0 | i != 3)
        SPrec_infl (i, transform {Str[i][d] trsf}, d)
      #end
      #local i = i + 1;
    #end
  #end
#end

#macro SPrec_infl2 (tid, trsf, depth, ptid, fase)
  #local d = depth-1;
  #if (depth = 0)
    //rndcol (Seed)
    #if (fase >= 4)
      #if (tid != 0 & tid != 3)
        object { tile11
          texture {pigment {rgb darkenfactor*rndpigment transmit mytransmit}} finish {tile_Finish}
          finish {tile_Finish}
          transform {trsf}
	  translate blowup_scale_c*ylift2*y
        }
      #end
    #end
    #if (fase >= 5 & tid = 3 & ptid != 0)
        object { tile11
          texture {pigment {rgb 0.7*darkenfactor*rndpigment transmit mytransmit}} finish {tile_Finish}
          finish {tile_Finish}
          transform {trsf}
	  translate blowup_scale_c*ylift3*y
        }
    #end
    #if (tid = 0)
      object { tile11
        transform {mystic_tr}
        texture {T_mysticb} finish {tile_Finishb}
        transform {trsf}
      }
      //rndcol (Seed)
      object { tile11
        texture {T_mysticb} finish {tile_Finish}
        transform {trsf}
      }
    #end
    #if (tid = 5 & fase = 2)
      object {spectre
        texture {T_mysticb} finish {tile_Finish}
        transform {trsf}
      }
    #end
    #if (tid = 5 & fase = 3)
      object {spectre
        texture {T_mysticb} finish {tile_Finish}
        transform {trsf}
        translate falsemysticdown*y
      }
    #end
  #else
    #if (fase >= 4 & d = 0) rndcol (Seed) #end
    #if (fase >= 4 & d = 0 & i = 0) rndcol (Seed) #end
    #local i = 0;
    #while (i < 8)
      #if (tid != 0 | i != 3)
        SPrec_infl2 (i, transform {Str[i][d] trsf}, d, tid, fase)
      #end
      #local i = i + 1;
    #end
  #end
#end

#declare move_it = 3.0*x + 1.0*z;
#declare scale_it = 1.3;

#macro SPrec_sparse (tid, trsf, depth)
  #local d = depth-1;
  #if (depth = 0)
    #if (tid = 0)
      object { tile11
        transform {mystic_tr}
        rndcol (Seed)
        //texture {T_mystic finish {tile_Finish} }
        texture {pigment {rgb rndpigment}} finish {tile_Finish}
        transform {scale scale_it translate move_it trsf}
	translate blowup_scale_c*ylift4*y
        //transform {Str[tid][d+1] trsf}
      }
    #end
    object {spectre
      rndcol (Seed)
      texture {pigment {rgb rndpigment}} finish {tile_Finish}
      transform {scale scale_it translate move_it trsf}
      translate blowup_scale_c*ylift4*y
      //transform {Str[tid][d+1] trsf}
    }

  #else
    #local i = 0;
    #while (i < 8)
      #if (tid != 0 | i != 3)
        SPrec_sparse (i, transform {Str[i][d+1] trsf}, d)
      #end
      #local i = i + 1;
    #end
  #end
#end


#macro SPrec_motion (tid, trsf, depth)
  #local d = depth-1;
  #if (depth = 0)
    #local zrise = 0.1*rand(Seedm)*y;
    #if (tid = 0)
      object { tile11
        transform {mystic_tr}
        rndcol (Seed)
        texture {pigment {rgb rndpigment}} finish {tile_Finish}
        //transform {trsf}
        //transform {scale scale_it translate move_it trsf}
        transform {scale (minterps + (1-minterps)*scale_it) translate (1-minterpm)*move_it trsf translate zrise}
      }
    #end
    object {spectre
      rndcol (Seed)
      texture {pigment {rgb rndpigment}} finish {tile_Finish}
      //transform {trsf}
      //transform {scale scale_it translate move_it trsf}
      transform {scale (minterps + (1-minterps)*scale_it) translate (1-minterpm)*move_it trsf translate zrise}
    }

  #else
    #local i = 0;
    #while (i < 8)
      #if (tid != 0 | i != 3)
        SPrec_motion (i, transform {rotate rots[i]*y
            translate (minterpm*Stran[i][d]+(1-minterpm)*Stran[i][d+1]) scale <-1,1,1> trsf}, d)
      #end
      #local i = i + 1;
    #end
  #end
#end


build_ttransinv (signature, depth)

#local blowup_scale_c = 1;
#local ciclo = 0;
#while (ciclo < 4)
  #declare falsemysticdown = -4*blowup_scale_c*tile_thick;
  #declare darkenfactor = 1.0;
  #local ylift = 0; #local ylift2 = 0; #local ylift3 = 0; #local ylift4 = 0;
  #local mytransmit = 0;
  #local fasemod = fase - ciclo*deltafase;
  #if (fasemod = 1)
    #declare Seed=seed(123);
    #local zrot = 0; //    #local ylift2 = 0; #local ylift3 = 0;
    #if (ciclo = 0 & minterp > 0) #local ylift = 200*minterp; #end
    #if (ciclo > 0 & minterp > 0) #local zrot = 180*minterp; #local ylift = (1-minterp)*tile_thick*blowup_scale_c; #end
    #if (ciclo > 0 & minterp > 0.5) #declare gtrans0 = transform {scale <1,-1,1> translate tile_thick*y gtrans0}; #end
//    SPrec_infl (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] gtrans0 scale blowup_scale_c rotate zrot*z translate ylift*y}, depth-ciclo)
    SPrec_infl (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] scale blowup_scale_c rotate zrot*z gtrans0 translate ylift*y}, depth-ciclo)
  #end
  #if (fasemod = 2)
    #declare Seed=seed(123);
    SPrec_infl (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] gtrans0 scale blowup_scale_c}, depth-ciclo)

    #declare Seed=seed(123);
//#debug concat ("minterp = ", str(minterp,0,-1), "\n")
    #local ylift = updown(minterp).y + 2*(1-1.5*minterp)*tile_thick;
    SPrec_infl2 (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] gtrans0 scale blowup_scale_c translate blowup_scale_c*ylift*y},
        depth-ciclo, 1, fasemod)
  #end
  #if (fasemod = 3)
    #declare Seed=seed(123);
    SPrec_infl (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] gtrans0 scale blowup_scale_c}, depth-ciclo)

    #declare Seed=seed(123);
    #local falsemysticdown = blowup_scale_c*updown(minterp).y - 3*blowup_scale_c*(1-minterp)*tile_thick;
    SPrec_infl2 (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] gtrans0 scale blowup_scale_c translate 2*tile_thick*blowup_scale_c*y},
        depth-ciclo, 1, fasemod)
  #end
  #if (fasemod = 4)
    #declare Seed=seed(123);
    SPrec_infl (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] gtrans0 scale blowup_scale_c}, depth-ciclo)

    #declare Seed=seed(123);
    #local ylift2 = updown(minterp).y - 3*minterp*tile_thick;
    SPrec_infl2 (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] gtrans0 scale blowup_scale_c translate 2*tile_thick*blowup_scale_c*y},
        depth-ciclo, 1, fasemod)
  #end
  #if (fasemod = 5)
    #declare Seed=seed(123);
    #local ylift3 = updown(minterp).y - 3*minterp*tile_thick;
    SPrec_infl2 (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] gtrans0 scale blowup_scale_c translate 2*tile_thick*blowup_scale_c*y},
        depth-ciclo, 1, fasemod)
  #end
  #if (fasemod = 6)
    #declare Seed=seed(123);
    #declare darkenfactor = (1-minterp)*0.3 + minterp;
    SPrec_infl2 (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] gtrans0 scale blowup_scale_c translate 2*tile_thick*blowup_scale_c*y},
        depth-ciclo, 1, fasemod)

    #local ylift4 = 2*updown(minterp).y - 5*minterp*tile_thick;
    #declare Seed=seed(123);
    SPrec_sparse (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] gtrans0 scale blowup_scale_c translate 4*tile_thick*blowup_scale_c*y}, depth-ciclo-1)
  #end
  #if (fasemod = 7)
    #if (minterp > 0)
//#debug concat("minterp: ", str(minterp,0,-1), "\n")
      #declare Seed=seed(123);
      #declare darkenfactor = 0.3;
      #declare mytransmit = 1-minterp;
      SPrec_infl2 (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] gtrans0 scale blowup_scale_c translate 2*tile_thick*blowup_scale_c*y},
          depth-ciclo, 1, fasemod)
    #end

    #declare Seed=seed(123);
    SPrec_sparse (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] gtrans0 scale blowup_scale_c translate 4*tile_thick*blowup_scale_c*y}, depth-ciclo-1)
  #end
  #if (fasemod = 8)
    #declare Seed=seed(123);
    #if (minterp <= 0) 
      SPrec_infl (htilex[depth], transform {ttransinv[ciclo+1][depth-ciclo-1] scale <-1,1,1>
          scale blowup_scale_c*blow_up_scale gtrans0 translate 4*tile_thick*blowup_scale_c*y}, depth-ciclo-1)
    #else
      #declare minterpm = 1 - minterp;
      #declare minterps = 1 - minterp;
      #local ttransoffset = vtransform (<0,0,0>, transform {ttransinv[ciclo+1][depth-ciclo-1] scale <-1,1,1>})
                          - vtransform (<0,0,0>, transform {ttransinv[ciclo][depth-ciclo] scale <+1,1,1>});
      SPrec_motion (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] translate minterpm*ttransoffset Str[0][0]
          scale blowup_scale_c scale <-1,1,1>
          scale (1 - minterps + minterps*blow_up_scale) gtrans0 translate 4*tile_thick*blowup_scale_c*y}, depth-ciclo-1)

    #end
  #end
  #local blowup_scale_c = blowup_scale_c*blow_up_scale;
  #local ciclo = ciclo + 1;
#end

#declare textfont = "LiberationMono-Regular.ttf"

/*
cylinder {
  <0,0,0>
  <0,1,0>
  0.3
  texture {pigment {Black}}
}
 */

background {Gray}

#declare skycam = z;
#declare camerapos = 30*mag*y;
//#declare camerapos = 600*y;
#declare lookatpos = <0,0,0>;

camera {
  #ifdef (AspectWide)
    angle 20*4/3
    right 16/9*x
  #else
    angle 20
  #end
  #ifdef (animate)
    location camerapos - 20*mag*z
    look_at lookatpos
  #else
    location camerapos
    look_at lookatpos
    sky skycam
  #end
}

light_source { 100*<20, 20, -20> color White }
//light_source { 2*20*<1, 1, 1> color White }

#ifdef (annotate)
  #local ciclo = int(fase / deltafase);
  #local fasemod = fase - ciclo*deltafase;
  text {
    ttf textfont concat (
        "Fase: ", str(fase,1,0),
        " = ", str(ciclo,1,0),
        "*", str(deltafase,1,0),
        " + ", str(fasemod,1,0) ) 0.4, 0
    pigment { Black }
    rotate 90*x
    scale 5
    translate -25*x + 10*y
    no_shadow
  }

  text {ttf textfont concat ("Tempo: ", str(time,0,2), "/", str(t25,0,2) ) 0.4, 0
    pigment { Black }
    rotate 90*x
    scale 5
    translate -25*x + 10*y - 5*z
    no_shadow
  }
#end
