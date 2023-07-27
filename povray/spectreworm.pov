/*
 *
 */

#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "spectresubdivision.inc"

#ifndef (depth) #declare depth = 2; #end
#ifndef (SPid) #declare SPid = 1; #end

#declare magstep = sqrt(4+sqrt(15));
#declare mag = pow (magstep, depth);

#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

#declare gtras = -300*x+250*z;

#ifdef (zoom) #declare zoomfactor = 1/zoom*zoomfactor; #end

#declare wormdim = 500;

#declare wormtr = array[wormdim]
#declare wormid = array[wormdim]

#declare depth = 5; // must coincide with the number of digits in signatures

#macro newwormtile (sig)
  #local sigtail = mod (sig, 10);
  #declare wormid[wormi] = sigtail;
  #declare wormtr[wormi] = transform {
  #local ii = 0;
  //#while (sig)
  #while (ii < depth)
    #local sigtail = mod (sig, 10);
    transform Str[sigtail][ii]
    #local sig = int (sig/10);
    #local ii = ii + 1;
  #end
  }
  #declare wormi = wormi + 1;
#end

#declare wormi = 0;

newwormtile (33333)
#declare basetr = wormtr[0];
#declare basetrinv = transform {basetr inverse}
newwormtile (33332)
newwormtile (33330)
newwormtile (33346)
newwormtile (33345)
newwormtile (33340)
newwormtile (33356)
newwormtile (33355)
newwormtile (33350)
newwormtile (33302)
newwormtile (33300)
newwormtile (33233)
newwormtile (33232)
newwormtile (33230)
newwormtile (33246)
newwormtile (33245)
newwormtile (33240)
newwormtile (33256)
newwormtile (33255)
newwormtile (33250)
newwormtile (33202)
newwormtile (33200)
newwormtile (33043)
newwormtile (33042)
newwormtile (33040)
newwormtile (33056)
newwormtile (33055)
newwormtile (33050)
newwormtile (33002)
newwormtile (33000)

newwormtile (34633)
newwormtile (34632)
newwormtile (34630)
newwormtile (34646)
newwormtile (34645)
newwormtile (34640)
newwormtile (34656)
newwormtile (34655)
newwormtile (34650)
newwormtile (34602)
newwormtile (34600)
newwormtile (34533)
newwormtile (34532)
newwormtile (34530)
newwormtile (34546)
newwormtile (34545)
newwormtile (34540)
newwormtile (34556)
newwormtile (34555)
newwormtile (34550)
newwormtile (34502)
newwormtile (34500)
newwormtile (34046)
newwormtile (34045)
newwormtile (34040)
newwormtile (34056)
newwormtile (34055)
newwormtile (34050)
newwormtile (34002)
newwormtile (34000)

newwormtile (35633)
newwormtile (35632)
newwormtile (35630)
newwormtile (35646)
newwormtile (35645)
newwormtile (35640)
newwormtile (35656)
newwormtile (35655)
newwormtile (35650)
newwormtile (35602)
newwormtile (35600)
newwormtile (35533)
newwormtile (35532)
newwormtile (35530)
newwormtile (35546)
newwormtile (35545)
newwormtile (35540)
newwormtile (35556)
newwormtile (35555)
newwormtile (35550)
newwormtile (35502)
newwormtile (35500)
newwormtile (35046)
newwormtile (35045)
newwormtile (35040)
newwormtile (35056)
newwormtile (35055)
newwormtile (35050)
newwormtile (35002)
newwormtile (35000)

newwormtile (30233)
newwormtile (30232)
newwormtile (30230)
newwormtile (30246)
newwormtile (30245)
newwormtile (30240)
newwormtile (30256)
newwormtile (30255)
newwormtile (30250)
newwormtile (30202)
newwormtile (30200)
newwormtile (30043)
newwormtile (30042)
newwormtile (30040)
newwormtile (30056)
newwormtile (30055)
newwormtile (30050)
newwormtile (30002)
newwormtile (30000)

newwormtile (23333)
newwormtile (23332)
newwormtile (23330)
newwormtile (23346)
newwormtile (23345)
newwormtile (23340)
newwormtile (23356)
newwormtile (23355)
newwormtile (23350)
newwormtile (23302)
newwormtile (23300)
newwormtile (23233)
newwormtile (23232)
newwormtile (23230)
newwormtile (23246)
newwormtile (23245)
newwormtile (23240)
newwormtile (23256)
newwormtile (23255)
newwormtile (23250)
newwormtile (23202)
newwormtile (23200)
newwormtile (23043)
newwormtile (23042)
newwormtile (23040)
newwormtile (23056)
newwormtile (23055)
newwormtile (23050)
newwormtile (23002)
newwormtile (23000)

newwormtile (24633)
newwormtile (24632)
newwormtile (24630)
newwormtile (24646)
newwormtile (24645)
newwormtile (24640)
newwormtile (24656)
newwormtile (24655)
newwormtile (24650)
newwormtile (24602)
newwormtile (24600)
newwormtile (24533)
newwormtile (24532)
newwormtile (24530)
newwormtile (24546)
newwormtile (24545)
newwormtile (24540)
newwormtile (24556)
newwormtile (24555)
newwormtile (24550)
newwormtile (24502)
newwormtile (24500)
newwormtile (24046)
newwormtile (24045)
newwormtile (24040)
newwormtile (24056)
newwormtile (24055)
newwormtile (24050)
newwormtile (24002)
newwormtile (24000)

newwormtile (25633)
newwormtile (25632)
newwormtile (25630)
newwormtile (25646)
newwormtile (25645)
newwormtile (25640)
newwormtile (25656)
newwormtile (25655)
newwormtile (25650)
newwormtile (25602)
newwormtile (25600)
newwormtile (25533)
newwormtile (25532)
newwormtile (25530)
newwormtile (25546)
newwormtile (25545)
newwormtile (25540)
newwormtile (25556)
newwormtile (25555)
newwormtile (25550)
newwormtile (25502)
newwormtile (25500)
newwormtile (25046)
newwormtile (25045)
newwormtile (25040)
newwormtile (25056)
newwormtile (25055)
newwormtile (25050)
newwormtile (25002)
newwormtile (25000)
newwormtile (20233)
newwormtile (20232)
newwormtile (20230)
newwormtile (20246)
newwormtile (20245)
newwormtile (20240)
newwormtile (20256)
newwormtile (20255)
newwormtile (20250)
newwormtile (20202)
newwormtile (20200)
newwormtile (20043)
newwormtile (20042)
newwormtile (20040)
newwormtile (20056)
newwormtile (20055)
newwormtile (20050)
newwormtile (20002)
newwormtile (20000)
newwormtile (04333)
newwormtile (04332)
newwormtile (04330)
newwormtile (04346)
newwormtile (04345)
newwormtile (04340)
newwormtile (04356)
newwormtile (04355)
newwormtile (04350)
newwormtile (04302)
newwormtile (04300)
newwormtile (04233)
newwormtile (04232)
newwormtile (04230)
newwormtile (04246)
newwormtile (04245)
newwormtile (04240)
newwormtile (04256)
newwormtile (04255)
newwormtile (04250)
newwormtile (04202)
newwormtile (04200)
newwormtile (04043)
newwormtile (04042)
newwormtile (04040)
newwormtile (04056)
newwormtile (04055)
newwormtile (04050)
newwormtile (04002)
newwormtile (04000)
newwormtile (05633)
newwormtile (05632)
newwormtile (05630)
newwormtile (05646)
newwormtile (05645)
newwormtile (05640)
newwormtile (05656)
newwormtile (05655)
newwormtile (05650)
newwormtile (05602)
newwormtile (05600)
newwormtile (05533)
newwormtile (05532)
newwormtile (05530)
newwormtile (05546)
newwormtile (05545)
newwormtile (05540)
newwormtile (05556)
newwormtile (05555)
newwormtile (05550)
newwormtile (05502)
newwormtile (05500)
newwormtile (05046)
newwormtile (05045)
newwormtile (05040)
newwormtile (05056)
newwormtile (05055)
newwormtile (05050)
newwormtile (05002)
newwormtile (05000)
newwormtile (00233)
newwormtile (00232)
newwormtile (00230)
newwormtile (00246)
newwormtile (00245)
newwormtile (00240)
newwormtile (00256)
newwormtile (00255)
newwormtile (00250)
newwormtile (00202)
newwormtile (00200)
newwormtile (00043)
newwormtile (00042)
newwormtile (00040)
newwormtile (00056)
newwormtile (00055)
newwormtile (00050)
newwormtile (00002)
newwormtile (00000)


#declare wormlen = wormi;

SPrec (SPid, transform {transform {basetrinv} translate -0*tile_thick*y translate gtras}, depth)
//SPwormrec (SPid, transform {translate gtras*mag}, depth, leftright)

#local i = 0;
#while (i < wormlen)
  object {
  #if (wormid[i] = 0) yellowmystic #else yellowspectre #end
    transform wormtr[i]
    transform basetrinv
    translate gtras
    translate tile_thick*y
  }
  #local i = i + 1;
#end

//object {
//#if (wormid[0] = 0) yellowmystic #else yellowspectre #end
//  transform wormtr[1]
//  transform basetrinv
//}

sphere {
  <0,0,0>
  0.4
  pigment {color Black}
  translate gtras
}

#declare lookatpos = <0,0,0>;
#declare mylocation = 0.8*mag*<0,10,0>;

#ifdef (panleft)
  #declare lookatpos = -0.4*zoomfactor*x;
  #if (panleft >= 2)
    #declare lookatpos = -1.2*zoomfactor*x;
  #end
  #declare zoomfactor = zoomfactor/3;
  #declare mylocation = 0.8*zoomfactor*<0,10,0>;
  #if (panleft >= 2)
    #declare mylocation = mylocation - 3*zoomfactor*x;
  #end
#end

#ifdef (panup)
  #declare lookatpos = lookatpos+panup*z;
  #declare mylocation = mylocation+panup*z;
#end

camera {
  location mylocation
  sky <0,0,1>
  look_at lookatpos
}

light_source { mag*<20, 20, -50> color White }
light_source { mag*<-50, 100, -100> color 0.5*White }
//light_source { 2*20*<1, 1, 1> color White }

background {White}
