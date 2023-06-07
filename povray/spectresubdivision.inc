#include "transforms.inc"

#declare maxdepth = 10;

#ifndef (SPshow)
  #declare SPshow = 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128;
#end

#declare QA = array[maxdepth+1];
#declare QB = array[maxdepth+1];
#declare QC = array[maxdepth+1];
#declare QD = array[maxdepth+1];

#declare QA[0] = <-1/2-ap,0,1/2-ap>;
#declare QB[0] = <+1/2+ap,0,3/2+ap>;
#declare QC[0] = <-1/2+ap,0,5/2+ap>;
#declare QD[0] = <-1,0,3>;

#declare Str = array[8][maxdepth];

#local i = 0;
#while (i < maxdepth)
  #ifdef (QD[i])
    #declare Str[0][i] = transform {scale <-1,1,1>};
    #declare Str[1][i] = transform { translate -QB[i] rotate 120*y translate QB[i] Str[0][i]};
    #declare Str[2][i] = transform { translate -QC[i] rotate -60*y translate QA[i] Str[1][i]};
    #declare Str[3][i] = transform { translate (QD[i] - QB[i]) Str[2][i]};
    #declare Str[4][i] = transform { translate -QC[i] rotate -60*y translate QC[i] translate (QA[i]-QC[i]) Str[3][i]};
    #declare Str[5][i] = transform { translate -QC[i] rotate -60*y translate QC[i] translate (QA[i]-QC[i]) Str[4][i]};
    #declare Str[6][i] = transform { translate (QD[i] - QB[i]) Str[5][i]};
    #declare Str[7][i] = transform { translate -QC[i] rotate -60*y translate QC[i] translate (QA[i]-QC[i]) Str[6][i]};
    /* we are now in a position to construct the higher level quadrilateral! */
    #declare QA[i+1] = vtransform (QC[i], transform {Str[1][i]});
    #declare QB[i+1] = vtransform (QD[i], transform {Str[7][i]});
    #declare QC[i+1] = vtransform (QC[i], transform {Str[6][i]});
    #declare QD[i+1] = vtransform (QD[i], transform {Str[4][i]});
  #end
  #local i = i + 1;
#end

#macro quadm (A, B, C, D, r)
  union {
    sphere {A, r}
    sphere {B, r}
    sphere {C, r}
    sphere {D, r}
    cylinder {A, B, r}
    cylinder {B, C, r}
    cylinder {C, D, r}
    cylinder {D, A, r}
  }
#end

#macro SPrec (tid, trsf, depth)
  #local d = depth-1;
  #if (depth = 0)
      object {SPobj[tid] transform {trsf}}
      #ifdef (quadrilateral)
      object {quadm (QA[0], QB[0], QC[0], QD[0], 0.1)
        transform {trsf}
        translate tile_thick*y
        pigment {rgb <1,0,0>}
        finish {tile_Finish}
      }
      #end
    #else
      // SPrec (0, transform {Str[0][d] trsf}, d)
      #local i = 0;
      #while (i < 8)
        #if (bitwise_and (SPshow, pow(2,i)) & (tid != 0 | i != 3)) SPrec (i, transform {Str[i][d] trsf}, d) #end
        #local i = i + 1;
      #end
      #ifdef (quadrilateral)
      object {quadm (QA[depth], QB[depth], QC[depth], QD[depth], depth*0.15)
        transform {trsf}
        translate tile_thick*y
        pigment {rgb 1/depth*<1,0.5,0>}
        finish {tile_Finish}
      }
      #end
    #break
  #end
#end

#macro make_transparent (seet)
  #declare SPobj[0] = union {
    object { tile11
      translate <-1,0,0>
      rotate -30*y
      translate -<1/2,0,ap-3>
      texture {pigment {rgbft <0, 0, 0.5, 0, seet>}}  
    }
    object { tile11
      texture {pigment {rgbft SPpigment[1] + <0,0,0,0,seet>}}
    }
  }
  #local i = 1;
  #while (i < 8)
    #declare SPobj[i] = object { tile11
      texture {pigment {rgbft SPpigment[i] + <0,0,0,0,seet>}}
    }
    #local i = i + 1;
  #end
#end
