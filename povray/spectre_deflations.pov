/*
 * animazione con clock tra 0 e 2
 *
 * valori superiori di clock provocano l'aumento di depth:
 *   depth = int (clock/2)
 *   clock = clock - 2*depth
 *
 * la massima profondita' sopportata e' depth = 4, corrispondente
 * ad un clock tra 0 e 10
 *
 * esempio di comando di compilazione, risoluzione 640x480 con antialiasing,
 * costruzione di 500 fotogrammi con clock che varia tra 0 e 2:
 *
 *   povray subdivision.pov +w640 +h480 +a +ki0 +kf2 +kfi0 +kff500
 *
 * [solo inglese!]
 * e' possibile selezionare la lingua (default: italiano) tramite
 * la dichiarazione "Lang=n" (n=1: italiano, n=2: inglese) ad esempio:
 *   povray ... Declare=Lang=2
 */
/*
#finalclock 11
#numseconds 110
#durata 115
#coda 5
#titolo 5
 */

#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "spectresubdivision.inc"
#include "ambiente.inc"

#declare subtime = 2;

#declare preambletime = 0;
#declare rclock = clock - preambletime;

//#if (final_clock > 0)
//  #declare final_depth = int ((final_clock - 0.001 - preambletime)/subtime);
//#else
  #declare final_depth = 4;
//#end
#declare rclockend = subtime*(final_depth+1);
#declare zoomclock = rclock - rclockend;

#ifndef (depth)
  #declare depth = int (rclock/subtime);
  #declare subclock = rclock - subtime*depth;
  #if (depth > 0 & subclock = 0) /* semicontinuita' temporale dal passato */
    #declare depth = depth - 1;
    #declare subclock = subclock + subtime;
  #end
  #if (depth > final_depth)
    #declare depth = final_depth;
    #declare subclock = subtime;
  #end
#else
  #declare subclock = rclock;
#end

#debug concat ("final clock: ", str(final_clock, 0, -1), "\n")
#debug concat ("final depth: ", str(final_depth, 0, -1), "\n")

#declare LangIT=1;
#declare LangEN=2;
#declare LangFUR=3;
#declare LangFR=4;
#declare LangBRE=5;
#declare LangDE=6;
#declare LangRU=7;

#ifndef (Lang)
  #declare Lang=LangEN;
#end

#ifdef (debug)
  #declare withscritta = 1;
#end

#declare paperthick=0.005;
//#if (Lang = LangRU)
//  #declare tfont="arial.ttf";
#declare tfont="LiberationMono-Regular.ttf";
//#else
//  #declare tfont="VeraMono.ttf";
//#end

global_settings { charset utf8 }
object { tavolo2 }

/*
 * foglio di carta
 */

#ifdef (withscritta)
  box {
    //<-19,0,8>
    <-19,0,13>
    //<19,paperthick,17>
    <19,paperthick,16>
    pigment{White}
    finish {tile_Finish}
  }
#end

#declare scrittah = 14.0;
#declare scrittal = -18;
#declare scrittar = 18;

/*
 * scritta7[d] e' la scritta che compare nella suddivisione di spectre a livello d
 * scritta8[d] analogamente per la suddivisione di mystic
 */
#declare scritta7 = array[6]
#declare scritta8 = array[6]
#switch (Lang)

  #case (LangEN)
  #declare scritta7[0] = "8 or 7 tiles cover an enlarged version of themselves"
  // #declare scritta8[0] = "UNDEFINED"
  #declare scritta7[1] = "Repeat using the new supertiles spectre and mystic"
  #declare scritta7[2] = "Repeat again to get the level-3 supertiles"
  #declare scritta7[4] = "The tiled region is increasingly large"
  #break

#end

//#declare k = -0.1;
#declare magstep = sqrt(4+sqrt(15));
#declare mag = pow (magstep, depth);

#declare clipwindow = 
box {
  <scrittal, paperthick-0.01, scrittah-1.0>
  <scrittar, paperthick+0.5, scrittah+3>
}

#declare scritta7obj = array[6];
#declare scritta8obj = array[6];

#declare i = 0;
#while (i < 6)
  #ifdef (scritta7[i])
    #declare scritta7obj[i] = 
      text {ttf tfont scritta7[i] 0.02, 0
      //text {ttf "cyrvetic.ttf" scritta7 0.02, 0
      finish {tile_Finish}
      translate -0.06*z
      scale 2
      rotate 90*x
      translate <scrittal, paperthick, scrittah>
    }
  #end

  #ifdef (scritta8[i])
    #declare scritta8obj[i] = 
      text {ttf tfont scritta8[i] 0.02, 0
      finish {tile_Finish}
      translate -0.06*z
      scale 2
      rotate 90*x
      translate <scrittal, paperthick, scrittah>
    }
  #end
  #declare i = i + 1;
#end

#declare scrittavel = 50;
#declare scritta7tr = (scrittar - scrittal - subclock*scrittavel)*x;
#declare scritta8tr = (scrittar - scrittal - (subclock-1)*scrittavel)*x;

#ifdef (withscritta)
  #ifdef (scritta7obj[depth])
    object {scritta7obj[depth]
      translate scritta7tr
      bounded_by {clipwindow}
      clipped_by {bounded_by}
    }
  #end

  #ifdef (scritta8obj[depth])
    object {scritta8obj[depth]
      translate scritta8tr
      bounded_by {clipwindow}
      clipped_by {bounded_by}
    }
  #end
#end

background{Black}

#declare spectrepos=<-10,0,-5.3>;
#declare mysticpos=<13,0,-6.3>;

#declare camerapos=3*magstep*<0, 14, 1>;
#declare lookatpos=magstep*<0, 0, 1>;
#if (zoomclock > 0)
  #if (zoomclock > 0.5) #declare zoomclock = 0.5; #end
  #declare zoomtarget = h8pos + 0.1*(h7pos - h8pos);
  #declare zoomfactor = exp(-5*zoomclock);
  #declare camerapos = zoomfactor*camerapos + (1 - zoomfactor)*zoomtarget;
  #declare lookatpos = zoomfactor*lookatpos + (1 - zoomfactor)*zoomtarget;
#end
#declare eyeshift=0*x;
#declare eyedist=0.5;
#declare eyedir=vnormalize(vcross(lookatpos-camerapos,-y));
#declare skycam=z;

#ifdef (lefteye)
  #declare eyeshift=-eyedist*eyedir;
  #declare skycam = vnormalize (vcross (lookatpos-camerapos,eyedir));
#end
#ifdef (righteye)
  #declare eyeshift=eyedist*eyedir;
  #declare skycam = vnormalize (vcross (lookatpos-camerapos,eyedir));
#end

camera {
  #ifdef (AspectWide)
    angle 20*4/3
    right 16/9*x
  #else
    angle 20
  #end
  location camerapos + eyeshift
  look_at lookatpos
  sky skycam
}

light_source { 5*<20, 20, -20> color 0.5*White }
light_source { 10*magstep*<-1, 1, 1> color White }

/* percorso di riferimento che connette <0,0,0> a <1,1,1> */

#declare refpath = spline {
  cubic_spline
  -0.25 <0,-0.3,0>
  0.0, <0,0,0>
  0.2, <0.2,0.3,0.2>
  0.8, <0.8,0.3,0.8>
  1.0, <1,0,1>
  1.25, <1,-0.3,1>
}

#declare localize = spline {
  linear_spline
  0.0, 0*x
  0.3, 0*x
  0.7, 1*x
  1.0, 1*x
}

#if (depth <= 0)
  #declare mysp = SPobj[1];
  #declare mymy = SPobj[0];
#else
  #declare mysp = 
    union {SPrec (1, transform{scale <1/mag, 1, 1/mag>}, depth)}
  #declare mymy =
    union {SPrec (0, transform{scale <1/mag, 1, 1/mag>}, depth)}
#end

#declare numtiles = 15;
#declare stiles = 
  array[numtiles] {mymy, mysp, mysp, mysp, mysp, mysp, mysp, mysp, 
                   mymy, mysp, mysp, mysp, mysp, mysp, mysp}
#declare spectresp = <-10,paperthick,12>;
#declare mysticsp = <11,paperthick,12>;
#declare startpos =
  array[numtiles] {mysticsp+1*tile_thick*y+0.06*x,  // mystic che ricopre spectre
                   spectresp+12*tile_thick*y+3.30*x,// spectre che ricopre spectre
                   spectresp+11*tile_thick*y+2.9*x,  // spectre che ricopre spectre
                   spectresp+10*tile_thick*y+2.5*x,  // spectre che ricopre spectre
                   spectresp+9*tile_thick*y+1.99*x, // spectre che ricopre spectre
                   spectresp+8*tile_thick*y+1.40*x, // spectre che ricopre spectre
                   spectresp+7*tile_thick*y+1.05*x, // spectre che ricopre spectre
                   spectresp+6*tile_thick*y+0.75*x, // spectre che ricopre spectre

                   mysticsp+0*tile_thick*y-0.31*x, // mystic che mystic
                   spectresp+5*tile_thick*y+0.70*x, // spectre che ricopre mystic
                   spectresp+4*tile_thick*y-0.01*x, // spectre che ricopre mystic
                   spectresp+3*tile_thick*y-0.50*x, // spectre che ricopre mystic
                   spectresp+2*tile_thick*y-1.05*x, // spectre che ricopre mystic
                   spectresp+1*tile_thick*y-2.00*x, // spectre che ricopre mystic
                   spectresp+0*tile_thick*y-1.55*x} // spectre che ricopre mystic

#declare startangle = 
  array[numtiles] {20,13,21,22,12,15,10,18, 24,18,9,4,18,21,20}

#declare trni = array[8];
#declare rot = array[8];

#local i = 0;
#while (i < 8)
  #local trni[i] = 1/mag*vtransform (<0,0,0>, Str[i][depth]);
  #local mapz = 1/mag*vtransform (z, Str[i][depth]) - trni[i];
  #declare rot[i] = degrees (atan2(mapz.x, mapz.z));
  #local i = i + 1;
#end

#declare endpos = 
  array[numtiles] {trni[0]+spectrepos,trni[1]+spectrepos,trni[2]+spectrepos,trni[3]+spectrepos,trni[4]+spectrepos,
                                      trni[5]+spectrepos, trni[6]+spectrepos, trni[7]+spectrepos,
                   trni[0]+mysticpos,trni[1]+mysticpos,trni[2]+mysticpos,trni[4]+mysticpos,trni[5]+mysticpos,
                                      trni[6]+mysticpos,trni[7]+mysticpos}
#declare endangle = 
  array[numtiles] {rot[0],rot[1],rot[2],rot[3],rot[4],rot[5],rot[6],rot[7],
                   rot[0],rot[1],rot[2],rot[4],rot[5],rot[6],rot[7]}
#declare starttime = 
  array[numtiles] {0.1,0.3,0.35,0.4,0.5,0.55,0.6,0.7,
                   1.1,1.16,1.3,1.4,1.5,1.7,1.6}

#declare liftstart = subclock/0.05;
#if (liftstart >= 1) #declare liftstart = 1; #end
#declare pushdownstart = (1 - liftstart)*12.01;
#if (depth = 0) #declare pushdownstart = 0; #end

#declare liftend = (subtime - subclock)/0.05;
#if (liftend >= 1) #declare liftend = 1; #end
#declare pushdownend = (1 - liftend)*magstep*1.01;
#if (depth >= final_depth) #declare pushdownend = 0; #end

#declare traveltime = 0.2;
#declare lifttime = 0.15;
#declare liftamount = 0.3;

#macro calcpos(ltime,spos,epos)
  #switch (ltime)
    #range (-0.1,lifttime)
      #declare lltime=0;
      #declare lliftamount=(ltime/lifttime)*liftamount*y;
    #break
    #range (lifttime,1-lifttime)
      #declare lltime=(ltime - lifttime)/(1-2*lifttime);
      #declare lliftamount=liftamount*y;
    #break
    #range (1-lifttime,1.1)
      #declare lltime=1;
      #declare lliftamount=((1-ltime)/lifttime)*liftamount*y;
    #break
  #end
  #declare relpos = refpath (lltime);  // quota zero agli estremi
  #declare relposy = relpos.y;
  #declare sposy = spos.y;
  #declare eposy = epos.y;
  #declare sposxz = spos - sposy*y;
  #declare eposxz = epos - eposy*y;
  #declare tpos = relpos*eposxz + (<1,1,1>-relpos)*sposxz;
  #declare tpos = tpos + relposy*y + (lltime*eposy + (1-lltime)*sposy)*y;
  #declare tpos = tpos + lliftamount;
#end

#declare tileid = 0;
#while (tileid < numtiles)
  #declare ltime = (subclock - starttime[tileid])/traveltime;
  #if (ltime < 0) #declare ltime = 0; #end
  #if (ltime > 1) #declare ltime = 1; #end
  #declare lltime = (ltime - lifttime)/(1 - 2*lifttime);
  #if (lltime < 0) #declare lltime = 0; #end
  #if (lltime > 1) #declare lltime = 1; #end
  #declare ang = lltime*endangle[tileid] + (1-lltime)*startangle[tileid];
  calcpos (ltime, startpos[tileid], endpos[tileid] + magstep*tile_thick*y)
  object {
    stiles[tileid]
    #if (lltime > 0.5)
      translate -0.5*lltime*tile_thick*y
      scale <1, -1, 1>
      translate 0.5*lltime*tile_thick*y
    #end
    translate -lltime*tile_thick*y
    rotate localize(lltime).x*180*z
    rotate ang*y
    translate tpos
    translate -pushdownstart*tile_thick*y
    translate -pushdownend*tile_thick*y
  }
  #declare tileid = tileid + 1;
#end

#ifdef (debug)
  sphere {
    endpos[0] + magstep*tile_thick*y
    0.3
    pigment {color Blue}
  }
#end

#declare seet_spectre = color rgbt <1, 0.5, 0.5, 0.7>;
#declare seet_mystic = color rgbt <0.5, 1, 0.5, 0.7>;

#declare seet = seet_spectre;

#if (depth <= 0)
  object {spectre
    scale magstep*<1, mag, 1>
    translate spectrepos
    translate -pushdownend*tile_thick*y
    texture {pigment {seet}}
  }
  //union {
  //  h7list (seet_h7, seet_h7, seet_h7)
  //  scale magstep*<1, mag, 1>
  //  translate h7pos
  //  translate -pushdownend*tile_thick*y
  //}
#else
  SPrec (1, transform {scale magstep/mag translate spectrepos - pushdownend*tile_thick*y}, depth)
#end

#declare seet = seet_mystic;

#if (depth <= 0)
  object {mystic
    scale magstep*<1, mag, 1>
    translate mysticpos
    translate -pushdownend*tile_thick*y
    texture {pigment {seet}}
  }
  //union {
  //  h8list (seet_h8, seet_h8, seet_h8)
  //  scale magstep*<1, mag, 1>
  //  translate h8pos
  //  translate -pushdownend*tile_thick*y
  //}
#else
  SPrec (0, transform {scale magstep/mag translate mysticpos - pushdownend*tile_thick*y}, depth)
#end

#declare textfont = "LiberationMono-Regular.ttf"
#declare spectretext = text {ttf textfont "spectre" 0.02, 0
  rotate 90*x
  translate 0.02*y
}
#declare mystictext = text {ttf textfont "mystic" 0.02, 0
  rotate 90*x
  translate 0.02*y
}

object {spectretext
  scale 4
  translate spectresp + <-5,0,-5>
#ifdef (withscritta)
  translate paperthick*y
#end
  pigment {color Black}
}

object {mystictext
  scale 4
  translate mysticsp + <-6,0,-5>
#ifdef (withscritta)
  translate paperthick*y
#end
  pigment {color Black}
}

#ifdef (debug)
  sphere {
    <0,0,0>
    0.2
    pigment {color Black}
    scale magstep
    translate spectrepos
  }
#end

