/*
 * animazione con clock tra 0 e 2
 * esempio di comando di compilazione, risoluzione 640x480 con antialiasing,
 * costruzione di 1000 fotogrammi con clock che varia tra 0 e 2:
 *
 *   povray subdivision.pov +w640 +h480 +a +ki0 +kf2 +kfi0 +kff1000
 *
 * e' possibile selezionare la lingua (default: italiano) tramite
 * la dichiarazione "Lang=n" (n=1: italiano, n=2: inglese) ad esempio:
 *   povray ... Declare=Lang=2
 */
/*
#finalclock 2
#numseconds 40
#durata 45
#coda 5
#titolo 5
 */

#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "subdivision.inc"
#include "ambiente.inc"

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
#declare pradius=Phi*Phi;

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

#declare camerapos=3*pradius*<0, 14, 1>;
#declare lookatpos=pradius*<0, 0, 1>;
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
light_source { 10*pradius*<-1, 1, 1> color White }

#declare h7pos=<-7,0,-1.3>;
#declare h8pos=<12,0,-1.3>;

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
 * ci sono per cinque semitasselli che formano
 * un mezzo kite (rkite) e un mezzo rdart
 * altri cinque per ricoprire le meta' di sinistra
 */

#declare numtiles = 13;
#declare stiles = 
  array[numtiles] {h7m,h8m,h8m,h8m,h8m,h8m,
                   h7m,h8m,h8m,h8m,h8m,h8m,h8m}
#declare h7sp = <-10,paperthick,12>;
#declare h8sp = <2,paperthick,12>;
//#declare ksp = <2.91,paperthick,2.20>;
//#declare dsp = <-0.16,paperthick,2.20>;
#declare startpos =
  array[numtiles] {h7sp+1*tile_thick*y+0.06*x,  // H7 che ricopre H7
                   h8sp+10*tile_thick*y-0.26*x,// H8 che ricopre H7
                   h8sp+9*tile_thick*y-0.16*x, // H8 che ricopre H7
                   h8sp+8*tile_thick*y,        // H8 che ricopre H7
                   h8sp+7*tile_thick*y+0.09*x, // H8 che ricopre H7
                   h8sp+6*tile_thick*y+0.14*x, // H8 che ricopre H7

                   h7sp+0*tile_thick*y-0.31*x, // H7 che ricopre H8
                   h8sp+5*tile_thick*y-0.05*x, // H8 che ricopre H8
                   h8sp+4*tile_thick*y+0.05*x, // H8 che ricopre H8
                   h8sp+3*tile_thick*y+0.01*x, // H8 che ricopre H8
                   h8sp+2*tile_thick*y+0.11*x, // H8 che ricopre H8
                   h8sp+1*tile_thick*y-0.11*x, // H8 che ricopre H8
                   h8sp+0.11*x}                // H8 che ricopre H8

#declare startangle = 
  array[numtiles] {20,13,21,22,12,15, 24,18,9,4,18,21,20}
#declare endpos = 
  array[numtiles] {trn0[0]+h7pos,trn1[0]+h7pos,trn2[0]+h7pos,trn3[0]+h7pos,trn4[0]+h7pos,trn5[0]+h7pos,
                   trn0[0]+h8pos,trn1[0]+h8pos,trn2[0]+h8pos,trn3[0]+h8pos,trn4[0]+h8pos,trn5[0]+h8pos,trn6[0]+h8pos}
#declare endangle = 
  array[numtiles] {rot0,rot1,rot2,rot3,rot4,rot5,
                   rot0,rot1,rot2,rot3,rot4,rot5,rot6}
#declare starttime = 
  array[numtiles] {0.1,0.3,0.4,0.5,0.6,0.7,
                   1.1,1.2,1.3,1.4,1.5,1.6,1.7}
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
  #declare ltime = (clock - starttime[tileid])/traveltime;
  #if (ltime < 0) #declare ltime = 0; #end
  #if (ltime > 1) #declare ltime = 1; #end
  #declare lltime = (ltime - lifttime)/(1 - 2*lifttime);
  #if (lltime < 0) #declare lltime = 0; #end
  #if (lltime > 1) #declare lltime = 1; #end
  #declare ang = lltime*endangle[tileid] + (1-lltime)*startangle[tileid];
  calcpos (ltime, startpos[tileid], endpos[tileid] + pradius*tile_thick*y)
  object {
    stiles[tileid]
    rotate ang*y
    translate tpos
  }
  #declare tileid = tileid + 1;
#end

#ifdef (debug)
  sphere {
    endpos[0] + pradius*tile_thick*y
    0.3
    pigment {color Blue}
  }
#end

#declare seet_h7 = color rgbt <1, 0.5, 0.5, 0.7>;
#declare seet_h8 = color rgbt <0.5, 1, 0.5, 0.7>;

union {
  h7list (seet_h7, seet_h7, seet_h7)
  scale pradius
  translate h7pos
}

#ifdef (debug)
  sphere {
    <0,0,0>
    0.2
    pigment {color Black}
    scale pradius
    translate h7pos
  }
#end

union {
  h8list (seet_h8, seet_h8, seet_h8)
  scale pradius
  translate h8pos
}

