#include "transforms.inc"

#declare maxdepth = 10;
#declare maxfibo = 30;

#declare fibo = array[maxfibo]
#declare lucas = array[maxfibo]
#declare lucas31 = array[maxfibo]
#declare areaH7 = array[maxdepth]
#declare areaH8 = array[maxdepth]
#declare fibo[0] = 1;
#declare fibo[1] = 1;
#declare lucas[0] = 2;
#declare lucas[1] = 1;
#declare lucas31[0] = 3;
#declare lucas31[1] = 1;
#declare areaH7[0] = 7;
#declare areaH8[0] = 8;

#local i = 2;
#while (i < maxfibo)
  #declare fibo[i] = fibo[i-1] + fibo[i-2];
  #declare lucas[i] = lucas[i-1] + lucas[i-2];
  #declare lucas31[i] = lucas31[i-1] + lucas31[i-2];
  #local i = i + 1;
#end
#local i = 1;
#while (i < maxdepth)
  #declare areaH7[i] = areaH7[i-1] + 5*areaH8[i-1];
  #declare areaH8[i] = areaH7[i-1] + 6*areaH8[i-1];
  #local i = i + 1;
#end

#ifdef (debug)
  #debug concat("fibo[29] = ", str(fibo[29],0,-1), "\n")
  #debug concat("lucas[29] = ", str(lucas[29],0,-1), "\n")
#end

#declare rot0 = 0;
#declare rot1 = 120;
#declare rot2 = 0;
#declare rot3 = -60;
#declare rot4 = -120;
#declare rot5 = 60;
#declare rot6 = 0;
#declare rotvec = array[7] {rot0, rot1, rot2, rot3, rot4, rot5, rot6}

#declare trn0 = array[maxdepth];
#declare trn1 = array[maxdepth];
#declare trn2 = array[maxdepth];
#declare trn3 = array[maxdepth];
#declare trn4 = array[maxdepth];
#declare trn5 = array[maxdepth];
#declare trn6 = array[maxdepth];
#declare trnvec = array[7][maxdepth];
#local i = 0;
#while (i < maxdepth)
  #declare trn0[i] = <0,0,0>;
  #declare trn1[i] = <-3*fibo[2*i + 1], 0, ap*2*lucas[2*i + 2]>;
  #declare trn2[i] = <-3/2*lucas[2*i+2], 0, ap*fibo[2*i + 1]>;
  #declare trn3[i] = <-3/2*fibo[2*i + 2], 0, -ap*lucas31[2*i + 2]>;
  #declare trn4[i] = <3/2*fibo[2*i], 0, -ap*(fibo[2*i + 2] + lucas[2*i + 2])>;
  #declare trn5[i] = <-3/2*fibo[2*i + 4], 0, ap*(2*fibo[2*i + 2] + lucas[2*i + 2])>;
  #declare trn6[i] = <-3/2*lucas[2*i+4], 0, ap*fibo[2*i + 3]>;
  #declare trnvec[0][i] = trn0[i];
  #declare trnvec[1][i] = trn1[i];
  #declare trnvec[2][i] = trn2[i];
  #declare trnvec[3][i] = trn3[i];
  #declare trnvec[4][i] = trn4[i];
  #declare trnvec[5][i] = trn5[i];
  #declare trnvec[6][i] = trn6[i];
  #declare i = i + 1;
#end

#ifndef (colors) #declare colors = 100; #end
#ifndef (deltahue) #declare deltahue = 360*phi*phi; #end

#macro HATrec (htile, trsf, depth)
  #local d = depth-1;
  #if (depth = 0)
    #ifdef (onlyworm)
      #ifdef (MaxPosLeft)
        #local HATpos = vtransform (<0,0,0>, transform {trsf});
        #if (HATpos.x < MaxPosLeft.x)
          #declare MaxPosLeft = HATpos;
        #end
      #end
      #if (htile = 7)
        object {h7worm transform {trsf}}
      #else
        object {h8worm transform {trsf}}
      #end
    #else
      #ifdef (seet)
        #if (htile = 7)
          union { h7list (seet, seet, seet)
        #else
          union { h8list (seet, seet, seet)
        #end
          transform {trsf} }
      #else
        #if (htile = 7)
          object {h7m transform {trsf}}
        #else
          object {h8m transform {trsf}}
        #end
      #end
    #end
  #else
    HATrec (7, transform {rotate rot0*y translate trn0[d] trsf}, d)
    HATrec (8, transform {rotate rot2*y translate trn2[d] trsf}, d)
    #if (htile != 7)
      HATrec (8, transform {rotate rot6*y translate trn6[d] trsf}, d)
    #end
    #ifndef (onlyworm)
      HATrec (8, transform {rotate rot1*y translate trn1[d] trsf}, d)
      HATrec (8, transform {rotate rot3*y translate trn3[d] trsf}, d)
      HATrec (8, transform {rotate rot4*y translate trn4[d] trsf}, d)
      HATrec (8, transform {rotate rot5*y translate trn5[d] trsf}, d)
    #end
    #if (d >= colors-1) HATrotcolorshue (deltahue) HATbuildtiles() #end
  #end
#end

#macro h7rec (trsf, depth)
  #local d = depth-1;
  #if (depth = 0)
    #ifdef (onlyworm)
      #ifdef (MaxPosLeft)
        #local h7pos = vtransform (<0,0,0>, transform {trsf});
        #if (h7pos.x < MaxPosLeft.x)
          #declare MaxPosLeft = h7pos;
        #end
      #end
      object {h7worm transform {trsf}}
    #else
      #ifdef (seet)
        union { h7list (seet, seet, seet)
          transform {trsf} }
      #else
        object {h7m transform {trsf}}
      #end
    #end
  #else
    h7rec (transform {rotate rot0*y translate trn0[d] trsf}, d)
    h8rec (transform {rotate rot2*y translate trn2[d] trsf}, d)
    #ifndef (onlyworm)
      h8rec (transform {rotate rot1*y translate trn1[d] trsf}, d)
      h8rec (transform {rotate rot3*y translate trn3[d] trsf}, d)
      h8rec (transform {rotate rot4*y translate trn4[d] trsf}, d)
      h8rec (transform {rotate rot5*y translate trn5[d] trsf}, d)
    #end
  #end
#end

#macro h8rec (trsf, depth)
  #local d = depth-1;
  #if (depth = 0)
    #ifdef (onlyworm)
      #ifdef (MaxPosLeft)
        #local h8pos = vtransform (<0,0,0>, transform {trsf});
        #if (h8pos.x < MaxPosLeft.x)
          #declare MaxPosLeft = h8pos;
        #end
      #end
      object {h8worm transform {trsf}}
    #else
      #ifdef (seet)
        union { h8list (seet, seet, seet)
          transform {trsf} }
      #else
        object {h8m transform {trsf}}
      #end
    #end
  #else
    h7rec (transform {rotate rot0*y translate trn0[d] trsf}, d)
    h8rec (transform {rotate rot2*y translate trn2[d] trsf}, d)
    h8rec (transform {rotate rot6*y translate trn6[d] trsf}, d)
    #ifndef (onlyworm)
      h8rec (transform {rotate rot1*y translate trn1[d] trsf}, d)
      h8rec (transform {rotate rot3*y translate trn3[d] trsf}, d)
      h8rec (transform {rotate rot4*y translate trn4[d] trsf}, d)
      h8rec (transform {rotate rot5*y translate trn5[d] trsf}, d)
    #end
  #end
#end

/*
 * construct two vectors that must have been preallocated
 *   wormvectype = 7 or 8 or 88  (88 in case this is the #6 of the subdivision of an H8)
 *   wormvecpos
 *
 * index wormveci is the index
 */

#macro buildwormrecvec (dim, depth)
  #declare wormvectype = array[dim];
  #declare wormvecpos = array[dim];
  #declare wormveci = 0;
  wormrecvec (7, <0,0,0>, depth)
#end

#macro wormrecvec (type78, pos, depth)
  #if (depth = 0)
    #declare wormvectype[wormveci] = type78;
    #declare wormvecpos[wormveci] = pos;
    #declare wormveci = wormveci + 1;
  #else
    #local d = depth - 1;
    wormrecvec (7, pos + trn0[d], d)
    wormrecvec (8, pos + trn2[d], d)
    #if (type78 != 7)
      wormrecvec (88, pos + trn6[d], d)
    #end
  #end
#end
