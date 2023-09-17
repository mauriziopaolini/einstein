#version 3.7;

global_settings { assumed_gamma 1.0 }

#include "colors.inc"
#include "skies.inc"
#include "shapes.inc"
#include "spectresubdivision.inc"
#include "spectreworm.inc"
#include "ambiente.inc"

/*
#declare h7c1 = <1,1,1>;
#declare h7c2 = <1,0,0>;
#declare h7c3 = <1,0.4,0.4>;
#declare h8c1 = <1,1,1>;
#declare h8c2 = <1,0.4,0>;
#declare h8c3 = <1,0.4,0.4>;
 */

#ifndef (sub) #declare sub=1; #end

#switch (sub)
  #case (0)
    #ifndef (zoomout) #declare zoomout=0.5; #end
  #break

  #case (1)
    #ifndef (depth) #declare depth = 2; #end
  #break

  #case (2)
  #case (3)
    #ifndef (tipsig) #declare tipsig = 33333; #end
    #ifndef (tailsig) #declare tailsig = 00000; #end
    #ifndef (depth) #declare depth = 3; #end
    #ifndef (zoomout) #declare zoomout=2; #end
    worm_init (2000)
  #break
#end

#switch (sub)
  #case (2)
    #local irot1 = 0;
    #local irot2 = 1;
    #local irotw1 = 3;
    #local irotw2 = 4;
  #break

  #case (3)
    #local irot1 = 0;
    #local irot2 = 1;
    #local irotw1 = 4;
    #local irotw2 = 5;
  #break
#end

#ifndef (depth) #declare depth = 2; #end

#declare magstep = sqrt(4+sqrt(15));
#declare mag = pow (magstep, depth);

#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

#declare gtrans0 = transform {scale <-1,1,1> translate -4*x-3*z}

#declare ttransinv = array[depth+1];
#declare SPtilex = array[depth+1];

#macro build_up_down (upl, downl)
  #declare uptransf = transform {scale <1,1,1>}
  #declare downtransf = transform {scale <1,1,1>}
  #local dpth = 0;
  #while (upl != downl)
    #local uplhigh = int (upl/10);
    #local downlhigh = int (downl/10);
    #local upllow = upl - 10*uplhigh;
    #local downllow = downl - 10*downlhigh;
    #declare uptransf = transform {uptransf Str[upllow][dpth]}
    #declare downtransf = transform {downtransf Str[downllow][dpth]}
    #local upl = uplhigh;
    #local downl = downlhigh;
    #local dpth = dpth + 1;
  #end
#end

#macro build_ttransinv3 (depth)
 #local dpth = 0;
 #while (dpth <= depth)
  
  #declare tiletrans = transform {scale <1,1,1>};
  #local i = 0; 
  #while (i < dpth)
    #declare tiletrans = transform {Str[3][dpth-i-1] tiletrans}
    #local i = i + 1;
  #end
  
  #declare SPtilex[dpth] = 1;
  #declare ttransinv[dpth] = transform {tiletrans inverse}
  #local dpth = dpth + 1; 
 #end
#end

build_ttransinv3 (depth)

build_up_down (3, 2)
#declare uptransfinv = transform {uptransf inverse}
#declare placeit0 = transform {downtransf uptransfinv}
#declare placeit0inv = transform {placeit0 inverse}

build_up_down (10, 06)
#declare uptransfinv = transform {uptransf inverse}
#declare placeit1 = transform {downtransf uptransfinv}
#declare placecomb = transform {placeit1 placeit0inv}

#local placeiti = array[6]
#local placeiti[0] = transform {scale <1,1,1>}
#local i = 1;
#while (i < 6)
  #local placeiti[i] = transform {placeiti[i-1] placecomb}
  #local i = i + 1;
#end

#local darkenvalue = 0.8;


#macro drawworm (placeit, iswiggly)

  #declare wormi = 0;
  newwormtile (tipsig)
  #local sig = tipsig;
  #while (sig != tailsig & sig != 0) 
    #local sig = prec_in_worm (sig, iswiggly)
    #if (mod (sig,1000) = 0)
      #debug concat ("Milestone sig: ", str(sig,0,0), "\n")
    #end 
    newwormtile (sig)
  #end

  #declare wormlen = wormi;
  #local i = 0;
  #while (i < wormlen)
    object {
      #if (wormid[i] = 0)
        #if (iswiggly = 0) graymystic #else whitemystic #end
        #ifdef (rotworm)  // TODO  adjust for the case iswiggly=1
          #local rotsign = 0;
          #if (wormid[i-1] = 5) #local rotsign = 1; #end
          #if (wormid[i-1] = 2) #local rotsign = -1; #end
          SProtmystic (rotsign*rotworm/180*120)
        #end
      #else
        #if (iswiggly = 0) grayspectre #else whitespectre #end
        #ifdef (rotworm)
          SProtspectre (rotworm)
        #end
      #end
      transform wormtr[i]
      transform {ttransinv[depth] placeit gtrans0 translate lift}
    }
    #local i = i + 1;
  #end

#end

#switch (sub)
  #case (0)
    #local i = 0;
    #while (i < 6)
      SPbuildtiles ()
      object {SPobj[6]
        transform {placeiti[i] gtrans0}
      }
      //#local placeiti = transform {placeiti placecomb}
      SProtcolorshue (360*phi)
      #local i = i + 1;
    #end
  #break

  #case (1)
    #local i = 0;
    #while (i < 6)
      #local dpth = 1;
      #while (dpth <= depth)

        SPbuildtiles ()
        #local lift = 2*(depth-dpth)*tile_thick*y;
        #declare bdthick = 0.3*3/(dpth+2);
        SPrec (1, transform {ttransinv[dpth] placeiti[i] gtrans0 translate lift}, dpth)
        SPbspectre (transform {ttransinv[dpth] placeiti[i] gtrans0 translate lift}, dpth)

        SPdarkencolors (darkenvalue)
        #local dpth = dpth + 1;
      #end
      #local dpth = 1;
      #while (dpth <= depth)
        SPdarkencolors (1/darkenvalue)
        #local dpth = dpth + 1;
      #end
      //#local placeiti = transform {placeiti placecomb}
      SProtcolorshue (360*phi)
      #local i = i + 1;
    #end
  #break

  #case (2)
  #case (3)
    #local i = 0;
    #while (i < 6)

      SPbuildtiles ()
      #local lift = 0*tile_thick*y;
      #declare bdthick = 0.3*3/(depth+2);
      SPrec (1, transform {ttransinv[depth] placeiti[i] gtrans0 translate lift}, depth)
      SPbspectre (transform {ttransinv[depth] placeiti[i] gtrans0 translate lift}, depth)

      SPdarkencolors (darkenvalue)
      //#local placeiti = transform {placeiti placecomb}
      SProtcolorshue (360*phi)
      #local i = i + 1;
    #end

    SPbuildtiles ()
    //#local lift = lift + tile_thick*y;
    //SPwormrec (1, transform {ttransinv[depth] placeiti[0] gtrans0 translate lift}, depth)

    #local lift = lift + tile_thick*y;

    drawworm (placeiti[irot1], 0)
    drawworm (placeiti[irot2], 0)

    drawworm (placeiti[irotw1], 1)
    drawworm (placeiti[irotw2], 1)

  #break
#end

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
