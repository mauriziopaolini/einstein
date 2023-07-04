
depthsH78 = 0 1 2 3 4 5 6
deflated_suf = $(depthsH78:%=H7_%) $(depthsH78:%=H8_%)

deflated_png_H7 = $(depthsH78:%=einstein_H7_d%.png)
deflated_png_H8 = $(depthsH78:%=einstein_H8_d%.png)

depthsSM = 0 1 2 3 4 5 6
deflated_png_S = $(depthsSM:%=spectre_d%.png)
deflated_png_M = $(depthsSM:%=mystic_d%.png)
deflatedq_png_S = $(depthsSM:%=spectreq_d%.png)
deflatedq_png_M = $(depthsSM:%=mysticq_d%.png)

hatsignatures=[0] [2] [6] [602] [026] [260] [1] [3] [4] [5]
hatsigpngd6=${hatsignatures:%=hatconwaysig%_d6.png}
hatsigpngd6z=${hatsignatures:%=hatconwaysig%_d6z.png}
hatsigpngd7z=${hatsignatures:%=hatconwaysig%_d7z.png}

hatsigsd6: $(hatsigpngd6) hatconwaysig[5][5]_d6.png hatconwaysig[0][6]_d6.png
hatsigsd6z: $(hatsigpngd6z) hatconwaysig[5][5]_d6z.png hatconwaysig[0][6]_d6z.png

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

hatconwaysig[0][6]_d6z.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=up2=60 Declare=down2=26 Declare=depth=6 Declare=zoomout=4 +Otmp_pippoz.png
	mv tmp_pippoz.png $@

hatconwaysig[0][6]_d6.png: hatconwaysig.pov
	povray $(povoptspng) $< Declare=Sigh=000000 Declare=Sigl=000000 Declare=Sigh2=666666 Declare=Sigl2=666666 Declare=up2=60 Declare=down2=26 Declare=depth=6 Declare=zoomout=6 +Otmp_pippo.png
	mv tmp_pippo.png $@

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

yellow_brick_road_topview01.png: yellow_brick_road.pov
	povray $(povoptspng) $< Declare=depth=4 Declare=topview=2 Declare=buildtheback=1 +O$@

yellow_brick_road_topview023.png: yellow_brick_road.pov
	povray $(povoptspng) $< Declare=depth=4 Declare=topview=3 Declare=buildtheback=1 +O$@

yellow_brick_road_3clusters.png: yellow_brick_road.pov
	povray $(povoptspng) $< Declare=depth=0 Declare=topview=1 Declare=buildtheback=1 Declare=zoom=1.8 +O$@

$(deflated_png_H7):einstein_H7_d%.png: einstein.pov shapes.inc subdivision.inc
	povray $(povoptspng) $< Declare=htile=7 Declare=depth=$* +O$@

$(deflated_png_H8):einstein_H8_d%.png: einstein.pov shapes.inc subdivision.inc
	povray $(povoptspng) $< Declare=htile=8 Declare=depth=$* +O$@

$(deflated_png_S):spectre_d%.png: spectre.pov shapes.inc spectresubdivision.inc
	povray $(povoptspng) $< Declare=SPid=1 Declare=depth=$* Declare=fig22=1 +O$@

$(deflated_png_M):mystic_d%.png: spectre.pov shapes.inc spectresubdivision.inc
	povray $(povoptspng) $< Declare=SPid=0 Declare=depth=$* Declare=fig22=1 +O$@

$(deflatedq_png_S):spectreq_d%.png: spectre.pov shapes.inc spectresubdivision.inc
	povray $(povoptspng) $< Declare=SPid=1 Declare=depth=$* Declare=quadrilateral=1 Declare=figA1=1 +O$@

$(deflatedq_png_M):mysticq_d%.png: spectre.pov shapes.inc spectresubdivision.inc
	povray $(povoptspng) $< Declare=SPid=0 Declare=depth=$* Declare=quadrilateral=1 Declare=figA1=1 +O$@


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

