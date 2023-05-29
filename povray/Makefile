
depths = 0 1 2 3 4 5 6
deflated_suf = $(depths:%=H7_%) $(depths:%=H8_%)

deflated_png_H7 = $(depths:%=einstein_H7_d%.png)
deflated_png_H8 = $(depths:%=einstein_H8_d%.png)

all:$(deflated_png_H7) $(deflated_png_H8)

$(deflated_png_H7):einstein_H7_d%.png: einstein.pov shapes.inc subdivision.inc
	povray +a -D $< Declare=htile=7 Declare=depth=$* +O$@

$(deflated_png_H8):einstein_H8_d%.png: einstein.pov shapes.inc subdivision.inc
	povray +a -D $< Declare=htile=8 Declare=depth=$* +O$@

mp4list=five_deflations five_deflations_ws yellow_brick_road yellow_brick_road_aug

$(mp4list:%=%.mp4): %.mp4: frames/%/frame0000.png
	ffmpeg -y -framerate 25 -pattern_type glob -i 'frames/$*/frame????.png' -c:v libx264 -pix_fmt yuv420p $@

frames/five_deflations/frame0000.png: five_deflations.pov
	povray -D +a five_deflations.pov Declare=AspectWide=1 +W1280 +H720 +ki0 +kf11 +kfi0 +kff2750 +Oframes/five_deflations/frame

frames/yellow_brick_road/frame0000.png: yellow_brick_road.pov
	povray -D +a $< Declare=AspectWide=1 +W1280 +H720 +ki0 +kf200 +kfi0 +kff5000 +Oframes/yellow_brick_road/frame
	for i in `seq 5001 5025`; do cp frames/yellow_brick_road/frame5000.png frames/yellow_brick_road/frame$${i}.png; done

frames/yellow_brick_road_aug/frame0000.png: yellow_brick_road.pov
	povray -D +a $< Declare=AspectWide=1 Declare=augmented=1 +W1280 +H720 +ki0 +kf200 +kfi0 +kff5000 +Oframes/yellow_brick_road_aug/frame
	for i in `seq 5001 5025`; do cp frames/yellow_brick_road_aug/frame5000.png frames/yellow_brick_road_aug/frame$${i}.png; done

#five_deflations_ws.mp4: frames/five_deflations_ws/frame0000.png
#	ffmpeg -y -framerate 25 -pattern_type glob -i 'frames/five_deflations_ws/five_deflations????.png' -c:v libx264 -pix_fmt yuv420p $@

frames/five_deflations_ws/frame0000.png: five_deflations.pov frames/five_deflations_ws
	povray -D +a five_deflations.pov Declare=AspectWide=1 Declare=withscritta=1 +W1280 +H720 +ki0 +kf11 +kfi0 +kff2750 +Oframes/five_deflations_ws/frame

# comando di concatenazione, se serve:
#	ffmpeg -f concat -safe 0 -i subdivisionlist.txt -c copy subdivision.mp4

#frames:
#	mkdir -p $@
#
#$(mp4list:%=frames/%): frames/%: frames
#	mkdir -p $@

