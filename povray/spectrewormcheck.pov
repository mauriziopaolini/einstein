/*
 * WARNING: non funziona il posizionamento dei due tasselli se depth è dispari
 */

/*
 * We display two tiles by their signature, one is the reference tile (focussig),
 * the other is given by its tipsig
 * specifically this is for checking adjacency of tiles along a worm
 */

#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "shapes.inc"
#include "spectresubdivision.inc"
#include "spectreworm.inc"

#ifndef (depth) #declare depth = 3; #end // must coincide with the number of digits in signatures
#ifndef (t1sig) #declare t1sig = 233; #end
#ifndef (t2sig) #declare t2sig = 300; #end
//#ifndef (focussig) #declare focussig=t1sig; #end
#ifndef (t1sigh) #declare t1sigh = 0; #end
#ifndef (t2sigh) #declare t2sigh = 0; #end
//#ifndef (focussigh) #declare focussigh=t1sigh; #end
#ifndef (level) #declare level = depth - 1; #end
#ifndef (SPid) #declare SPid = 1; #end
#ifndef (colors) #declare colors = depth; #end
#if (colors <= 0) #declare colors = depth + colors; #end
#ifndef (tailsig) #declare tailsig = 00000; #end
#ifndef (rotworm) #declare rotworm = 0; #end
#ifndef (dontshowall) #declare showall = 1; #end

#declare magstep = sqrt(4+sqrt(15));
#declare magdepth = pow (magstep, depth);
#declare mag = magdepth;

#ifndef (zoomout) #declare zoomout=1; #end


#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

//#declare gtras = 0*x - 1.5*mag*z;
#declare gtras = transform {rotate 0*y};
#ifdef (rot) #declare gtras = transform {rotate rot*y} #end

#ifdef (zoom) #declare zoomfactor = 1/zoom*zoomfactor; #end

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

#macro newwormtilex (sig, sigh)
  #local sigloc = sig;
  #local sigtail = mod (sigloc, 10);
  #declare wormid[wormi] = sigtail;
  #declare wormtr[wormi] = transform {
  #local ii = 0;
  //#while (sigloc)
  #while (ii < 6)
    #local sigtail = mod (sigloc, 10);
    transform Str[sigtail][ii]
    #local sigloc = int (sigloc/10);
    #local ii = ii + 1;
  #end
  #local sigloc = sigh;
  #local sigtail = mod (sigloc, 10);
  #while (sigloc)
    #local sigtail = mod (sigloc, 10);
    transform Str[sigtail][ii]
    #local sigloc = int (sigloc/10);
    #local ii = ii + 1;
  #end
  }
  #declare wormi = wormi + 1;
#end

/*
#macro newwormtilex (sig, sigh)
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
 */


#macro onetile (tileid, tiletr, ltrans)
  object {
    #if (tileid = 0)
      graymystic
    #else
      grayspectre
    #end
    transform {tiletr}
    transform {ltrans}
  }
#end

//onetile (wormid[0], wormtr[0], transform {basetrinv gtras translate lift})
//onetile (wormid[1], wormtr[1], transform {basetrinv gtras translate lift})

#declare tile1rot = sig2rot (t1sig, t1sigh);
#debug concat ("tile1rot = ", str(tile1rot,0,-1), "\n")
#declare tile2rot = sig2rot (t2sig, t2sigh);

/*
 * FUTURE: use tile1rot and tile2rot to build the basetrinv transformation
 * by interpolation between tile1 and tile2
 */




worm_init (2000)
#declare wormi = 0;

#ifdef (focussig)
  #ifndef (focussigh) #declare focussigh = 0; #end
  //newwormtilex (focussig, focussigh)
  #declare basetr = sig2tr (focussig, focussigh);
#else
  //newwormtilex (0, 0)
  #declare basetr = sig2tr (t1sig, t1sigh);
  #declare basetrn = vtransform (<0,0,0>, basetr);
  #declare tilerot = tile1rot;
  #ifdef (interp)
    #declare basetr2 = sig2tr (t2sig, t2sigh);
    #declare basetrn2 = vtransform (<0,0,0>, basetr2);
    #declare basetrn = (1 - interp)*basetrn + interp*basetrn2;
    #declare tilerot = (1 - interp)*tile1rot + interp*tile2rot;
  #end
  // does not work eg with t1sig=430, t2sig=437, depth=3
  //#declare basetr = transform {rotate tilerot*y translate basetrn};
#end

//#declare basetr = wormtr[0];

#declare basetrinv = transform {basetr inverse}

#local lift = 0;

//#declare spectrerot_center = <-5/4-ap/2,0,9/4-ap/2>;
//#declare tower_tr = SPbd[5] - SPbd[9];
//#declare reltowormtr = spectrerot_center - 0.5*tower_tr;
//#ifdef (reltowormvar) #declare reltowormtr = spectrerot_center; #end
//#declare reltoworm = transform {translate -reltowormtr rotate -rotworm*y translate reltowormtr}

//#if (SPid = 0)
//  SPbmystic (transform {basetrinv translate lift gtras}, depth)
//#else
//  SPbspectre (transform {basetrinv translate lift gtras}, depth)
//#end

//SPrec (SPid, transform {transform {basetrinv reltoworm} transform {gtras} translate lift}, depth)

#declare bdthick=0.1;

SPskelrec (SPid, transform {transform {basetrinv} transform {gtras} translate lift+2*tile_thick*y}, depth, level)

#local lift = lift + tile_thick*y;

#ifdef (showall)
  SPwormrec (SPid, transform {transform {basetrinv} translate lift transform {gtras}}, depth)
  #local lift = lift + tile_thick*y;
#end

//#declare wormi = 0;
//newwormtilex (t1sig, t1sigh)
//newwormtilex (t2sig, t2sigh)

onetile (sig2id (t1sig), sig2tr (t1sig, t1sigh), transform {basetrinv gtras translate lift})
onetile (sig2id (t2sig), sig2tr (t2sig, t2sigh), transform {basetrinv gtras translate lift})


/* not used for now

#macro createworm (wormlen, ltrans, rotworm)
  #local i = 0;
  #while (i < wormlen)
    object {
      #if (wormid[i] = 0)
        graymystic
        #if (rotworm != 0)
          #local rotsign = 0;
          #if (wormid[i-1] = 5) #local rotsign = 1; #end
          #if (wormid[i-1] = 2) #local rotsign = -1; #end
          SProtmystic (rotsign*rotworm/180*120)
        #end
      #else
        grayspectre
        #if (rotworm != 0)
          SProtspectre (rotworm)
        #end
      #end
      transform {wormtr[i]}
      transform {ltrans}
    }
    #local i = i + 1;
  #end
#end
 */

//#declare wormlen = wormi;
//#ifndef (rotworm) #declare rotworm = 0; #end
//createworm (wormlen, transform {basetrinv gtras translate lift}, rotworm)

//#if (wormlen > 0) #local lift = lift + tile_thick*y; #end

//#local lift = lift + tile_thick*y;

#ifndef (nocyl)
  cylinder {
    0*y
    1.0*y
    0.4
    pigment {color Black}
    transform {gtras}
  }
#end

#declare lookatpos = <0,0,0>;
#declare mylocation = 0.8*mag*<0,10,0>;

#ifdef (panup)
  #declare lookatpos = lookatpos+magdepth*panup*z;
  #declare mylocation = mylocation+magdepth*panup*z;
#end

#ifdef (panright)
  #declare lookatpos = lookatpos+magdepth*panright*x;
  #declare mylocation = mylocation+magdepth*panright*x;
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
