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
#ifndef (wriggly) #declare wriggly = 0; #end
#ifndef (t1sig) #declare t1sig = 233; #end
#ifndef (flipflop) #declare flipflop = 11; #end
#ifndef (fftrans) #declare fftrans = 0.2; #end

#macro create_patch (tilesig, ggtras, patchlev)
  #local patchsig = tilesig - mod (tilesig, pow (10, patchlev));
  #local patchid = mod (int (tilesig/pow (10, patchlev)), 10);
  #local patchscale = <1,1,1>;
  #if (mod (patchlev,2) = 1) #local patchscale = <-1,1,1>; #end
  SPrec (patchid, transform {scale patchscale sig2tr (patchsig, 0, depth) ggtras}, patchlev)
#end

#ifndef (velocity) #declare velocity = 1; #end
#declare startsig = t1sig;
#declare precsig = t1sig;
#if (clock > 0)
  #declare time = clock;
  #declare fase = int (time/flipflop);
  #declare timerescaled = (time - fase*flipflop)/flipflop;  // in [0,1)
  #if (timerescaled < 1 - fftrans)
    #declare timeworm = (fase + timerescaled/(1 - fftrans))*flipflop;
    #declare rotworm = mod(fase,2)*180;
  #else
    #declare timeworm = fase*flipflop + flipflop;
    #declare fftau = (timerescaled + fftrans - 1)/fftrans;
    #if (mod(fase,2) = 0)
      #declare rotworm = 180*fftau;
    #else
      #declare rotworm = 180*(1 - fftau);
    #end
  #end
  #declare nsteps = int (timeworm/velocity);
  #declare interp = timeworm - velocity*nsteps;
  #local i = 0;
  #while (i < nsteps)
    #declare precsig = t1sig;
    #declare t1sig = prec_in_worm (t1sig, wriggly)
    #local i = i + 1;
  #end
#end

#declare precid = mod(precsig, 10);
#declare textfont = "LiberationMono-Regular.ttf"

#ifndef (t2sig) #declare t2sig = prec_in_worm (t1sig, wriggly) #end  // WARNING: this does not work if t1sigh > 0!
#ifndef (t1sigh) #declare t1sigh = 0; #end
#ifndef (t2sigh) #declare t2sigh = 0; #end
#ifndef (level) #declare level = int (depth/3); #end
#ifndef (nopatch) #declare patchlevel = 4; #end
//#ifndef (patchlevel) #declare patchlevel = 2; #end
#ifdef (patchlevel) #if (patchlevel > depth) #declare patchlevel = depth; #end #end
#ifndef (soggettiva) #declare soggettiva = 0; #end
#ifndef (SPid) #declare SPid = 1; #end
#ifndef (colors) #declare colors = depth; #end
#if (colors <= 0) #declare colors = depth + colors; #end
#ifndef (tailsig) #declare tailsig = 00000; #end
#ifndef (rotworm) #declare rotworm = 0; #end
#ifndef (dontshowall) #declare showall = 1; #end

#declare magstep = sqrt(4+sqrt(15));
#declare magdepth = pow (magstep, depth);
#declare mag = magdepth;

#declare gtras = transform {rotate 0*y};
#ifdef (mirror) #declare gtras = transform {gtras scale <-1, 1, 1>}; #end
#ifdef (rot) #declare gtras = transform {rotate rot*y} #end
#local lift = 0;

#ifdef (patchlevel)
  SProtcolorshue (250)
  SPbuildtiles ()
  #if (patchlevel = depth)
    SPrec (SPid, transform {transform {gtras} translate lift}, depth)
  #else
    #local tsig = startsig;
    #while (tsig)
      #if (mod (tsig, pow(10, patchlevel)) = 0)
        create_patch (tsig, transform {gtras translate lift}, patchlevel)
      #end
      #local tsig = prec_in_worm (tsig, wriggly)
    #end
    create_patch (0, transform {gtras translate lift}, patchlevel)
  #end
#end

#ifndef (zoomout) #declare zoomout=1; #end


#ifdef (zoomout)
  #declare mag = pow(magstep,zoomout);
#end

#ifdef (zoom) #declare zoomfactor = 1/zoom*zoomfactor; #end

/*
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
 */

/*
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
 */

#macro onetile (tileid, tiletr, ltrans, rotworm, precid)
  object {
    #if (tileid = 0)
      graymystic
      //whitemystic
      #if (rotworm != 0)
        #local rotsign = 0;
        #if (precid = 5) #local rotsign = 1; #end
        #if (precid = 2) #local rotsign = -1; #end
        #if (wriggly = 0)
          #local rotsign = 0;
          #if (precid = 5) #local rotsign = 1; #end
          #if (precid = 2) #local rotsign = -1; #end
          SProtmystic (rotsign*rotworm/180*120)
        #else
          #local rotsign = 0;
          #if (precid = 5) #local rotsign = 1; #end
          SProtmysticw (rotsign*rotworm/180*150)
        #end
      #end

    #else
      grayspectre
      //whitespectre
      #if (rotworm != 0)
        #if (wriggly = 0)
          SProtspectre (rotworm)
        #else
          #local rotsign = -1;
          #if (precid = 0 & hack = 0) #local rotsign = 1; #end
          SProtspectrew (rotsign*rotworm/180*120)
        #end
      #end
    #end
    transform {tiletr}
    transform {ltrans}
  }
#end

#declare tile1rot = sig2rot (t1sig, t1sigh, depth);
//#debug concat ("tile1rot = ", str(tile1rot,0,-1), "\n")
#declare tile2rot = sig2rot (t2sig, t2sigh, depth);


worm_init (2000)
#declare wormi = 0;

#ifdef (focussig)
  #ifndef (focussigh) #declare focussigh = 0; #end
  //newwormtilex (focussig, focussigh)
  #declare basetr = sig2tr (focussig, focussigh, depth);
#else
  //newwormtilex (0, 0)
  #declare basetr = sig2tr (t1sig, t1sigh, depth);
  #declare basetrn = vtransform (<0,0,0>, basetr);
  #declare tilerot = tile1rot;
  #ifdef (interp)
    #declare basetr2 = sig2tr (t2sig, t2sigh, depth);
    #declare basetrn2 = vtransform (<0,0,0>, basetr2);
    #declare basetrn = (1 - interp)*basetrn + interp*basetrn2;
    #declare tilerot = (1 - interp)*tile1rot + interp*tile2rot;
  #end
  // does not work eg with t1sig=430, t2sig=437, depth=3
  #declare basetr = transform {rotate -tilerot*y translate basetrn};
#end

//#declare basetr = wormtr[0];

#declare basetrinv = transform {basetr inverse}

#if (soggettiva = 0)
  #declare starget = vtransform (<0,0,0>, basetr);
  #declare basetrinv = transform {translate -starget};
#end

/*
#macro create_patch (tilesig, ggtras, patchlev)
  #local patchsig = tilesig - mod (tilesig, pow (10, patchlev));
  #local patchid = mod (int (tilesig/pow (10, patchlev)), 10);
  #local patchscale = <1,1,1>;
  #if (mod (patchlev,2) = 1) #local patchscale = <-1,1,1>; #end
  SPrec (patchid, transform {scale patchscale sig2tr (patchsig, 0, depth) ggtras}, patchlev)
#end
 */


//#ifdef (patchlevel)
//  create_patch (t1sig, transform {gtras translate lift}, patchlevel)
//#end

//SPrec (SPid, transform {transform {gtras} translate lift}, depth)

#declare bdthick=0.1;

SPskelrec (SPid, transform {transform {gtras} translate lift+2*tile_thick*y}, depth, level)

#local lift = lift + tile_thick*y;

#ifdef (showall)
  SPwormrec (SPid, transform {translate lift transform {gtras}}, depth)
  #local lift = lift + tile_thick*y;
#end

//#declare wormi = 0;
//newwormtilex (t1sig, t1sigh)
//newwormtilex (t2sig, t2sigh)

//SPrec (7, transform {Str[7][0] transform {gtras} translate lift}, 0)
//SPrec (7, transform {sig2tr (t1sig, t1sigh, depth) transform {gtras} translate lift}, 0)
#declare hack = 0;
//#if (mod(precsig,1000) = 450) #declare hack = 1; #end
#if (mod(precsig,100) = 50) #declare hack = 1; #end
onetile (sig2id (t1sig), sig2tr (t1sig, t1sigh, depth), transform {gtras translate lift}, rotworm, precid)
#declare hack = 0;
//#if (mod(t1sig,1000) = 450) #declare hack = 1; #end
#if (mod(t1sig,100) = 50) #declare hack = 1; #end
onetile (sig2id (t2sig), sig2tr (t2sig, t2sigh, depth), transform {gtras translate lift+0.01*y}, rotworm, sig2id (t1sig))


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
//createworm (wormlen, transform {gtras translate lift}, rotworm)

//#if (wormlen > 0) #local lift = lift + tile_thick*y; #end

//#local lift = lift + tile_thick*y;

#ifdef (cyl)
  cylinder {
    0*y
    1.0*y
    0.4
    pigment {color Black}
    transform {basetr gtras}
  }
#end

#declare lookatpos = <0,0,0>;
#declare mylocation = 0.8*mag*<0,10,0>;
#declare mysky = <0,0,1>;

#ifdef (overview)
  #declare mylocation = <0,5.0*magdepth,0>;
  #declare mysky = <0,0,1>;
#else
  #declare lookatpos = vtransform (lookatpos, transform {basetr gtras});
  #declare mylocation = vtransform (mylocation, transform {basetr gtras});
#end

#ifdef (panup)
  #declare lookatpos = lookatpos+magdepth*panup*z;
  #declare mylocation = mylocation+magdepth*panup*z;
#end

#ifdef (panright)
  #declare lookatpos = lookatpos+magdepth*panright*x;
  #declare mylocation = mylocation+magdepth*panright*x;
#end

text {ttf textfont str(t1sig,0,0) 0.1, 0
  pigment {Brown}
  rotate 90*x
  scale 3
  //translate -25*x + 10*y
  translate vtransform (<0,0,0>, basetr)
  translate -14*x + 8.5*z
  translate 3.5*tile_thick*y
  no_shadow
}

camera {
  location mylocation
  sky mysky
  look_at lookatpos
}

light_source { 20*mag*<20, 20, -50> color White }
light_source { 20*mag*<-50, 100, -100> color 0.5*White }
//light_source { 2*20*<1, 1, 1> color White }

background {White}
