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

#debug concat("fibo[29] = ", str(fibo[29],0,-1), "\n")
#debug concat("lucas[29] = ", str(lucas[29],0,-1), "\n")

#declare rot0 = 0;
#declare rot1 = 120;
#declare rot2 = 0;
#declare rot3 = -60;
#declare rot4 = -120;
#declare rot5 = 60;
#declare rot6 = 0;

#declare trn0 = array[maxdepth];
#declare trn1 = array[maxdepth];
#declare trn2 = array[maxdepth];
#declare trn3 = array[maxdepth];
#declare trn4 = array[maxdepth];
#declare trn5 = array[maxdepth];
#declare trn6 = array[maxdepth];
#local i = 0;
#while (i < maxdepth)
  #declare trn0[i] = <0,0,0>;
  #declare trn1[i] = <-3*fibo[2*i + 1], 0, ap*2*lucas[2*i + 2]>;
  #declare trn2[i] = <-3/2*lucas[2*i+2], 0, ap*fibo[2*i + 1]>;
  #declare trn3[i] = <-3/2*fibo[2*i + 2], 0, -ap*lucas31[2*i + 2]>;
  #declare trn4[i] = <3/2*fibo[2*i], 0, -ap*(fibo[2*i + 2] + lucas[2*i + 2])>;
  #declare trn5[i] = <-3/2*fibo[2*i + 4], 0, ap*(2*fibo[2*i + 2] + lucas[2*i + 2])>;
  #declare trn6[i] = <-3/2*lucas[2*i+4], 0, ap*fibo[2*i + 3]>;
  #declare i = i + 1;
#end

#macro h7rec (trsf, depth)
  #local d = depth-1;
  #switch (depth)
    #case (0)
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
    #break

    #range (1,maxdepth)
      h7rec (transform {rotate rot0*y translate trn0[d] scale scalefactor trsf}, d)
      h8rec (transform {rotate rot2*y translate trn2[d] scale scalefactor trsf}, d)
      #ifndef (onlyworm)
        h8rec (transform {rotate rot1*y translate trn1[d] scale scalefactor trsf}, d)
        h8rec (transform {rotate rot3*y translate trn3[d] scale scalefactor trsf}, d)
        h8rec (transform {rotate rot4*y translate trn4[d] scale scalefactor trsf}, d)
        h8rec (transform {rotate rot5*y translate trn5[d] scale scalefactor trsf}, d)
      #end
    #break
  #end
#end

#macro h8rec (trsf, depth)
  #local d = depth-1;
  #switch (depth)
    #case (0)
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
    #break

    #range (1,maxdepth)
      h7rec (transform {rotate rot0*y translate trn0[d] scale scalefactor trsf}, d)
      h8rec (transform {rotate rot2*y translate trn2[d] scale scalefactor trsf}, d)
      h8rec (transform {rotate rot6*y translate trn6[d] scale scalefactor trsf}, d)
      #ifndef (onlyworm)
        h8rec (transform {rotate rot1*y translate trn1[d] scale scalefactor trsf}, d)
        h8rec (transform {rotate rot3*y translate trn3[d] scale scalefactor trsf}, d)
        h8rec (transform {rotate rot4*y translate trn4[d] scale scalefactor trsf}, d)
        h8rec (transform {rotate rot5*y translate trn5[d] scale scalefactor trsf}, d)
      #end
    #break
  #end
#end

