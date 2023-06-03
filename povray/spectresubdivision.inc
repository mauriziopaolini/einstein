#include "transforms.inc"

//#declare scalefactor = phi*phi;   // approx 0.381977

#declare maxdepth = 10;

#declare QA = array[maxdepth+1];
#declare QB = array[maxdepth+1];
#declare QC = array[maxdepth+1];
#declare QD = array[maxdepth+1];

#declare QA[0] = <-1/2-ap,0,1/2-ap>;
#declare QB[0] = <+1/2+ap,0,3/2+ap>;
#declare QC[0] = <-1/2+ap,0,5/2+ap>;
#declare QD[0] = <-1,0,3>;

#declare Strs0 = array[maxdepth];
#declare Strs1 = array[maxdepth];
#declare Strs2 = array[maxdepth];
#declare Strs3 = array[maxdepth];
#declare Strs4 = array[maxdepth];
#declare Strs5 = array[maxdepth];
#declare Strs6 = array[maxdepth];
#declare Strs7 = array[maxdepth];

#local i = 0;
#while (i < maxdepth)
  #ifdef (QD[i])
    #declare Strs0[i] = transform {scale <-1,1,1>};
    #declare Strs1[i] = transform { translate -QB[i] rotate 120*y translate QB[i] Strs0[i]};
    #declare Strs2[i] = transform { translate -QC[i] rotate -60*y translate QA[i] Strs1[i]};
    #declare Strs3[i] = transform { translate (QD[i] - QB[i]) Strs2[i]};
    #declare Strs4[i] = transform { translate -QC[i] rotate -60*y translate QC[i] translate (QA[i]-QC[i]) Strs3[i]};
    #declare Strs5[i] = transform { translate -QC[i] rotate -60*y translate QC[i] translate (QA[i]-QC[i]) Strs4[i]};
    #declare Strs6[i] = transform { translate (QD[i] - QB[i]) Strs5[i]};
    #declare Strs7[i] = transform { translate -QC[i] rotate -60*y translate QC[i] translate (QA[i]-QC[i]) Strs6[i]};
    /* we are now in a position to construct the higher level quadrilateral! */
    #declare QA[i+1] = vtransform (QC[i], transform {Strs1[i]});
    #declare QB[i+1] = vtransform (QD[i], transform {Strs7[i]});
    #declare QC[i+1] = vtransform (QC[i], transform {Strs6[i]});
    #declare QD[i+1] = vtransform (QD[i], transform {Strs4[i]});
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

#macro spectrerec (trsf, depth)
  #local d = depth-1;
  #switch (depth)
    #case (0)
      object {spectre transform {trsf}}
      #ifdef (quadrilateral)
      object {quadm (QA[0], QB[0], QC[0], QD[0], 0.1)
        transform {trsf}
        translate tile_thick*y
        pigment {rgb <1,0,0>}
        finish {tile_Finish}
      }
      #end
    #break

    #range (1,maxdepth)
      mysticrec (transform {Strs0[d] trsf}, d)
      spectrerec (transform {Strs1[d] trsf}, d)
      spectrerec (transform {Strs2[d] trsf}, d)
      spectrerec (transform {Strs3[d] trsf}, d)  // missing spectre in spectre subdivision
      spectrerec (transform {Strs4[d] trsf}, d)
      spectrerec (transform {Strs5[d] trsf}, d)
      spectrerec (transform {Strs6[d] trsf}, d)
      spectrerec (transform {Strs7[d] trsf}, d)
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

#macro mysticrec (trsf, depth)
  #local d = depth-1;
  #switch (depth)
    #case (0)
      object {mystic transform {trsf}}
      #ifdef (quadrilateral)
      object {quadm (QA[0], QB[0], QC[0], QD[0], 0.1)
        transform {trsf}
        translate tile_thick*y
        pigment {rgb <0,0,1>}
        finish {tile_Finish}
      }
      #end
    #break

    #range (1,maxdepth)
      mysticrec (transform {Strs0[d] trsf}, d)
      spectrerec (transform {Strs1[d] trsf}, d)
      spectrerec (transform {Strs2[d] trsf}, d)
      /*
       * this is the missing tile in the deflation of a mystic:
       *   spectrerec (transform {Strs3[d] trsf}, d)
       */
      spectrerec (transform {Strs4[d] trsf}, d)
      spectrerec (transform {Strs5[d] trsf}, d)
      spectrerec (transform {Strs6[d] trsf}, d)
      spectrerec (transform {Strs7[d] trsf}, d)
      #ifdef (quadrilateral)
      object {quadm (QA[depth], QB[depth], QC[depth], QD[depth], depth*0.15)
        transform {trsf}
        translate tile_thick*y
        pigment {rgb 1/depth*<0,0.5,1>}
        finish {tile_Finish}
      }
      #end
    #break
  #end
#end

