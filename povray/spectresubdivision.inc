#include "transforms.inc"

//#declare scalefactor = phi*phi;   // approx 0.381977
#declare scalefactor = 1;
#declare scalefactor1 = 0.45;
#declare scalefactor2 = scalefactor1*0.5;

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
// #declare areaH7[0] = 7;
// #declare areaH8[0] = 8;

#local i = 2;
#while (i < maxfibo)
  #declare fibo[i] = fibo[i-1] + fibo[i-2];
  #declare lucas[i] = lucas[i-1] + lucas[i-2];
  #declare lucas31[i] = lucas31[i-1] + lucas31[i-2];
  #local i = i + 1;
#end
/*
#local i = 1;
#while (i < maxdepth)
  #declare areaH7[i] = areaH7[i-1] + 5*areaH8[i-1];
  #declare areaH8[i] = areaH7[i-1] + 6*areaH8[i-1];
  #local i = i + 1;
#end
 */
#ifdef (debug)
  #debug concat("fibo[29] = ", str(fibo[29],0,-1), "\n")
  #debug concat("lucas[29] = ", str(lucas[29],0,-1), "\n")
#end

#declare rot0 = array[maxdepth];
#declare rot1 = array[maxdepth];
#declare rot2 = array[maxdepth];
#declare rot3 = array[maxdepth];
#declare rot4 = array[maxdepth];
#declare rot5 = array[maxdepth];
#declare rot6 = array[maxdepth];
#declare rot7 = array[maxdepth];

#declare rot0[0] = 0;
#declare rot1[0] = 90;
#declare rot2[0] = 30;
#declare rot3[0] = -30;
#declare rot4[0] = -90;
#declare rot5[0] = -150;
#declare rot6[0] = rot2[0];
#declare rot7[0] = rot4[0];

#declare rot0[1] = 0;
#declare rot1[1] = 120;
#declare rot2[1] = 60;
#declare rot3[1] = 0;
#declare rot4[1] = -60;
#declare rot5[1] = -120;
#declare rot6[1] = rot2[1];
#declare rot7[1] = rot4[1];

#declare trn0 = array[maxdepth];
#declare trn1 = array[maxdepth];
#declare trn2 = array[maxdepth];
#declare trn3 = array[maxdepth];
#declare trn4 = array[maxdepth];
#declare trn5 = array[maxdepth];
#declare trn6 = array[maxdepth];
#declare trn7 = array[maxdepth];
#local i = 0;
#while (i < maxdepth)
  #declare trn0[i] = <0,0,0>;
  //#declare trn1[i] = <-3*fibo[2*i + 1], 0, ap*2*lucas[2*i + 2]>;
  #declare trn1[i] = <1/2+ap, 0, 1/2-ap>;
  //#declare trn2[i] = <-3/2*lucas[2*i+2], 0, ap*fibo[2*i + 1]>;
  #declare trn2[i] = <1/2+ap, 0, 1/2-ap+2>;
  //#declare trn3[i] = <-3/2*fibo[2*i + 2], 0, -ap*lucas31[2*i + 2]>;
  #declare trn3[i] = <1/2+ap, 0, 3+1/2+ap>;
  //#declare trn4[i] = <3/2*fibo[2*i], 0, -ap*(fibo[2*i + 2] + lucas[2*i + 2])>;
  #declare trn4[i] = <1/2-ap, 0, 2+1/2+ap>;
  //#declare trn5[i] = <-3/2*fibo[2*i + 4], 0, ap*(2*fibo[2*i + 2] + lucas[2*i + 2])>;
  #declare trn5[i] = <-1-2*ap, 0, 2>;
  //#declare trn6[i] = <-3/2*lucas[2*i+4], 0, ap*fibo[2*i + 3]>;
  #declare trn6[i] = <1/2+ap+3/2+ap, 0, 1/2-ap+2+ap-3/2>;
  #declare trn7[i] = <1/2-ap+ap-3/2, 0, 2+1/2+ap+3/2+ap>;
  #declare i = i + 1;
#end

#declare trn0[0] = <0,0,0>;
#declare trn1[0] = <1/2+ap, 0, 1/2-ap>;
#declare trn2[0] = <1/2+ap, 0, 1/2-ap+2>;
#declare trn3[0] = <1/2+ap, 0, 3+1/2+ap>;
#declare trn4[0] = <1/2-ap, 0, 2+1/2+ap>;
#declare trn5[0] = <-1-2*ap, 0, 2>;
#declare trn6[0] = <1/2+ap+3/2+ap, 0, 1/2-ap+2+ap-3/2>;
#declare trn7[0] = <1/2-ap+ap-3/2, 0, 2+1/2+ap+3/2+ap>;

#declare trn0[1] = <0,0,0>;
#declare trn1[1] = <4.5+3*ap,0,4.5-3*ap>;
#declare trn2[1] = <3.5-ap,0,4.5+3*ap>;
#declare trn3[1] = <3-4*ap,0,6+10*ap>;
#declare trn4[1] = <-1-2*ap,0,3+6*ap>;
#declare trn5[1] = <-6-2*ap,0,2*ap>;
#declare trn6[1] = <9+1/2+3*ap,0,7+1/2+ap>;
#declare trn7[1] = <-2-1/2-7*ap,0,4+1/2+13*ap>;

#macro spectrerec (trsf, depth)
  #local d = depth-1;
  #switch (depth)
    #case (0)
//      #ifdef (onlyworm)
//        #ifdef (MaxPosLeft)
//          #local h7pos = vtransform (<0,0,0>, transform {trsf});
//          #if (h7pos.x < MaxPosLeft.x)
//            #declare MaxPosLeft = h7pos;
//          #end
//        #end
//        object {spectre transform {trsf}}
//      #else
//        #ifdef (seet)
//          union { h7list (seet, seet, seet)
//            transform {trsf} }
//        #else
          object {spectre transform {trsf}}
//        #end
//      #end
    #break

    #range (1,maxdepth)
      mysticrec (transform {scale <-1,1,1> rotate rot0[d]*y translate trn0[d] scale scalefactor trsf}, d)
      //h8rec (transform {rotate rot2*y translate trn2[d] scale scalefactor trsf}, d)
      //#ifndef (onlyworm)
        spectrerec (transform {scale <-1,1,1> rotate rot1[d]*y translate trn1[d] scale scalefactor trsf}, d)
        spectrerec (transform {scale <-1,1,1> rotate rot2[d]*y translate trn2[d] scale scalefactor trsf}, d)
        spectrerec (transform {scale <-1,1,1> rotate rot3[d]*y translate trn3[d] scale scalefactor trsf}, d)
        spectrerec (transform {scale <-1,1,1> rotate rot4[d]*y translate trn4[d] scale scalefactor trsf}, d)
        spectrerec (transform {scale <-1,1,1> rotate rot5[d]*y translate trn5[d] scale scalefactor trsf}, d)
        spectrerec (transform {scale <-1,1,1> rotate rot6[d]*y translate trn6[d] scale scalefactor trsf}, d)
        spectrerec (transform {scale <-1,1,1> rotate rot7[d]*y translate trn7[d] scale scalefactor trsf}, d)
      //#end
    #break
  #end
#end

#macro mysticrec (trsf, depth)
  #local d = depth-1;
  #switch (depth)
    #case (0)
      //#ifdef (onlyworm)
      //  #ifdef (MaxPosLeft)
      //    #local h8pos = vtransform (<0,0,0>, transform {trsf});
      //    #if (h8pos.x < MaxPosLeft.x)
      //      #declare MaxPosLeft = h8pos;
      //    #end
      //  #end
      //  object {h8worm transform {trsf}}
      //#else
      //  #ifdef (seet)
      //    union { h8list (seet, seet, seet)
      //      transform {trsf} }
      //  #else
          object {mystic transform {trsf}}
      //  #end
      //#end
    #break

    #range (1,maxdepth)
      mysticrec (transform {scale <-1,1,1> rotate rot0[d]*y translate trn0[d] scale scalefactor trsf}, d)
      //h8rec (transform {rotate rot2*y translate trn2[d] scale scalefactor trsf}, d)
      //h8rec (transform {rotate rot6*y translate trn6[d] scale scalefactor trsf}, d)
      //#ifndef (onlyworm)
        spectrerec (transform {scale <-1,1,1> rotate rot1[d]*y translate trn1[d] scale scalefactor trsf}, d)
        spectrerec (transform {scale <-1,1,1> rotate rot2[d]*y translate trn2[d] scale scalefactor trsf}, d)
        spectrerec (transform {scale <-1,1,1> rotate rot3[d]*y translate trn3[d] scale scalefactor trsf}, d)
        spectrerec (transform {scale <-1,1,1> rotate rot4[d]*y translate trn4[d] scale scalefactor trsf}, d)
        spectrerec (transform {scale <-1,1,1> rotate rot5[d]*y translate trn5[d] scale scalefactor trsf}, d)
        spectrerec (transform {scale <-1,1,1> rotate rot6[d]*y translate trn6[d] scale scalefactor trsf}, d)
      //#end
    #break
  #end
#end

