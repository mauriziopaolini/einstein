
depthsH78 = 0 1 2 3 4 5 6
deflated_suf = $(depthsH78:%=H7_%) $(depthsH78:%=H8_%)

deflated_png_H7 = $(depthsH78:%=einstein_H7_d%.png)
deflated_png_H8 = $(depthsH78:%=einstein_H8_d%.png)

depthsSM = 0 1 2 3 4 5 6
deflated_png_S = $(depthsSM:%=spectre_d%.png)
deflated_png_M = $(depthsSM:%=mystic_d%.png)
deflatedq_png_S = $(depthsSM:%=spectreq_d%.png)
deflatedq_png_M = $(depthsSM:%=mysticq_d%.png)

#
# CONWAY SIGNATURES: HAT
#

hatsignatures=[0] [2] [6] [602] [026] [260] [1] [3] [4] [5]
hatsigpngd6=${hatsignatures:%=hatconwaysig%_d6.png}
hatsigpngd6z=${hatsignatures:%=hatconwaysig%_d6z.png}
hatsigpngd6zz=${hatsignatures:%=hatconwaysig%_d6zz.png}

hatsigsd6: $(hatsigpngd6) hatconwaysig[5][5]_d6.png hatconwaysig[0][6]_d6.png hatconwaysig[0][6]bis_d6.png hatconwaysig[0][6][6]_d6.png
hatsigsd6z: $(hatsigpngd6z) hatconwaysig[5][5]_d6z.png hatconwaysig[0][6]_d6z.png hatconwaysig[0][6]_d6z.png hatconwaysig[0][6][6]_d6z.png
hatsigsd6zz: $(hatsigpngd6zz) hatconwaysig[5][5]_d6zz.png hatconwaysig[0][6]_d6zz.png hatconwaysig[0][6]_d6zz.png hatconwaysig[0][6][6]_d6zz.png

hatholezlevels=1 2 3 4 5
hatholes=$(hatholezlevels:%=hathole_z%.png)
hatholepngs: $(hatholes)

#
# CONWAY SIGNATURES: SPECTRE
#

spectresignatures=[0] [1] [2] [3] [4] [5] [6] [7]
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
spectreholepngs: $(spectreholes) $(spectrehole2s) $(spectrehole2slices) $(spectrehole2alts)

#
#
#

yellowtopviews = yellow_brick_road_topview01 yellow_brick_road_topview023 yellow_brick_road_3clusters
paths=01 023

allH78 = $(deflated_png_H7) $(deflated_png_H8)
allSM = $(deflated_png_S) $(deflated_png_M) $(deflatedq_png_S) $(deflatedq_png_M)

all: $(allH78) $(allSM)
allchiral: $(allSM)

#
# png images
#

povoptspng = -D +a +W1024 +H768

hatnumbers.png: einstein.pov
	povray -D $< Declare=numbers=1 Declare=arrow=1 +O$@

spectrenumbers.png: spectre.pov
	povray -D $< Declare=numbers=1 +O$@

#
# HAT SIGNATURES
#

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
# SPECTRE SIGNATURES
#

spectreconwaysig[5][3]_d6.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=555555 Declare=Sigl=555555 Declare=Sigh2=333333 Declare=Sigl2=333333 Declare=up2=05 Declare=down2=27 Declare=depth=6 Declare=zoomout=6 +Otmp_pippo.png
	mv tmp_pippo.png $@

spectreconwaysig[5][3]_d6z.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=555555 Declare=Sigl=555555 Declare=Sigh2=333333 Declare=Sigl2=333333 Declare=up2=05 Declare=down2=27 Declare=depth=6 Declare=zoomout=4 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

spectreconwaysig[5][3]_d6zz.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=555555 Declare=Sigl=555555 Declare=Sigh2=333333 Declare=Sigl2=333333 Declare=up2=05 Declare=down2=27 Declare=depth=6 Declare=zoomout=2 +Otmp_pippozz.png
	mv tmp_pippozz.png $@

#
# the same tiling can be obtained with the choices
# up2=05 down2=27
# up2=07 down2=17
# up2=22 down2=47
# up2=24 down2=37
# up2=52 down2=77
# up2=54 down2=67
#

spectreconwaysig[1][1]_d6.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=111111 Declare=Sigl=111111 Declare=Sigh2=111111 Declare=Sigl2=111111 Declare=up2=04 Declare=down2=27 Declare=depth=6 Declare=zoomout=6 +Otmp_pippo.png
	mv tmp_pippo.png $@

spectreconwaysig[1][1]_d6z.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=111111 Declare=Sigl=111111 Declare=Sigh2=111111 Declare=Sigl2=111111 Declare=up2=04 Declare=down2=27 Declare=depth=6 Declare=zoomout=4 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

spectreconwaysig[1][1]_d6zz.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=111111 Declare=Sigl=111111 Declare=Sigh2=111111 Declare=Sigl2=111111 Declare=up2=04 Declare=down2=27 Declare=depth=6 Declare=zoomout=2 +Otmp_pippozz.png
	mv tmp_pippozz.png $@

spectreconwaysig[0][3][3]_d6.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=333333 Declare=Sigl2=333333 Declare=Sigh3=333333 Declare=Sigl3=333333 Declare=up2=03 Declare=down2=02 Declare=up3=10 Declare=down3=06 Declare=depth=6 Declare=zoomout=6 +Otmp_pippo.png
	mv tmp_pippo.png $@

spectreconwaysig[0][3][3]_d6z.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=333333 Declare=Sigl2=333333 Declare=Sigh3=333333 Declare=Sigl3=333333 Declare=up2=03 Declare=down2=02 Declare=up3=10 Declare=down3=06 Declare=depth=6 Declare=zoomout=4 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

spectreconwaysig[0][3][3]_d6zz.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=333333 Declare=Sigl2=333333 Declare=Sigh3=333333 Declare=Sigl3=333333 Declare=up2=03 Declare=down2=02 Declare=up3=10 Declare=down3=06 Declare=depth=6 Declare=zoomout=2 +Otmp_pippozz.png
	mv tmp_pippozz.png $@

spectreconwaysig[6][6][6]_d6.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=666666 Declare=Sigl=666666 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=Sigh3=666666 Declare=Sigl3=666666 Declare=up2=06 Declare=down2=27 Declare=up3=01 Declare=down3=71 Declare=depth=6 Declare=zoomout=6 +O- >$@

spectreconwaysig[6][6][6]_d6z.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=666666 Declare=Sigl=666666 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=Sigh3=666666 Declare=Sigl3=666666 Declare=up2=06 Declare=down2=27 Declare=up3=01 Declare=down3=71 Declare=depth=6 Declare=zoomout=4 +O- >$@

spectreconwaysig[6][6][6]_d6zz.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=666666 Declare=Sigl=666666 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=Sigh3=666666 Declare=Sigl3=666666 Declare=up2=06 Declare=down2=27 Declare=up3=01 Declare=down3=71 Declare=depth=6 Declare=zoomout=2 +O- >$@

spectreconwaysig[4][4][4]_d6.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=444444 Declare=Sigl=444444 Declare=Sigh2=444444 Declare=Sigl2=444444 Declare=Sigh3=444444 Declare=Sigl3=444444 Declare=up2=05 Declare=down2=27 Declare=up3=17 Declare=down3=07 Declare=depth=6 Declare=zoomout=6 +O- >$@

spectreconwaysig[4][4][4]_d6z.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=444444 Declare=Sigl=444444 Declare=Sigh2=444444 Declare=Sigl2=444444 Declare=Sigh3=444444 Declare=Sigl3=444444 Declare=up2=05 Declare=down2=27 Declare=up3=17 Declare=down3=07 Declare=depth=6 Declare=zoomout=4 +O- >$@

spectreconwaysig[4][4][4]_d6zz.png: spectreconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=444444 Declare=Sigl=444444 Declare=Sigh2=444444 Declare=Sigl2=444444 Declare=Sigh3=444444 Declare=Sigl3=444444 Declare=up2=05 Declare=down2=27 Declare=up3=17 Declare=down3=07 Declare=depth=6 Declare=zoomout=2 +O- >$@

$(spectresigpngd6):spectreconwaysig%_d6.png:spectreconwaysig.pov spectresig2povopt.sh
	./spectresig2povopt.sh -q $* povray Declare=depth=6 $(povoptspng) +O- >$@

$(spectresigpngd6z):spectreconwaysig%_d6z.png:spectreconwaysig.pov spectresig2povopt.sh
	./spectresig2povopt.sh -q $* povray Declare=depth=6 Declare=zoomout=4 $(povoptspng) +O- >$@

$(spectresigpngd6zz):spectreconwaysig%_d6zz.png:spectreconwaysig.pov spectresig2povopt.sh
	./spectresig2povopt.sh -q $* povray Declare=depth=6 Declare=zoomout=2 $(povoptspng) +O- >$@

#
#
#

$(hatholes): hathole_z%.png: hathole.pov
	povray $(povoptspng) $< Declare=depth=5 Declare=zoomout=$* +O$@

$(spectreholes): spectrehole_z%.png: spectrehole.pov
	povray $(povoptspng) $< Declare=depth=5 Declare=zoomout=$* +O$@

$(spectrehole2s): spectrehole2_z%.png: spectrehole2.pov
	povray $(povoptspng) $< Declare=depth=5 Declare=zoomout=$* +O$@

$(spectrehole2slices): spectrehole2slice_z%.png: spectrehole2.pov
	povray $(povoptspng) $< Declare=depth=5 Declare=zoomout=$* Declare=numsectors=1 +O$@

$(spectrehole2alts): spectrehole2alt_z%.png: spectrehole2.pov
	povray $(povoptspng) $< Declare=depth=5 Declare=zoomout=$* Declare=alt=1 +O$@

yellow_brick_road_topview01.png: yellow_brick_road.pov
	povray $(povoptspng) $< Declare=depth=4 Declare=topview=2 Declare=buildtheback=3 +O$@

yellow_brick_road_topview023.png: yellow_brick_road.pov
	povray $(povoptspng) $< Declare=depth=4 Declare=topview=3 Declare=buildtheback=3 +O$@

yellow_brick_road_3clusters.png: yellow_brick_road.pov
	povray $(povoptspng) $< Declare=depth=0 Declare=topview=1 Declare=buildtheback=3 Declare=zoom=1.8 +O$@

$(deflated_png_H7):einstein_H7_d%.png: einstein.pov shapes.inc subdivision.inc
	povray $(povoptspng) $< Declare=htile=7 Declare=depth=$* +O$@

$(deflated_png_H8):einstein_H8_d%.png: einstein.pov shapes.inc subdivision.inc
	povray $(povoptspng) $< Declare=htile=8 Declare=depth=$* +O$@

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

mp4list = $(mp4lista) $(mp4listb) $(mp4listc) $(mp4listd)

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
	povray $< $(povoptsani) Declare=depth=5 +kf120 +kff3000 +Oframes/$*/frame
	for i in `seq 3001 3025`; do cp frames/$*/frame3000.png frames/$*/frame$${i}.png; done
	touch $@

frames/spectre_desert_walk6/DONE: frames/%/DONE: spectre_desert_walk.pov
	povray $< $(povoptsani) Declare=depth=6 +kf120 +kff3000 +Oframes/$*/frame
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

