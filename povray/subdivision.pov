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
 * [legacy: la scritta NON e' al momento supportata; eredita' del
 *          sorgente rubato da "penrose"]
 * e' possibile selezionare la lingua (default: italiano) tramite
 * la dichiarazione "Lang=n" (n=1: italiano, n=2: inglese) ad esempio:
 *   povray ... Declare=Lang=2
 */
/*
#finalclock 12
#numseconds 100
#durata 105
#coda 5
#titolo 5
 */

#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "subdivision.inc"
#include "ambiente.inc"

#declare subtime = 2;

#ifndef (depth)
  #declare depth = int (clock/subtime);
  #declare subclock = clock - subtime*depth;
  #if (depth > 0 & subclock = 0) /* semicontinuita' temporale dal passato */
    #declare depth = depth - 1;
    #declare subclock = subclock + subtime;
  #end
#else
  #declare subclock = clock;
#end

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

/*
 * sfortunatamente pare che VeraMono.ttf manchi del cirillico
 */

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
    <-2,0,8>
    <18,paperthick,17>
    pigment{White}
    finish {tile_Finish}
  }
#end

#declare scrittah = 14.0;
#declare scrittal = 0;
#declare scrittar = 18;

#switch (Lang)

  #case (LangEN)
  #declare rscritta = "6 or 7 clusters cover an enlarged "
  #declare lscritta = "version of H7 and H8"
  #break

#end

//#declare k = -0.1;
#declare magstep = Phi*Phi;
#declare mag = pow (magstep, depth);
//#declare pradius=magstep;

#declare clipwindow = 
box {
  <scrittal, paperthick-0.01, scrittah-0.1>
  <scrittar, paperthick+0.5, 4.8>
}

#declare rscrittaobj = 
  text {ttf tfont rscritta 0.02, 0
  //text {ttf "cyrvetic.ttf" rscritta 0.02, 0
  finish {tile_Finish}
  translate -0.06*z
  scale 2
  rotate 90*x
  translate <scrittal, paperthick, scrittah>
}

#declare lscrittaobj = 
  text {ttf tfont lscritta 0.02, 0
  finish {tile_Finish}
  translate -0.06*z
  scale 2
  rotate 90*x
  translate <scrittal, paperthick, scrittah>
}

#declare scrittavel = 20;
#declare rscrittatr = (scrittar - scrittal - clock*scrittavel)*x;
#declare lscrittatr = (scrittar - scrittal - (clock-1)*scrittavel)*x;

#ifdef (withscritta)
  object {rscrittaobj
    translate rscrittatr
    //bounded_by {clipwindow}
    //clipped_by {bounded_by}
  }

  object {lscrittaobj
    translate lscrittatr
    //bounded_by {clipwindow}
    //clipped_by {bounded_by}
  }
#end

background{Black}

#declare camerapos=3*magstep*<0, 14, 1>;
#declare lookatpos=magstep*<0, 0, 1>;
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

#declare h7pos=<-7,0,-1.3>;
#declare h8pos=<13,0,-1.3>;

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

/*
 */

#if (depth <= 0)
  #declare h7 = h7m;
  #declare h8 = h8m;
#else
  #declare h7 = 
    union {h7rec (transform{scale <1/mag, 1, 1/mag>}, depth)}
  #declare h8 =
    union {h8rec (transform{scale <1/mag, 1, 1/mag>}, depth)}
#end

#declare numtiles = 13;
#declare stiles = 
//  array[numtiles] {h7m,h8m,h8m,h8m,h8m,h8m,
//                   h7m,h8m,h8m,h8m,h8m,h8m,h8m}
  array[numtiles] {h7,h8,h8,h8,h8,h8,
                   h7,h8,h8,h8,h8,h8,h8}
#declare h7sp = <-10,paperthick,12>;
#declare h8sp = <11,paperthick,12>;
//#declare ksp = <2.91,paperthick,2.20>;
//#declare dsp = <-0.16,paperthick,2.20>;
#declare startpos =
  array[numtiles] {h7sp+1*tile_thick*y+0.06*x,  // H7 che ricopre H7
                   h8sp+10*tile_thick*y+3.30*x,// H8 che ricopre H7
                   h8sp+9*tile_thick*y+2.9*x,  // H8 che ricopre H7
                   h8sp+8*tile_thick*y+2.5*x,  // H8 che ricopre H7
                   h8sp+7*tile_thick*y+1.99*x, // H8 che ricopre H7
                   h8sp+6*tile_thick*y+1.40*x, // H8 che ricopre H7

                   h7sp+0*tile_thick*y-0.31*x, // H7 che ricopre H8
                   h8sp+5*tile_thick*y+0.70*x, // H8 che ricopre H8
                   h8sp+4*tile_thick*y-0.01*x, // H8 che ricopre H8
                   h8sp+3*tile_thick*y-0.50*x, // H8 che ricopre H8
                   h8sp+2*tile_thick*y-1.05*x, // H8 che ricopre H8
                   // h8sp+0*tile_thick*y-0.41*x, // H8 che ricopre H8
                   h8sp+0*tile_thick*y-2.00*x, // H8 che ricopre H8
                   h8sp+1*tile_thick*y-1.55*x} // H8 che ricopre H8

#declare startangle = 
  array[numtiles] {20,13,21,22,12,15, 24,18,9,4,18,21,20}
#declare trni = array[7] {trn0[depth]/mag,trn1[depth]/mag,trn2[depth]/mag,trn3[depth]/mag,trn4[depth]/mag,trn5[depth]/mag,trn6[depth]/mag}
#declare endpos = 
  array[numtiles] {trni[0]+h7pos,trni[1]+h7pos,trni[2]+h7pos,trni[3]+h7pos,trni[4]+h7pos,trni[5]+h7pos,
                   trni[0]+h8pos,trni[1]+h8pos,trni[2]+h8pos,trni[3]+h8pos,trni[4]+h8pos,trni[5]+h8pos,trni[6]+h8pos}
#declare endangle = 
  array[numtiles] {rot0,rot1,rot2,rot3,rot4,rot5,
                   rot0,rot1,rot2,rot3,rot4,rot5,rot6}
#declare starttime = 
  array[numtiles] {0.1,0.3,0.4,0.5,0.6,0.7,
                   1.1,1.16,1.3,1.4,1.5,1.7,1.6}

#declare liftstart = subclock/0.05;
#if (liftstart >= 1) #declare liftstart = 1; #end
#declare pushdownstart = (1 - liftstart)*12.01;
#if (depth = 0) #declare pushdownstart = 0; #end

#declare liftend = (subtime - subclock)/0.05;
#if (liftend >= 1) #declare liftend = 1; #end
#declare pushdownend = (1 - liftend)*magstep*1.01;
#if (depth >= 4) #declare pushdownend = 0; #end

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

#declare seet_h7 = color rgbt <1, 0.5, 0.5, 0.7>;
#declare seet_h8 = color rgbt <0.5, 1, 0.5, 0.7>;

#declare seet = seet_h7;

#if (depth <= 0)
  union {
    h7list (seet_h7, seet_h7, seet_h7)
    scale magstep
    translate h7pos
    translate -pushdownend*tile_thick*y
  }
#else
  h7rec (transform {scale magstep/mag translate h7pos - pushdownend*tile_thick*y}, depth)
#end

#declare seet = seet_h8;

#if (depth <= 0)
  union {
    h8list (seet_h8, seet_h8, seet_h8)
    scale magstep
    translate h8pos
    translate -pushdownend*tile_thick*y
  }
#else
  h8rec (transform {scale magstep/mag translate h8pos - pushdownend*tile_thick*y}, depth)
#end

#declare textfont = "LiberationMono-Regular.ttf"
#declare sub = transform {scale 0.7 translate <0.6,-0.2,0>}
#declare h7text = union {
  text {ttf textfont "H" 0.02, 0}
  text {ttf textfont "7" 0.02, 0
    transform {sub}
  }
}
#declare h8text = union {
  text {ttf textfont "H" 0.02, 0}
  text {ttf textfont "8" 0.02, 0
    transform {sub}
  }
}

object {h7text
  rotate 90*x
  scale 4
  translate h7sp+<4,0,-3>
  pigment {color Black}
}

object {h8text
  rotate 90*x
  scale 4
  translate h8sp+<-10,0,-2>
  pigment {color Black}
}

#ifdef (debug)
  sphere {
    <0,0,0>
    0.2
    pigment {color Black}
    scale magstep
    translate h7pos
  }
#end

