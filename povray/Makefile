
depthsH78 = 0 1 2 3 4 5 6
deflated_suf = $(depthsH78:%=H7_%) $(depthsH78:%=H8_%)

deflated_png_H7 = $(depthsH78:%=einstein_H7_d%.png)
deflated_png_H8 = $(depthsH78:%=einstein_H8_d%.png)

deflated_png_hexH7 = $(depthsH78:%=hexagon_H7_d%.png)
deflated_png_hexH8 = $(depthsH78:%=hexagon_H8_d%.png)

depthsSM = 0 1 2 3 4 5 6
deflated_png_S = $(depthsSM:%=spectre_d%.png)
deflated_png_M = $(depthsSM:%=mystic_d%.png)
deflatedq_png_S = $(depthsSM:%=spectreq_d%.png)
deflatedq_png_M = $(depthsSM:%=mysticq_d%.png)

hatfractals: hath8fractal.png hath7fractal.png hath8fractalsub.png

#
# CONWAY SIGNATURES: HAT
#

hatsignatures=[0] [2] [6] [602] [026] [260] [1] [3] [4] [5] [63] [36]
hatsigpngd6=${hatsignatures:%=hatconwaysig%_d6.png}
hatsigpngd6z=${hatsignatures:%=hatconwaysig%_d6z.png}
hatsigpngd6zz=${hatsignatures:%=hatconwaysig%_d6zz.png}

hatsigsd6: $(hatsigpngd6) hatconwaysig[63][63][63]_d6.png hatconwaysig[36][36][36]_d6.png hatconwaysig[5][5]_d6.png hatconwaysig[0][6]_d6.png hatconwaysig[0][6]bis_d6.png hatconwaysig[0][6][6]_d6.png
hatsigsd6z: $(hatsigpngd6z) hatconwaysig[63][63][63]_d6z.png hatconwaysig[36][36][36]_d6z.png hatconwaysig[5][5]_d6z.png hatconwaysig[0][6]_d6z.png hatconwaysig[0][6]_d6z.png hatconwaysig[0][6][6]_d6z.png
hatsigsd6zz: $(hatsigpngd6zz) hhatconwaysig[63][63][63]_d6zz.png hatconwaysig[36][36][36]_d6zz.png atconwaysig[5][5]_d6zz.png hatconwaysig[0][6]_d6zz.png hatconwaysig[0][6]_d6zz.png hatconwaysig[0][6][6]_d6zz.png

#
# CONWAY SIGNATURES: HEX: HEXAGONAL TILES
#

hexsignatures=[0] [2] [6] [602] [026] [260] [1] [3] [4] [5] [63] [36]
hexsigpngd6=${hexsignatures:%=hexconwaysig%_d6.png}
hexsigpngd6z=${hexsignatures:%=hexconwaysig%_d6z.png}
hexsigpngd6zz=${hexsignatures:%=hexconwaysig%_d6zz.png}

hexsigsd6: $(hexsigpngd6) hexconwaysig[63][63][63]_d6.png hexconwaysig[36][36][36]_d6.png hexconwaysig[5][5]_d6.png hexconwaysig[0][6]_d6.png hexconwaysig[0][6]bis_d6.png hexconwaysig[0][6][6]_d6.png
hexsigsd6z: $(hexsigpngd6z) hexconwaysig[63][63][63]_d6z.png hexconwaysig[36][36][36]_d6z.png hexconwaysig[5][5]_d6z.png hexconwaysig[0][6]_d6z.png hexconwaysig[0][6]_d6z.png hexconwaysig[0][6][6]_d6z.png
hexsigsd6zz: $(hexsigpngd6zz) hexconwaysig[63][63][63]_d6zz.png hexconwaysig[36][36][36]_d6zz.png hexconwaysig[5][5]_d6zz.png hexconwaysig[0][6]_d6zz.png hexconwaysig[0][6]_d6zz.png hexconwaysig[0][6][6]_d6zz.png

#
# end HEX
#

hatholezlevels=1 2 3 4 5
hatholes=$(hatholezlevels:%=hathole_z%.png)
hatholepngs: $(hatholes)

#
# CONWAY SIGNATURES: SPECTRE
#

spectresignatures=[0] [1] [2] [3] [4] [5] [6] [7] [04] [40] [13] [14] [24] [34] [36] [67] [31] [41] [42] [43] [63] [76]
spectresigpngd6=${spectresignatures:%=spectreconwaysig%_d6.png}
spectresigpngd6z=${spectresignatures:%=spectreconwaysig%_d6z.png}
spectresigpngd6zz=${spectresignatures:%=spectreconwaysig%_d6zz.png}

spectresigsd6: $(spectresigpngd6) spectreconwaysig[5][3]_d6.png spectreconwaysig[0][3][3]_d6.png spectreconwaysig[1][1]_d6.png spectreconwaysig[6][6][6]_d6.png
spectresigsd6z: $(spectresigpngd6z) spectreconwaysig[5][3]_d6z.png spectreconwaysig[0][3][3]_d6z.png spectreconwaysig[1][1]_d6z.png spectreconwaysig[6][6][6]_d6z.png
spectresigsd6zz: $(spectresigpngd6zz) spectreconwaysig[5][3]_d6zz.png spectreconwaysig[0][3][3]_d6zz.png spectreconwaysig[1][1]_d6zz.png spectreconwaysig[6][6][6]_d6zz.png

spectreholezlevels=1 2 3 4 5
spectreholes=$(spectreholezlevels:%=spectrehole_z%.png)
spectrehole2s=$(spectreholezlevels:%=spectrehole2_z%.png)
spectrehole2slices=$(spectreholezlevels:%=spectrehole2slice_z%.png)
spectrehole2alts=$(spectreholezlevels:%=spectrehole2alt_z%.png)
spectrehole2alt2s=$(spectreholezlevels:%=spectrehole2alt2_z%.png)
spectreholepropellers=$(spectreholezlevels:%=spectreholepropeller_z%.png)
spectreholepropellerws=$(spectreholezlevels:%=spectreholepropellerw_z%.png)
spectreholepngs: $(spectreholes) $(spectrehole2s) $(spectrehole2slices) $(spectrehole2alts) $(spectrehole2alt2s) $(spectreholepropellers) $(spectreholepropellerws)

#
# SPECTRE WORMS
#

spectreworms0=spectreworm_d4.png spectreworm_d5.png spectreworm_d6.png spectreworm_d6zzz.png spectreworm_w_d5.png spectreworm_w_d5z.png spectreworm_w_d5alt.png spectreworm_w_d5zalt.png spectreworm_w_d6.png spectreworm_w_d6z.png

spectrehydras: spectrehydra.png spectrehydra_o.png spectrehydra_z.png spectrehydra_r.png spectrehydra2.png spectrehydra2_o.png spectrehydra2_z.png spectrehydra2_r.png

spectretripods: spectretripod.png spectretripod_o.png spectretripod_z.png spectretripodw.png spectretripodw_o.png spectretripodw_z.png

spectreworms: $(spectreworms0) $(spectrehydras)

spectrefractals: spectrefractal.png mysticfractal.png spectrefractalsub.png

#
#
#

yellowtopviews = yellow_brick_road_topview01 yellow_brick_road_topview023 yellow_brick_road_3clusters
hextopviews = hex_brick_road_topview01 hex_brick_road_topview023 hex_brick_road_3clusters
paths=01 023

allH78 = $(deflated_png_H7) $(deflated_png_H8)
allhexH78 = $(deflated_png_hexH7) $(deflated_png_hexH8)
allSM = $(deflated_png_S) $(deflated_png_M) $(deflatedq_png_S) $(deflatedq_png_M)

all: $(allH78) $(allSM)
allchiral: $(allSM)

#
# png images
#

povoptspng = -D +a +W1024 +H768

hatnumbers.png: einstein.pov
	povray -D $< Declare=numbers=1 Declare=arrow=1 +O$@

hexnumbers.png: hexagons.pov
	povray -D $< Declare=numbers=1 Declare=arrow=1 +O$@

spectrenumbers.png: spectre.pov
	povray -D $< Declare=numbers=1 +O$@

#
# HAT SIGNATURES
#

hatconwaysig[63][63][63]_d6zz.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=636363 Declare=Sigl=636363 Declare=special63=1 Declare=depth=6 Declare=zoomout=2 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hatconwaysig[36][36][36]_d6zz.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=363636 Declare=Sigl=363636 Declare=special63=36 Declare=depth=6 Declare=zoomout=2 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hatconwaysig[63][63][63]_d6z.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=636363 Declare=Sigl=636363 Declare=special63=1 Declare=depth=6 Declare=zoomout=4 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hatconwaysig[36][36][36]_d6z.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=363636 Declare=Sigl=363636 Declare=special63=36 Declare=depth=6 Declare=zoomout=4 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hatconwaysig[63][63][63]_d6.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=636363 Declare=Sigl=636363 Declare=special63=1 Declare=depth=6 Declare=zoomout=6 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hatconwaysig[36][36][36]_d6.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=363636 Declare=Sigl=363636 Declare=special63=36 Declare=depth=6 Declare=zoomout=6 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hatconwaysig[0][6]_d6zz.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=up2=60 Declare=down2=26 Declare=depth=6 Declare=zoomout=2 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hatconwaysig[0][6]_d6z.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=up2=60 Declare=down2=26 Declare=depth=6 Declare=zoomout=4 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hatconwaysig[0][6]_d6.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=up2=60 Declare=down2=26 Declare=depth=6 Declare=zoomout=6 +Otmp_pippo.png
	mv tmp_pippo.png $@

hatconwaysig[0][6][6]_d6zz.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=Sigh3=666666 Declare=Sigl3=666666 Declare=up2=60 Declare=down2=26 Declare=up3=60 Declare=down3=54 Declare=depth=6 Declare=zoomout=2 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hatconwaysig[0][6][6]_d6z.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=Sigh3=666666 Declare=Sigl3=666666 Declare=up2=60 Declare=down2=26 Declare=up3=60 Declare=down3=54 Declare=depth=6 Declare=zoomout=4 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hatconwaysig[0][6][6]_d6.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=Sigh3=666666 Declare=Sigl3=666666 Declare=up2=60 Declare=down2=26 Declare=up3=60 Declare=down3=54 Declare=up2=60 Declare=down2=26 Declare=depth=6 Declare=zoomout=6 +Otmp_pippo.png
	mv tmp_pippo.png $@

hatconwaysig[0][6]bis_d6zz.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=up2=60 Declare=down2=54 Declare=depth=6 Declare=zoomout=2 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hatconwaysig[0][6]bis_d6z.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=up2=60 Declare=down2=54 Declare=depth=6 Declare=zoomout=4 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hatconwaysig[0][6]bis_d6.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=up2=60 Declare=down2=54 Declare=depth=6 Declare=zoomout=6 +Otmp_pippo.png
	mv tmp_pippo.png $@

hatconwaysig[5][5]_d6zz.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=555555 Declare=Sigl=555555 Declare=up2=05 Declare=down2=11 Declare=depth=6 Declare=zoomout=2 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hatconwaysig[5][5]_d6z.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=555555 Declare=Sigl=555555 Declare=up2=05 Declare=down2=11 Declare=depth=6 Declare=zoomout=4 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hatconwaysig[5][5]_d6.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=555555 Declare=Sigl=555555 Declare=up2=05 Declare=down2=11 Declare=depth=6 Declare=zoomout=6 +Otmp_pippo.png
	mv tmp_pippo.png $@

$(hatsigpngd6):hatconwaysig%_d6.png:hatconwaysig.pov hatsig2povopt.sh
	./hatsig2povopt.sh -q $* povray Declare=depth=6 $(povoptspng) +O- >$@

$(hatsigpngd6z):hatconwaysig%_d6z.png:hatconwaysig.pov hatsig2povopt.sh
	./hatsig2povopt.sh -q $* povray Declare=depth=6 Declare=zoomout=4 $(povoptspng) +O- >$@

$(hatsigpngd6zz):hatconwaysig%_d6zz.png:hatconwaysig.pov hatsig2povopt.sh
	./hatsig2povopt.sh -q $* povray Declare=depth=6 Declare=zoomout=2 $(povoptspng) +O- >$@

#
# HEX SIGNATURES (hexagonal tiles)
#

dep = 5

hexconwaysig[63][63][63]_d6zz.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=636363 Declare=Sigl=636363 Declare=special63=1 Declare=depth=6 Declare=zoomout=2 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hexconwaysig[36][36][36]_d6zz.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=363636 Declare=Sigl=363636 Declare=special63=36 Declare=depth=6 Declare=zoomout=2 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hexconwaysig[63][63][63]_d6z.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=636363 Declare=Sigl=636363 Declare=special63=1 Declare=depth=6 Declare=zoomout=4 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hexconwaysig[36][36][36]_d6z.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=363636 Declare=Sigl=363636 Declare=special63=36 Declare=depth=6 Declare=zoomout=4 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hexconwaysig[63][63][63]_d6.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=636363 Declare=Sigl=636363 Declare=special63=1 Declare=depth=6 Declare=zoomout=6 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hexconwaysig[36][36][36]_d6.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=363636 Declare=Sigl=363636 Declare=special63=36 Declare=depth=6 Declare=zoomout=6 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hexconwaysig[0][6]_d6zz.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=up2=60 Declare=down2=26 Declare=depth=6 Declare=zoomout=2 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hexconwaysig[0][6]_d6z.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=up2=60 Declare=down2=26 Declare=depth=6 Declare=zoomout=4 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hexconwaysig[0][6]_d6.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=up2=60 Declare=down2=26 Declare=depth=6 Declare=zoomout=6 +Otmp_pippo.png
	mv tmp_pippo.png $@

hexconwaysig[0][6][6]_d6zz.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=Sigh3=666666 Declare=Sigl3=666666 Declare=up2=60 Declare=down2=26 Declare=up3=60 Declare=down3=54 Declare=depth=6 Declare=zoomout=2 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hexconwaysig[0][6][6]_d6z.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=Sigh3=666666 Declare=Sigl3=666666 Declare=up2=60 Declare=down2=26 Declare=up3=60 Declare=down3=54 Declare=depth=6 Declare=zoomout=4 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hexconwaysig[0][6][6]_d6.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=Sigh3=666666 Declare=Sigl3=666666 Declare=up2=60 Declare=down2=26 Declare=up3=60 Declare=down3=54 Declare=up2=60 Declare=down2=26 Declare=depth=6 Declare=zoomout=6 +Otmp_pippo.png
	mv tmp_pippo.png $@

hexconwaysig[0][6]bis_d6zz.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=up2=60 Declare=down2=54 Declare=depth=6 Declare=zoomout=2 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hexconwaysig[0][6]bis_d6z.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=up2=60 Declare=down2=54 Declare=depth=6 Declare=zoomout=4 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hexconwaysig[0][6]bis_d6.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=up2=60 Declare=down2=54 Declare=depth=6 Declare=zoomout=6 +Otmp_pippo.png
	mv tmp_pippo.png $@

hexconwaysig[5][5]_d6zz.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=555555 Declare=Sigl=555555 Declare=up2=05 Declare=down2=11 Declare=depth=6 Declare=zoomout=2 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hexconwaysig[5][5]_d6z.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=555555 Declare=Sigl=555555 Declare=up2=05 Declare=down2=11 Declare=depth=6 Declare=zoomout=4 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hexconwaysig[5][5]_d6.png: hexconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=555555 Declare=Sigl=555555 Declare=up2=05 Declare=down2=11 Declare=depth=6 Declare=zoomout=6 +Otmp_pippo.png
	mv tmp_pippo.png $@

$(hexsigpngd6):hexconwaysig%_d6.png:hexconwaysig.pov hatsig2povopt.sh
	./hatsig2povopt.sh -q $* povray Declare=depth=6 $(povoptspng) +O- >$@

$(hexsigpngd6z):hexconwaysig%_d6z.png:hexconwaysig.pov hatsig2povopt.sh
	./hatsig2povopt.sh -q $* povray Declare=depth=6 Declare=zoomout=4 $(povoptspng) +O- >$@

$(hexsigpngd6zz):hexconwaysig%_d6zz.png:hexconwaysig.pov hatsig2povopt.sh
	./hatsig2povopt.sh -q --hex $* povray Declare=depth=6 Declare=zoomout=2 $(povoptspng) +O- >$@

#
# end HEX SIGNATURE
#

hath8fractal.png: hatbd.pov subdivision.inc
	povray +a $(povoptspng) $< Declare=depth=6 Declare=bdthick=6 Declare=zoomout=6.2 Declare=panup=0 Declare=panright=-2 Declare=ptsize=40 Declare=draw4points=1 +O$@

hath7fractal.png: hatbd.pov subdivision.inc
	povray +a $(povoptspng) $< Declare=depth=6 Declare=bdthick=6 Declare=zoomout=6.2 Declare=panup=0 Declare=panright=-2 Declare=ptsize=40 Declare=draw4points=1 Declare=htile=7 +O$@

hath8fractalsub.png: hatbd.pov subdivision.inc
	povray +a $(povoptspng) $< Declare=depth=6 Declare=bdthick=6 Declare=zoomout=6.2 Declare=panup=0 Declare=panright=-2 Declare=ptsize=40 Declare=draw4points=1 Declare=subdivide=1 Declare=draw4points=1 Declare=subpoints=1 Declare=letters=1 +O$@

#
# various activities for Spectre tiles, e.g. used during "notte dei ricercatori"
#

activityhole0.png: activityhole.pov
	povray $(povoptspng) $< Declare=sub=0 +O$@

activityhole1.png: activityhole.pov
	povray $(povoptspng) $< Declare=sub=1 +O$@

activityhole2.png: activityhole.pov
	povray $(povoptspng) $< Declare=sub=2 +O$@

activityhole2after.png: activityhole.pov
	povray $(povoptspng) $< Declare=sub=2 declare=rotworm=180 +O$@

activityhole3.png: activityhole.pov
	povray $(povoptspng) $< Declare=sub=3 +O$@

activityhole3after.png: activityhole.pov
	povray $(povoptspng) $< Declare=sub=3 declare=rotworm=180 +O$@

activity0.png: activities.pov
	povray $(povoptspng) $< Declare=activity=0 +O$@

activity1.png: activities.pov
	povray $(povoptspng) $< Declare=activity=0 Declare=gray=1 +O$@

activity2.png: activities.pov
	povray $(povoptspng) $< Declare=activity=2 +O$@

activity3.png: activities.pov
	povray $(povoptspng) $< Declare=activity=3 Declare=zoomout=0.12 +O$@

activity4.png: activities.pov
	povray $(povoptspng) $< Declare=activity=4 Declare=zoomout=0.35 +O$@

activity4mystic.png: activities.pov
	povray $(povoptspng) $< Declare=activity=4 Declare=zoomout=0.35 Declare=SPid=0 +O$@

activity5.png: activities.pov
	povray $(povoptspng) $< Declare=activity=5 +O$@

activity5mystic.png: activities.pov
	povray $(povoptspng) $< Declare=activity=5 Declare=SPid=0 +O$@

activity6.png: activities.pov
	povray $(povoptspng) $< Declare=activity=6 +O$@

activity6mystic.png: activities.pov
	povray $(povoptspng) $< Declare=activity=6 Declare=SPid=0 +O$@

#
# SPECTRE SIGNATURES
#

spectreconwaysig[5][3]_d6.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=555555 Declare=Sigl=555555 Declare=Sigh2=333333 Declare=Sigl2=333333 Declare=up2=05 Declare=down2=27 Declare=depth=6 Declare=zoomout=6 Declare=bdthick=3 +O- >$@

spectreconwaysig[5][3]_d6z.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=555555 Declare=Sigl=555555 Declare=Sigh2=333333 Declare=Sigl2=333333 Declare=up2=05 Declare=down2=27 Declare=depth=6 Declare=zoomout=4 Declare=bdthick=2 +O- >$@

spectreconwaysig[5][3]_d6zz.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=555555 Declare=Sigl=555555 Declare=Sigh2=333333 Declare=Sigl2=333333 Declare=up2=05 Declare=down2=27 Declare=depth=6 Declare=zoomout=2 Declare=bdthick=0.3 +O- >$@

spectreconwaysig[1][1]_d6.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=111111 Declare=Sigl=111111 Declare=Sigh2=111111 Declare=Sigl2=111111 Declare=up2=04 Declare=down2=27 Declare=depth=6 Declare=zoomout=6 Declare=bdthick=3 +O- >$@

spectreconwaysig[1][1]_d6z.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=111111 Declare=Sigl=111111 Declare=Sigh2=111111 Declare=Sigl2=111111 Declare=up2=04 Declare=down2=27 Declare=depth=6 Declare=zoomout=4 Declare=bdthick=2 +O- >$@

spectreconwaysig[1][1]_d6zz.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=111111 Declare=Sigl=111111 Declare=Sigh2=111111 Declare=Sigl2=111111 Declare=up2=04 Declare=down2=27 Declare=depth=6 Declare=zoomout=2 Declare=bdthick=0.3 +O- >$@

spectreconwaysig[0][3][3]_d6.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=333333 Declare=Sigl2=333333 Declare=Sigh3=333333 Declare=Sigl3=333333 Declare=up2=10 Declare=down2=26 Declare=up3=10 Declare=down3=06 Declare=depth=6 Declare=zoomout=6 Declare=bdthick=3 +Otmp_pippo.png
	mv tmp_pippo.png $@

spectreconwaysig[0][3][3]_d6z.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=333333 Declare=Sigl2=333333 Declare=Sigh3=333333 Declare=Sigl3=333333 Declare=up2=03 Declare=down2=02 Declare=up3=10 Declare=down3=06 Declare=depth=6 Declare=zoomout=4 Declare=bdthick=2 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

spectreconwaysig[0][3][3]_d6zz.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=333333 Declare=Sigl2=333333 Declare=Sigh3=333333 Declare=Sigl3=333333 Declare=up2=03 Declare=down2=02 Declare=up3=10 Declare=down3=06 Declare=depth=6 Declare=zoomout=2 Declare=bdthick=0.3 +Otmp_pippozz.png
	mv tmp_pippozz.png $@

spectreconwaysig[6][6][6]_d6.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=666666 Declare=Sigl=666666 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=Sigh3=666666 Declare=Sigl3=666666 Declare=up2=06 Declare=down2=27 Declare=up3=01 Declare=down3=71 Declare=depth=6 Declare=zoomout=6 Declare=bdthick=3 +O- >$@

spectreconwaysig[6][6][6]_d6z.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=666666 Declare=Sigl=666666 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=Sigh3=666666 Declare=Sigl3=666666 Declare=up2=06 Declare=down2=27 Declare=up3=01 Declare=down3=71 Declare=depth=6 Declare=zoomout=4 Declare=bdthick=2 +O- >$@

spectreconwaysig[6][6][6]_d6zz.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=666666 Declare=Sigl=666666 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=Sigh3=666666 Declare=Sigl3=666666 Declare=up2=06 Declare=down2=27 Declare=up3=01 Declare=down3=71 Declare=depth=6 Declare=zoomout=2 Declare=bdthick=0.3 Declare=nocyl=1 +O- >$@

spectreconwaysig[4][4][4]_d6.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=444444 Declare=Sigl=444444 Declare=Sigh2=444444 Declare=Sigl2=444444 Declare=Sigh3=444444 Declare=Sigl3=444444 Declare=up2=05 Declare=down2=27 Declare=up3=17 Declare=down3=07 Declare=depth=6 Declare=zoomout=6 Declare=bdthick=3 +O- >$@

spectreconwaysig[4][4][4]_d6z.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=444444 Declare=Sigl=444444 Declare=Sigh2=444444 Declare=Sigl2=444444 Declare=Sigh3=444444 Declare=Sigl3=444444 Declare=up2=05 Declare=down2=27 Declare=up3=17 Declare=down3=07 Declare=depth=6 Declare=zoomout=4 Declare=bdthick=2 +O- >$@

spectreconwaysig[4][4][4]_d6zz.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=444444 Declare=Sigl=444444 Declare=Sigh2=444444 Declare=Sigl2=444444 Declare=Sigh3=444444 Declare=Sigl3=444444 Declare=up2=05 Declare=down2=27 Declare=up3=17 Declare=down3=07 Declare=depth=6 Declare=zoomout=2 Declare=bdthick=0.3 Declare=nocyl=1 +O- >$@


spectreconwaysig[14][36]_d6.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=141414 Declare=Sigl=141414 Declare=Sigh2=363636 Declare=Sigl2=363636 Declare=up2=04 Declare=down2=27 Declare=depth=6 Declare=zoomout=6 Declare=bdthick=3 +O- >$@

spectreconwaysig[14][36]_d6z.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=141414 Declare=Sigl=141414 Declare=Sigh2=363636 Declare=Sigl2=363636 Declare=up2=04 Declare=down2=27 Declare=depth=6 Declare=zoomout=4 Declare=bdthick=2 +O- >$@

spectreconwaysig[14][36]_d6zz.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=141414 Declare=Sigl=141414 Declare=Sigh2=363636 Declare=Sigl2=363636 Declare=up2=04 Declare=down2=27 Declare=depth=6 Declare=zoomout=2 Declare=bdthick=0.3 +O- >$@


spectreconwaysig[41][63]_d6.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=414141 Declare=Sigl=414141 Declare=Sigh2=636363 Declare=Sigl2=636363 Declare=up2=27 Declare=down2=06 Declare=depth=6 Declare=zoomout=6 Declare=bdthick=3 +O- >$@

spectreconwaysig[41][63]_d6z.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=414141 Declare=Sigl=414141 Declare=Sigh2=636363 Declare=Sigl2=636363 Declare=up2=27 Declare=down2=06 Declare=depth=6 Declare=zoomout=4 Declare=bdthick=3 +O- >$@

spectreconwaysig[41][63]_d6zz.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=414141 Declare=Sigl=414141 Declare=Sigh2=636363 Declare=Sigl2=636363 Declare=up2=27 Declare=down2=06 Declare=depth=6 Declare=zoomout=2 Declare=bdthick=3 +O- >$@


spectreconwaysig[14][36]_d6z.png: spectreconwaysig.pov


$(spectresigpngd6):spectreconwaysig%_d6.png:spectreconwaysig.pov spectresig2povopt.sh
	./spectresig2povopt.sh -q $* povray Declare=depth=6 $(povoptspng) +O- >$@

$(spectresigpngd6z):spectreconwaysig%_d6z.png:spectreconwaysig.pov spectresig2povopt.sh
	./spectresig2povopt.sh -q $* povray Declare=depth=6 Declare=zoomout=4 $(povoptspng) +O- >$@

$(spectresigpngd6zz):spectreconwaysig%_d6zz.png:spectreconwaysig.pov spectresig2povopt.sh
	./spectresig2povopt.sh -q $* povray Declare=depth=6 Declare=zoomout=2 $(povoptspng) +O- >$@

#
# Spectre worms
#

spectreworm_d4.png: spectreworm.pov spectreworm.inc
	povray $(povoptspng) $< Declare=depth=4 Declare=zoomout=3.3 Declare=panright=-0.6 Declare=panup=0.8 Declare=showall=1 Declare=tipsig=3333 +O$@

spectreworm_d5.png: spectreworm.pov spectreworm.inc
	povray $(povoptspng) $< Declare=depth=5 Declare=zoomout=4.5 Declare=panright=-0.8 Declare=panup=1.2 Declare=showall=1 Declare=tipsig=33333 +O$@

spectreworm_d6.png: spectreworm.pov spectreworm.inc
	povray $(povoptspng) $< Declare=depth=6 Declare=zoomout=5.3 Declare=panright=-0.6 Declare=panup=0.8 Declare=showall=1 Declare=tipsig=333333 +O$@

spectreworm_d6zzz.png: spectreworm.pov spectreworm.inc
	povray +a $(povoptspng) $< Declare=depth=6 Declare=zoomout=1.5 Declare=showall=1 Declare=tipsig=333333 Declare=focussig=23333 Declare=colors=5 Declare=deltahue=10 +O$@

spectreworm_w_d5.png: spectreworm.pov spectreworm.inc
	povray +a $(povoptspng) $< Declare=depth=5 Declare=zoomout=4.3 Declare=showall=1 Declare=tipsig=33333 Declare=tipsigw=33333 Declare=focussig=04040 Declare=panup=1.1 +O$@

spectreworm_w_d5z.png: spectreworm.pov spectreworm.inc
	povray +a $(povoptspng) $< Declare=depth=5 Declare=zoomout=2 Declare=tipsig=33333 Declare=tipsigw=33333 Declare=focussig=33333 Declare=panup=-0.1 Declare=panright=0.18 +O$@

spectreworm_w_d5alt.png: spectreworm.pov spectreworm.inc
	povray +a $(povoptspng) $< Declare=depth=5 Declare=zoomout=4 Declare=showall=1 Declare=tipsig=63333 Declare=tipsigw=33333 Declare=focussig=04040 Declare=panup=0 +O$@

spectreworm_w_d5zalt.png: spectreworm.pov spectreworm.inc
	povray +a $(povoptspng) $< Declare=depth=5 Declare=zoomout=2 Declare=showall=1 Declare=tipsig=63333 Declare=tipsigw=33333 Declare=focussig=55000 Declare=panup=0 +O$@

spectreworm_w_d6.png: spectreworm.pov spectreworm.inc
	povray +a $(povoptspng) $< Declare=depth=6 Declare=zoomout=5 Declare=showall=1 Declare=tipsig=333333 Declare=tipsigw=633333 Declare=focussig=040404 Declare=panup=0 +O$@

spectreworm_w_d6z.png: spectreworm.pov spectreworm.inc
	povray +a $(povoptspng) $< Declare=depth=6 Declare=zoomout=3 Declare=showall=1 Declare=wriggly=1 Declare=tipsig=333333 Declare=tipsigw=633333 Declare=focussig=550000 Declare=panup=0 +O$@

spectrehydra.png: spectrehydra.pov
	povray +a $(povoptspng) $< Declare=depth=5 Declare=zoomout=2.5 +O$@

spectrehydra_o.png: spectrehydra.pov
	povray +a $(povoptspng) $< Declare=depth=6 Declare=zoomout=5.5 +O$@

spectrehydra_z.png: spectrehydra.pov
	povray +a $(povoptspng) $< Declare=depth=5 Declare=zoomout=1.5 +O$@

spectrehydra_r.png: spectrehydra.pov
	povray +a $(povoptspng) $< Declare=depth=5 Declare=zoomout=2.5 Declare=rotworm=180 +O$@

spectrehydra2.png: spectrehydra.pov
	povray +a $(povoptspng) $< Declare=depth=5 Declare=zoomout=2.5 Declare=hydra2=1 +O$@

spectrehydra2_o.png: spectrehydra.pov
	povray +a $(povoptspng) $< Declare=depth=6 Declare=zoomout=5.5 Declare=hydra2=1 +O$@

spectrehydra2_z.png: spectrehydra.pov
	povray +a $(povoptspng) $< Declare=depth=5 Declare=zoomout=1.5 Declare=hydra2=1 +O$@

spectrehydra2_r.png: spectrehydra.pov
	povray +a $(povoptspng) $< Declare=depth=5 Declare=zoomout=2.5 Declare=hydra2=1 Declare=rotworm=180 +O$@

spectretripod.png: spectreworm.pov
	povray +a $(povoptspng) $< Declare=depth=5 Declare=zoomout=3 Declare=tipsig=33333 Declare=focussig=04040 Declare=tipsig2=63333 Declare=tailsig2=4043 +O$@

spectretripod_o.png: spectreworm.pov
	povray +a $(povoptspng) $< Declare=depth=5 Declare=zoomout=4.5 Declare=tipsig=33333 Declare=focussig=04040 Declare=tipsig2=63333 Declare=tailsig2=4043 +O$@

spectretripod_z.png: spectreworm.pov
	povray +a $(povoptspng) $< Declare=depth=5 Declare=zoomout=2.0 Declare=tipsig=33333 Declare=focussig=04040 Declare=tipsig2=63333 Declare=tailsig2=4043 +O$@

spectretripodw.png: spectreworm.pov
	povray +a $(povoptspng) $< Declare=depth=6 Declare=zoomout=3 Declare=tipsigw=333333 Declare=focussig=040404 Declare=tipsigw2=633333 Declare=tailsigw2=0 +O$@

spectretripodw_o.png: spectreworm.pov
	povray +a $(povoptspng) $< Declare=depth=6 Declare=zoomout=5 Declare=tipsigw=333333 Declare=focussig=040404 Declare=tipsigw2=633333 Declare=tailsigw2=0 +O$@

spectretripodw_z.png: spectreworm.pov
	povray +a $(povoptspng) $< Declare=depth=6 Declare=zoomout=2 Declare=tipsigw=333333 Declare=focussig=040404 Declare=tipsigw2=633333 Declare=tailsigw2=0 +O$@

spectrefractal.png: spectrebd.pov spectresubdivision.inc
	povray +a $(povoptspng) $< Declare=depth=7 Declare=bdthick=6 Declare=zoomout=6.7 Declare=panup=1 Declare=panright=0.5 Declare=ptsize=100 Declare=draw4ipoints=1 +O$@

mysticfractal.png: spectrebd.pov spectresubdivision.inc
	povray +a $(povoptspng) $< Declare=depth=7 Declare=bdthick=6 Declare=zoomout=6.7 Declare=panup=1 Declare=panright=0.5 Declare=ptsize=100 Declare=draw4points=1 Declare=SPid=0 +O$@

spectrefractalsub.png: spectrebd.pov spectresubdivision.inc
	povray +a $(povoptspng) $< Declare=depth=7 Declare=bdthick=6 Declare=zoomout=6.7 Declare=panup=1 Declare=panright=0.5 Declare=ptsize=100 Declare=subdivide=1 Declare=draw4points=1 Declare=subpoints=1 Declare=letters=1 +O$@


#
# Spectre inflation
#

spectreinflationfasi=1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
spectreinflation=$(spectreinflationfasi:%=spectreinflation_%.png)
spectreinflation_d2=$(spectreinflationfasi:%=spectreinflation_%_d2.png)
spectreinflation_d3=$(spectreinflationfasi:%=spectreinflation_%_d3.png)
spectreinflation_d4=$(spectreinflationfasi:%=spectreinflation_%_d4.png)
spectreinflationpngs: $(spectreinflation)
spectreinflationpngs_d2: $(spectreinflation_d2)
spectreinflationpngs_d3: $(spectreinflation_d3)
spectreinflationpngs_d4: $(spectreinflation_d4)

spectreinflationmotion=2 4 6 8
spectreinflationm=$(spectreinflationmotion:%=spectreinflation_8pre%.png)
spectreinflationm_d2=$(spectreinflationmotion:%=spectreinflation_8pre%_d2.png)
spectreinflationm_d3=$(spectreinflationmotion:%=spectreinflation_8pre%_d3.png)
spectreinflationm_d4=$(spectreinflationmotion:%=spectreinflation_8pre%_d4.png)
spectreinflationmpngs: $(spectreinflationm)
spectreinflationmpngs_d2: $(spectreinflationm_d2)
spectreinflationmpngs_d3: $(spectreinflationm_d3)
spectreinflationmpngs_d4: $(spectreinflationm_d4)

povoptsinfl = -D +a Declare=AspectWide=1 +W1280 +H720

$(spectreinflation):spectreinflation_%.png:spectreinflation.pov
	povray $(povoptsinfl) $< Declare=fase=$* +O$@

$(spectreinflation_d2):spectreinflation_%_d2.png:spectreinflation.pov
	povray $(povoptsinfl) $< Declare=depth=2 Declare=fase=$* +O$@

$(spectreinflation_d3):spectreinflation_%_d3.png:spectreinflation.pov
	povray $(povoptsinfl) $< Declare=depth=3 Declare=fase=$* +O$@

$(spectreinflation_d4):spectreinflation_%_d4.png:spectreinflation.pov
	povray $(povoptsinfl) $< Declare=depth=4 Declare=fase=$* +O$@

$(spectreinflationm):spectreinflation_8pre%.png:spectreinflation.pov
	povray $(povoptsinfl) $< Declare=fase=8 Declare=minterp=0.$* +O$@

$(spectreinflationm_d2):spectreinflation_8pre%_d2.png:spectreinflation.pov
	povray $(povoptsinfl) $< Declare=depth=2 Declare=fase=8 Declare=minterp=0.$* +O$@

$(spectreinflationm_d3):spectreinflation_8pre%_d3.png:spectreinflation.pov
	povray $(povoptsinfl) $< Declare=depth=3 Declare=fase=8 Declare=minterp=0.$* +O$@

$(spectreinflationm_d4):spectreinflation_8pre%_d4.png:spectreinflation.pov
	povray $(povoptsinfl) $< Declare=depth=4 Declare=fase=8 Declare=minterp=0.$* +O$@


$(hatholes): hathole_z%.png: hathole.pov
	povray $(povoptspng) $< Declare=depth=5 Declare=zoomout=$* +O$@

$(spectreholes): spectrehole_z%.png: spectrehole.pov
	povray $(povoptspng) $< Declare=depth=5 Declare=zoomout=$* +O$@

$(spectrehole2s): spectrehole2_z%.png: spectrehole2.pov
	povray $(povoptspng) $< Declare=depth=5 Declare=zoomout=$* +O$@

$(spectrehole2slices): spectrehole2slice_z%.png: spectrehole2.pov
	povray $(povoptspng) $< Declare=depth=5 Declare=zoomout=$* Declare=numsectors=1 Declare=mirror=1 +O$@

$(spectrehole2alts): spectrehole2alt_z%.png: spectrehole2.pov
	povray $(povoptspng) $< Declare=depth=5 Declare=zoomout=$* Declare=alt=1 +O$@

$(spectrehole2alt2s): spectrehole2alt2_z%.png: spectrehole2.pov
	povray $(povoptspng) $< Declare=depth=5 Declare=zoomout=$* Declare=alt=2 +O$@

$(spectreholepropellers): spectreholepropeller_z%.png: spectreworm.pov
	povray $(povoptspng) $< Declare=depth=5 Declare=zoomout=$* Declare=tipsig=33333 Declare=tailsig=4042 Declare=focussig=04040 Declare=tipsig2=63333 Declare=tailsig2=4045 Declare=tipsig3=4056 Declare=tailsig3=0 Declare=rotworm3=180 Declare=nocyl=1 +O$@

$(spectreholepropellerws): spectreholepropellerw_z%.png: spectreworm.pov
	povray $(povoptspng) $< Declare=depth=6 Declare=zoomout=$* Declare=focussig=040404 Declare=tipsigw=333333 Declare=tailsigw=40420 Declare=tipsigw2=633333 Declare=tailsigw2=40450 Declare=tipsigw3=40404 Declare=tailsigw3=0 Declare=rotwormw3=180 Declare=nocyl=1 Declare=HACK=1 +O$@

yellow_brick_road_topview01.png: yellow_brick_road.pov
	povray $(povoptspng) $< Declare=depth=4 Declare=topview=2 Declare=buildtheback=3 +O$@

yellow_brick_road_topview023.png: yellow_brick_road.pov
	povray $(povoptspng) $< Declare=depth=4 Declare=topview=3 Declare=buildtheback=3 +O$@

yellow_brick_road_3clusters.png: yellow_brick_road.pov
	povray $(povoptspng) $< Declare=depth=0 Declare=topview=1 Declare=buildtheback=3 Declare=zoom=1.8 +O$@

hex_brick_road_topview01.png: hex_brick_road.pov
	povray $(povoptspng) $< Declare=depth=4 Declare=topview=2 Declare=buildtheback=3 +O$@

hex_brick_road_topview023.png: hex_brick_road.pov
	povray $(povoptspng) $< Declare=depth=4 Declare=topview=3 Declare=buildtheback=3 +O$@

hex_brick_road_3clusters.png: hex_brick_road.pov
	povray $(povoptspng) $< Declare=depth=0 Declare=topview=1 Declare=buildtheback=3 Declare=zoom=1.8 +O$@

$(deflated_png_H7):einstein_H7_d%.png: einstein.pov shapes.inc subdivision.inc
	povray $(povoptspng) $< Declare=htile=7 Declare=depth=$* +O$@

$(deflated_png_H8):einstein_H8_d%.png: einstein.pov shapes.inc subdivision.inc
	povray $(povoptspng) $< Declare=htile=8 Declare=depth=$* +O$@

#
# HEXAGONAL TILES
#

$(deflated_png_hexH7):hexagon_H7_d%.png: hexagons.pov shapes.inc subdivision.inc
	povray $(povoptspng) $< Declare=htile=7 Declare=depth=$* +O$@

$(deflated_png_hexH8):hexagon_H8_d%.png: hexagons.pov shapes.inc subdivision.inc
	povray $(povoptspng) $< Declare=htile=8 Declare=depth=$* +O$@

#
# spectre
#

$(deflated_png_S):spectre_d%.png: spectre.pov shapes.inc spectresubdivision.inc
	povray $(povoptspng) $< Declare=SPid=1 Declare=depth=$* Declare=fig22=1 Declare=colors=-1 Declare=sfondobianco=1 +O$@

$(deflated_png_M):mystic_d%.png: spectre.pov shapes.inc spectresubdivision.inc
	povray $(povoptspng) $< Declare=SPid=0 Declare=depth=$* Declare=fig22=1 Declare=colors=-1 Declare=sfondobianco=1 +O$@

$(deflatedq_png_S):spectreq_d%.png: spectre.pov shapes.inc spectresubdivision.inc
	povray $(povoptspng) $< Declare=SPid=1 Declare=depth=$* Declare=quadrilateral=1 Declare=figA1=1 Declare=sfondobianco=1 +O$@

$(deflatedq_png_M):mysticq_d%.png: spectre.pov shapes.inc spectresubdivision.inc
	povray $(povoptspng) $< Declare=SPid=0 Declare=depth=$* Declare=quadrilateral=1 Declare=figA1=1 Declare=sfondobianco=1 +O$@


#
# mp4 animations
#

mp4lista=five_deflations five_deflations_ws yellow_brick_road5B yellow_brick_road_aug5B yellow_brick_road6 yellow_brick_road_aug6
mp4listb=yellow_brick_road_path0 yellow_brick_road_path1 yellow_brick_road_path2 yellow_brick_road_path3
mp4listc=yellow_brick_road_emerald yellow_brick_road_witch
mp4listd=spectre_deflations spectre_deflations_ws spectre_desert_walk5 spectre_desert_walk6
mp4liste=hexfive_deflations hexfive_deflations_ws hex_brick_road5B hex_brick_road_aug5B hex_brick_road6 hex_brick_road_aug6
mp4listf=hex_brick_road_emerald hex_brick_road_witch
mp4sipre1l=0.5 8.5 16.5
mp4sipre8l=7.5 15.5 23.5
mp4siprexl=$(mp4sipre1l) $(mp4sipre8l)
mp4listg=$(mp4siprexl:%=spectre_inflation_%) spectre_inflation

mp4list = $(mp4lista) $(mp4listb) $(mp4listc) $(mp4listd) $(mp4liste) $(mp4listf) $(mp4listg)

$(mp4list:%=%.mp4): %.mp4: frames/%/DONE
	ffmpeg -y -framerate 25 -pattern_type glob -i 'frames/$*/frame????.png' -c:v libx264 -pix_fmt yuv420p $@

mp4concatlist = yellow_brick_road_path01 yellow_brick_road_path023

povoptsani = -D +a Declare=AspectWide=1 +W1280 +H720 +ki0 +kfi0
povoptsROADS = Declare=ROADS=1 Declare=ROADSIGNS=1 Declare=CASTLES=1

frames/five_deflations/DONE: frames/%/DONE: five_deflations.pov
	povray $< $(povoptsani) +kf11 +kff2750 +Oframes/$*/frame
	for i in `seq 2751 2775`; do cp frames/$*/frame2750.png frames/$*/frame$${i}.png; done
	touch $@

frames/five_deflations_ws/DONE: frames/%/DONE: five_deflations.pov
	povray $< $(povoptsani) Declare=withscritta=1 +kf11 +kff2750 +Oframes/$*/frame
	for i in `seq 2751 2775`; do cp frames/$*/frame2750.png frames/$*/frame$${i}.png; done
	touch $@

frames/yellow_brick_road5B/DONE: frames/%/DONE: yellow_brick_road.pov
	povray $< $(povoptsani) Declare=depth=5 Declare=htile=8 +kf200 +kff5000 +Oframes/$*/frame
	for i in `seq 5001 5025`; do cp frames/$*/frame5000.png frames/$*/frame$${i}.png; done
	touch $@


frames/yellow_brick_road_aug5B/DONE: frames/%/DONE: yellow_brick_road.pov
	povray $< $(povoptsani) Declare=augmented=1 Declare=depth=5 Declare=htile=8 +kf200 +kff5000 +Oframes/$*/frame
	for i in `seq 5001 5025`; do cp frames/$*/frame5000.png frames/$*/frame$${i}.png; done
	touch $@

frames/yellow_brick_road6/DONE: frames/%/DONE: yellow_brick_road.pov
	povray $< $(povoptsani) Declare=depth=6 Declare=dofastforward=1 +kf124 +kff3100 +Oframes/$*/frame
	for i in `seq 3101 3125`; do cp frames/$*/frame3100.png frames/$*/frame$${i}.png; done
	touch $@

frames/yellow_brick_road_aug6/DONE: frames/%/DONE: yellow_brick_road.pov
	povray $< $(povoptsani) Declare=depth=6 Declare=augmented=1 Declare=dofastforward=1 +kf124 +kff3100 +Oframes/$*/frame
	for i in `seq 3101 3125`; do cp frames/$*/frame3100.png frames/$*/frame$${i}.png; done
	touch $@

frames/yellow_brick_road_emerald/DONE: frames/%/DONE: yellow_brick_road.pov
	povray $< $(povoptsani) Declare=depth=6 Declare=emeraldpath=1 +kf130 +kff3250 +Oframes/$*/frame
	for i in `seq 3251 3275`; do cp frames/$*/frame3250.png frames/$*/frame$${i}.png; done
	touch $@

frames/yellow_brick_road_witch/DONE: frames/%/DONE: yellow_brick_road.pov
	povray $< $(povoptsani) Declare=depth=6 Declare=witchpath=1 +kf148 +kff3700 +Oframes/$*/frame
	for i in `seq 3701 3725`; do cp frames/$*/frame3700.png frames/$*/frame$${i}.png; done
	touch $@

frames/yellow_brick_road_path0/DONE: frames/%/DONE: yellow_brick_road.pov
	povray $< $(povoptsani) Declare=depth=6 $(povoptsROADS) Declare=path=0 +kf66.4 +kff1660 +Oframes/$*/frame
	for i in `seq 1661 1685`; do cp frames/$*/frame1660.png frames/$*/frame$${i}.png; done
	touch $@

frames/yellow_brick_road_path1/DONE: frames/%/DONE: yellow_brick_road.pov
	povray $< $(povoptsani) Declare=depth=6 $(povoptsROADS) Declare=path=1 +kf104.2 +kff2605 +Oframes/$*/frame
	for i in `seq 2606 2630`; do cp frames/$*/frame2605.png frames/$*/frame$${i}.png; done
	touch $@

frames/yellow_brick_road_path2/DONE: frames/%/DONE: yellow_brick_road.pov
	povray $< $(povoptsani) Declare=depth=6 $(povoptsROADS) Declare=path=2 +kf66.4 +kff1660 +Oframes/$*/frame
	for i in `seq 1661 1685`; do cp frames/$*/frame1660.png frames/$*/frame$${i}.png; done
	touch $@

frames/yellow_brick_road_path3/DONE: frames/%/DONE: yellow_brick_road.pov
	povray $< $(povoptsani) Declare=depth=6 $(povoptsROADS) Declare=path=3 +kf104.2 +kff2605 +Oframes/$*/frame
	for i in `seq 2606 2630`; do cp frames/$*/frame2605.png frames/$*/frame$${i}.png; done
	touch $@

frames/spectre_deflations/DONE: frames/%/DONE: spectre_deflations.pov
	povray $< $(povoptsani) +kf11 +kff2750 +Oframes/$*/frame
	for i in `seq 2751 2775`; do cp frames/$*/frame2750.png frames/$*/frame$${i}.png; done
	touch $@

frames/spectre_deflations_ws/DONE: frames/%/DONE: spectre_deflations.pov
	povray $< $(povoptsani) Declare=withscritta=1 +kf11 +kff2750 +Oframes/$*/frame
	for i in `seq 2751 2775`; do cp frames/$*/frame2750.png frames/$*/frame$${i}.png; done
	touch $@

frames/spectre_desert_walk5/DONE: frames/%/DONE: spectre_desert_walk.pov
	povray $< $(povoptsani) Declare=desertlike=10 Declare=depth=5 +kf120 +kff3000 +Oframes/$*/frame
	for i in `seq 3001 3025`; do cp frames/$*/frame3000.png frames/$*/frame$${i}.png; done
	touch $@

frames/spectre_desert_walk6/DONE: frames/%/DONE: spectre_desert_walk.pov
	povray $< $(povoptsani) Declare=desertlike=10 Declare=depth=6 +kf120 +kff3000 +Oframes/$*/frame
	for i in `seq 3001 3025`; do cp frames/$*/frame3000.png frames/$*/frame$${i}.png; done
	touch $@

$(mp4concatlist:%=%.mp4): %.mp4: %.list yellow_brick_road_path0.mp4 yellow_brick_road_path1.mp4 yellow_brick_road_path2.mp4 yellow_brick_road_path3.mp4
	ffmpeg -f concat -safe 0 -i $< -c copy $@

#frames/yellow_brick_road_aug6/DONE: yellow_brick_road.pov
#	povray -D +a $< Declare=AspectWide=1 Declare=depth=6 Declare=augmented=1 +W1280 +H720 +ki0 +kf164 +kfi0 +kff4100 +Oframes/yellow_brick_road_aug6/frame
#	for i in `seq 4101 4125`; do cp frames/yellow_brick_road_aug6/frame4100.png frames/yellow_brick_road_aug6/frame$${i}.png; done
#	touch frames/yellow_brick_road_aug6/DONE

# comando di concatenazione, se serve:
#	ffmpeg -f concat -safe 0 -i subdivisionlist.txt -c copy subdivision.mp4

#frames:
#	mkdir -p $@
#
#$(mp4list:%=frames/%): frames/%: frames
#	mkdir -p $@

#
# HEXAGONS
#
frames/hexfive_deflations/DONE: frames/%/DONE: hexfive_deflations.pov
	povray $< $(povoptsani) +kf11 +kff2750 +Oframes/$*/frame
	for i in `seq 2751 2775`; do cp frames/$*/frame2750.png frames/$*/frame$${i}.png; done
	touch $@

frames/hexfive_deflations_ws/DONE: frames/%/DONE: hexfive_deflations.pov
	povray $< $(povoptsani) Declare=withscritta=1 +kf11 +kff2750 +Oframes/$*/frame
	for i in `seq 2751 2775`; do cp frames/$*/frame2750.png frames/$*/frame$${i}.png; done
	touch $@
#
# Doroty on the 'hexagonal' land of Oz
#
frames/hex_brick_road5B/DONE: frames/%/DONE: hex_brick_road.pov
	povray $< $(povoptsani) Declare=depth=5 Declare=htile=8 +kf200 +kff5000 +Oframes/$*/frame
	for i in `seq 5001 5025`; do cp frames/$*/frame5000.png frames/$*/frame$${i}.png; done
	touch $@


frames/hex_brick_road_aug5B/DONE: frames/%/DONE: hex_brick_road.pov
	povray $< $(povoptsani) Declare=augmented=1 Declare=depth=5 Declare=htile=8 +kf200 +kff5000 +Oframes/$*/frame
	for i in `seq 5001 5025`; do cp frames/$*/frame5000.png frames/$*/frame$${i}.png; done
	touch $@

frames/hex_brick_road6/DONE: frames/%/DONE: hex_brick_road.pov
	povray $< $(povoptsani) Declare=depth=6 Declare=dofastforward=1 +kf124 +kff3100 +Oframes/$*/frame
	for i in `seq 3101 3125`; do cp frames/$*/frame3100.png frames/$*/frame$${i}.png; done
	touch $@

frames/hex_brick_road_aug6/DONE: frames/%/DONE: hex_brick_road.pov
	povray $< $(povoptsani) Declare=depth=6 Declare=augmented=1 Declare=dofastforward=1 +kf124 +kff3100 +Oframes/$*/frame
	for i in `seq 3101 3125`; do cp frames/$*/frame3100.png frames/$*/frame$${i}.png; done
	touch $@

frames/hex_brick_road_path0/DONE: frames/%/DONE: hex_brick_road.pov
	povray $< $(povoptsani) Declare=depth=6 $(povoptsROADS) Declare=path=0 +kf66.4 +kff1660 +Oframes/$*/frame
	for i in `seq 1661 1685`; do cp frames/$*/frame1660.png frames/$*/frame$${i}.png; done
	touch $@

frames/hex_brick_road_path1/DONE: frames/%/DONE: hex_brick_road.pov
	povray $< $(povoptsani) Declare=depth=6 $(povoptsROADS) Declare=path=1 +kf104.2 +kff2605 +Oframes/$*/frame
	for i in `seq 2606 2630`; do cp frames/$*/frame2605.png frames/$*/frame$${i}.png; done
	touch $@

frames/hex_brick_road_path2/DONE: frames/%/DONE: hex_brick_road.pov
	povray $< $(povoptsani) Declare=depth=6 $(povoptsROADS) Declare=path=2 +kf66.4 +kff1660 +Oframes/$*/frame
	for i in `seq 1661 1685`; do cp frames/$*/frame1660.png frames/$*/frame$${i}.png; done
	touch $@

frames/hex_brick_road_path3/DONE: frames/%/DONE: hex_brick_road.pov
	povray $< $(povoptsani) Declare=depth=6 $(povoptsROADS) Declare=path=3 +kf104.2 +kff2605 +Oframes/$*/frame
	for i in `seq 2606 2630`; do cp frames/$*/frame2605.png frames/$*/frame$${i}.png; done
	touch $@

frames/hex_brick_road_emerald/DONE: frames/%/DONE: hex_brick_road.pov
	povray $< $(povoptsani) Declare=depth=6 Declare=emeraldpath=1 +kf130 +kff3250 +Oframes/$*/frame
	for i in `seq 3251 3275`; do cp frames/$*/frame3250.png frames/$*/frame$${i}.png; done
	touch $@

frames/hex_brick_road_witch/DONE: frames/%/DONE: hex_brick_road.pov
	povray $< $(povoptsani) Declare=depth=6 Declare=witchpath=1 +kf148 +kff3700 +Oframes/$*/frame
	for i in `seq 3701 3725`; do cp frames/$*/frame3700.png frames/$*/frame$${i}.png; done
	touch $@

#
# spectre inflation animation of the assembly
#

#mp4sipre1l=0.5 8.5 16.5
#mp4sipre8l=7.5 15.5 23.5
#mp4siprexl=$(mp4sipre1l) $(mp4sipre8l)
#mp4listg=$(mp4siprexl:spectre_inflation_%)

#spectre_inflation_pre8l=7.5 15.5 23.5
spectre_inflation_pre8=$(mp4sipre8l:%=spectre_inflation_%.mp4)
spectre_inflation_pre8_mp4=$(spectre_inflation_pre8)

framessipre1=$(mp4sipre1l:%=frames/spectre_inflation_%/DONE)

frames/spectre_inflation_0.5/DONE: frames/%/DONE: spectreinflation.pov
	povray $< $(povoptsani) Declare=fase=0.5 +ki0 +kf1 +kff60 +Oframes/$*/frame00
	for i in `seq 61 85`; do cp frames/$*/frame0060.png frames/$*/frame00$${i}.png; done
	touch $@

frames/spectre_inflation_8.5/DONE: frames/%/DONE: spectreinflation.pov
	povray $< $(povoptsani) Declare=fase=8.5 +ki0 +kf1 +kff60 +Oframes/$*/frame00
	for i in `seq 61 85`; do cp frames/$*/frame0060.png frames/$*/frame00$${i}.png; done
	touch $@

frames/spectre_inflation_16.5/DONE: frames/%/DONE: spectreinflation.pov
	povray $< $(povoptsani) Declare=fase=16.5 +ki0 +kf1 +kff60 +Oframes/$*/frame00
	for i in `seq 61 85`; do cp frames/$*/frame0060.png frames/$*/frame00$${i}.png; done
	touch $@


frames/spectre_inflation_7.5/DONE: frames/%/DONE: spectreinflation.pov
	povray $< $(povoptsani) Declare=fase=7.5 +ki0 +kf1 +kff120 +Oframes/$*/frame0
	for i in `seq 121 145`; do cp frames/$*/frame0120.png frames/$*/frame0$${i}.png; done
	touch $@

frames/spectre_inflation_15.5/DONE: frames/%/DONE: spectreinflation.pov
	povray $< $(povoptsani) Declare=fase=15.5 +ki0 +kf1 +kff120 +Oframes/$*/frame0
	for i in `seq 121 145`; do cp frames/$*/frame0120.png frames/$*/frame0$${i}.png; done
	touch $@

frames/spectre_inflation_23.5/DONE: frames/%/DONE: spectreinflation.pov
	povray $< $(povoptsani) Declare=fase=23.5 +ki0 +kf1 +kff120 +Oframes/$*/frame0
	for i in `seq 121 145`; do cp frames/$*/frame0120.png frames/$*/frame0$${i}.png; done
	touch $@

frames/spectre_inflation/DONE: frames/%/DONE: spectreinflation.pov
	povray $< $(povoptsani) Declare=animate=2 +kf152 +kff3800 +Oframes/$*/frame
	touch $@
