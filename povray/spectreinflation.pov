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

#ifndef (Sigl) #declare Sigl = 404040; #end
#ifndef (Sigh) #declare Sigh = 404040; #end
//#ifndef (Sigl2) #declare Sigl2 = 040404; #end
//#ifndef (Sigh2) #declare Sigh2 = 040404; #end
#ifndef (depth) #declare depth = 5; #end
#ifndef (zoomout) #declare zoomout = 2; #end
#ifndef (minterp) #declare minterp = 1; #end

#ifndef (fase) #declare fase = 1; #end
#declare deltafase = 8;

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

#declare gtrans0 = transform {scale <1,1,1>}

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
          texture {pigment {rgb darkenfactor*rndpigment}} finish {tile_Finish}
          finish {tile_Finish}
          transform {trsf}
        }
      #end
    #end
    #if (fase >= 5 & tid = 3 & ptid != 0)
        object { tile11
          texture {pigment {rgb 0.7*darkenfactor*rndpigment}} finish {tile_Finish}
          finish {tile_Finish}
          transform {trsf}
        }
    #end
    #if (tid = 0)
      //brighten (0.2)
      object { tile11
        transform {mystic_tr}
        //texture {T_mystic finish {tile_Finish} }
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
        //transform {Str[tid][d+1] trsf}
      }
    #end
    object {spectre
      rndcol (Seed)
      texture {pigment {rgb rndpigment}} finish {tile_Finish}
      transform {scale scale_it translate move_it trsf}
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
  #if (fase - ciclo*deltafase >= 1 & fase - ciclo*deltafase <= 4)
    #declare Seed=seed(123);
    SPrec_infl (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] gtrans0 scale blowup_scale_c}, depth-ciclo)
  #end
  #if (fase - ciclo*deltafase >= 2 & fase - ciclo*deltafase <= 6)
    #declare Seed=seed(123);
    #declare darkenfactor = 1.0;
    #if (fase - ciclo*deltafase >= 6) #declare darkenfactor = 0.3; #end
    SPrec_infl2 (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] gtrans0 scale blowup_scale_c translate 2*tile_thick*y},
        depth-ciclo, 1, fase - ciclo*deltafase)
  #end
  #if (fase - ciclo*deltafase >= 6 & fase - ciclo*deltafase <= 7)
    #declare Seed=seed(123);
    SPrec_sparse (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] gtrans0 scale blowup_scale_c translate 4*tile_thick*y}, depth-ciclo-1)
  #end
  #if (fase - ciclo*deltafase = 8)
    #declare Seed=seed(123);
    #if (minterp = 1) 
      SPrec_infl (htilex[depth], transform {ttransinv[ciclo+1][depth-ciclo-1] gtrans0 scale <-1,1,1>
          scale blowup_scale_c*blow_up_scale translate 4*tile_thick*y}, depth-ciclo-1)
    #else
      #declare minterpm = minterp;
      #declare minterps = minterp;
      #local ttransoffset = vtransform (<0,0,0>, transform {ttransinv[ciclo+1][depth-ciclo-1] scale <-1,1,1>})
                          - vtransform (<0,0,0>, transform {ttransinv[ciclo][depth-ciclo] scale <+1,1,1>});
      SPrec_motion (htilex[depth], transform {ttransinv[ciclo][depth-ciclo] translate minterpm*ttransoffset Str[0][0]
          scale blowup_scale_c gtrans0 scale <-1,1,1>
          scale (1 - minterps + minterps*blow_up_scale) translate 4*tile_thick*y}, depth-ciclo-1)

    #end
  #end
  #local blowup_scale_c = blowup_scale_c*blow_up_scale;
  #local ciclo = ciclo + 1;
#end

//#declare textfont = "LiberationMono-Regular.ttf"

/*
cylinder {
  <0,0,0>
  <0,1,0>
  0.3
  texture {pigment {Black}}
}
 */

background {White}

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
  location camerapos
  look_at lookatpos
  sky skycam
}

light_source { 100*<20, 20, -20> color White }
//light_source { 2*20*<1, 1, 1> color White }
  
#ifdef (sfondobianco) 
  background {White}
#end
