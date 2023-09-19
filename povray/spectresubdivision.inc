#include "transforms.inc"

#declare maxdepth = 10;

#ifndef (SPshow)
  #declare SPshow = 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128;
#end

#declare QA = array[maxdepth+1];
#declare QB = array[maxdepth+1];
#declare QC = array[maxdepth+1];
#declare QD = array[maxdepth+1];

#declare QA[0] = SPbd[2];  //<-1/2-ap,0,1/2-ap>;
#declare QB[0] = SPbd[9];  //<+1/2+ap,0,3/2+ap>;
#declare QC[0] = SPbd[7];  //<-1/2+ap,0,5/2+ap>;
#declare QD[0] = SPbd[5];  //<-1,0,3>;

#declare Str = array[8][maxdepth];
#ifndef (colors) #declare colors = 100; #end
#ifndef (deltahue) #declare deltahue = 360*phi*phi; #end

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

#declare LEFT = 1;
#declare RIGHT = 2;
#declare LEFTRIGHT = 3;

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
    #if (d >= colors-1) SProtcolorshue (deltahue) SPbuildtiles() #end
    #ifdef (quadrilateral)
    object {quadm (QA[depth], QB[depth], QC[depth], QD[depth], depth*0.15)
      transform {trsf}
      translate tile_thick*y
      pigment {rgb 1/depth*<1,0.5,0>}
      finish {tile_Finish}
    }
    #end
  #end
#end

/*
 * wriggly can only be 0 or 1
 */

#ifndef (wriggly) #declare wriggly = 0; #end

#macro SPwormrec (tid, trsf, depth)
  #local d = depth-1;
  #if (depth = 0)

    #if (tid = 0) object {greenmystic transform {trsf}} #end
    #if (tid != 0) object {greenspectre transform {trsf}} #end

  #else

    #if (mod(depth,2) = 1 - wriggly)
      SPwormrec (0, transform {Str[0][d] trsf}, d)
      SPwormrec (2, transform {Str[2][d] trsf}, d)
      #if (tid != 0) SPwormrec (3, transform {Str[3][d] trsf}, d) #end
      SPwormrec (5, transform {Str[5][d] trsf}, d)
      SPwormrec (6, transform {Str[6][d] trsf}, d)
    #else
      SPwormrec (0, transform {Str[0][d] trsf}, d)
      #if (tid != 0) SPwormrec (3, transform {Str[3][d] trsf}, d) #end
      SPwormrec (4, transform {Str[4][d] trsf}, d)
      SPwormrec (5, transform {Str[5][d] trsf}, d)
    #end

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


/*
 * we have seven pieces of boundary a through g
 * (with id 1 to 7)
 */

#declare bX_id = array[6][9];
#declare bX_tr = array[6][9];

/*
 * this is based on the simpler subdivision in four pieces a,b,c,d
 */

#declare SPbida = 1;
#declare SPbidb = 2;
#declare SPbidc = 3;
#declare SPbidd = 4;

/*
 * to obtain the mystic boundary we need a finer subdivision
 */

#declare SPbidbmystic = 5;

/* ===== */

#declare bX_id[SPbida][0] = SPbidb;
#declare bX_tr[SPbida][0] = 7;
#declare bX_id[SPbida][1] = SPbida;
#declare bX_tr[SPbida][1] = 0;
#declare bX_id[SPbida][2] = SPbidd;
#declare bX_tr[SPbida][2] = 1;
#declare bX_id[SPbida][3] = 0;

#declare bX_id[SPbidb][0] = SPbidc;
#declare bX_tr[SPbidb][0] = 1;
#declare bX_id[SPbidb][1] = SPbidb;
#declare bX_tr[SPbidb][1] = 1;
#declare bX_id[SPbidb][2] = SPbidc;
#declare bX_tr[SPbidb][2] = 2;
#declare bX_id[SPbidb][3] = SPbidd;
#declare bX_tr[SPbidb][3] = 3;
#declare bX_id[SPbidb][4] = SPbidc;
#declare bX_tr[SPbidb][4] = 3;
#declare bX_id[SPbidb][5] = SPbidb;
#declare bX_tr[SPbidb][5] = 3;
#declare bX_id[SPbidb][6] = SPbidc;
#declare bX_tr[SPbidb][6] = 4;
#declare bX_id[SPbidb][7] = 0;

#declare bX_id[SPbidc][0] = SPbidb;
#declare bX_tr[SPbidc][0] = 4;
#declare bX_id[SPbidc][1] = SPbidc;
#declare bX_tr[SPbidc][1] = 5;
#declare bX_id[SPbidc][2] = SPbidd;
#declare bX_tr[SPbidc][2] = 6;
#declare bX_id[SPbidc][3] = 0;

#declare bX_id[SPbidd][0] = SPbidc;
#declare bX_tr[SPbidd][0] = 6;
#declare bX_id[SPbidd][1] = SPbidb;
#declare bX_tr[SPbidd][1] = 6;
#declare bX_id[SPbidd][2] = SPbidc;
#declare bX_tr[SPbidd][2] = 7;
#declare bX_id[SPbidd][3] = 0;

/* ===== */

#declare bX_id[SPbidbmystic][0] = SPbidc;
#declare bX_tr[SPbidbmystic][0] = 1;
#declare bX_id[SPbidbmystic][1] = SPbidb;
#declare bX_tr[SPbidbmystic][1] = 1;
#declare bX_id[SPbidbmystic][2] = SPbidc;
#declare bX_tr[SPbidbmystic][2] = 2;
#declare bX_id[SPbidbmystic][3] = SPbida;  // this should be reverted in orientation
#declare bX_tr[SPbidbmystic][3] = 3;
#declare bX_id[SPbidbmystic][4] = SPbidc;
#declare bX_tr[SPbidbmystic][4] = 4;
#declare bX_id[SPbidbmystic][5] = 0;

/* ===== */


#ifndef (bdthick) #declare bdthick = 1; #end

/*
 * cannot do the same with the mystic at the moment
 */

#macro SPbspectre (trsf, dpth)
  SPbrec (SPbida, transform {trsf}, dpth)
  SPbrec (SPbidb, transform {trsf}, dpth)
  SPbrec (SPbidc, transform {trsf}, dpth)
  SPbrec (SPbidd, transform {trsf}, dpth)
#end

#macro SPbmystic (trsf, dpth)
  SPbrec (SPbida, transform {trsf}, dpth)
  SPbrec (SPbidbmystic, transform {trsf}, dpth)
  SPbrec (SPbidc, transform {trsf}, dpth)
  SPbrec (SPbidd, transform {trsf}, dpth)
#end

#macro SPbgen (tid, trsf, dpth)
  #if (tid = 0)
    SPbmystic (trsf, dpth)
  #else
    SPbspectre (trsf, dpth)
  #end
#end

#macro SPbrec (btid, trsf, depth)
  #local d = depth-1;
  #if (depth = 0)
      union {
    #switch (btid)
      #case (SPbida)
          sphere {SPbd[2], bdthick}
          sphere {SPbd[1], bdthick}
          sphere {SPbd[0], bdthick}
          sphere {SPbd[12], bdthick}
          sphere {SPbd[11], bdthick}
          sphere {SPbd[10], bdthick}
          cylinder {SPbd[2], SPbd[1], bdthick}
          cylinder {SPbd[1], SPbd[0], bdthick}
          cylinder {SPbd[0], SPbd[12], bdthick}
          cylinder {SPbd[12], SPbd[11], bdthick}
          cylinder {SPbd[11], SPbd[10], bdthick}
          cylinder {SPbd[10], SPbd[9], bdthick}
        #break

      #case (SPbidb)
          sphere {SPbd[3], bdthick}
          sphere {SPbd[4], bdthick}
          sphere {SPbd[5], bdthick}
          cylinder {SPbd[2], SPbd[3], bdthick}
          cylinder {SPbd[3], SPbd[4], bdthick}
          cylinder {SPbd[4], SPbd[5], bdthick}
        #break

      #case (SPbidc)
          sphere {SPbd[6], bdthick}
          sphere {SPbd[7], bdthick}
          cylinder {SPbd[5], SPbd[6], bdthick}
          cylinder {SPbd[6], SPbd[7], bdthick}
        #break

      #case (SPbidd)
          sphere {SPbd[8], bdthick}
          sphere {SPbd[9], bdthick}
          cylinder {SPbd[7], SPbd[8], bdthick}
          cylinder {SPbd[8], SPbd[9], bdthick}
        #break

      #case (SPbidbmystic)  // this is drawn ONLY with depth=0 and is not perfect!
          sphere {SPbd[1], bdthick}
          sphere {SPbd[2], bdthick}
          sphere {SPbd[3], bdthick}
          sphere {SPbd[4], bdthick}
          sphere {SPbd[5], bdthick}
          sphere {SPbd[6], bdthick}
          sphere {SPbd[7], bdthick}
          sphere {SPbd[8], bdthick}
          sphere {SPbd[9], bdthick}
          cylinder {SPbd[1], SPbd[2], bdthick}
          cylinder {SPbd[2], SPbd[3], bdthick}
          cylinder {SPbd[3], SPbd[4], bdthick}
          cylinder {SPbd[4], SPbd[5], bdthick}
          cylinder {SPbd[5], SPbd[6], bdthick}
          cylinder {SPbd[6], SPbd[7], bdthick}
          cylinder {SPbd[7], SPbd[8], bdthick}
          cylinder {SPbd[8], SPbd[9], bdthick}
          cylinder {SPbd[9], SPbd[10], bdthick}
        #break
    #end
    #if (btid = SPbidbmystic) transform {mystic_tr} #end
      transform {trsf}
      texture {pigment {color Black}}
      finish {tile_Finish}
    }
  #else
    #local i = 0;
    #while (bX_id[btid][i] > 0)
      /* get correct transformation */
      #local btrsfid = bX_tr[btid][i];
      #local btrsf = Str[btrsfid][d];
      SPbrec (bX_id[btid][i], transform {btrsf trsf}, d)
      #local i = i + 1;
    #end
  #end
#end

