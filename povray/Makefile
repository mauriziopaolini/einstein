
depths = 0 1 2 3 4 5 6
deflated_suf = $(depths:%=H7_%) $(depths:%=H8_%)

deflated_png_H7 = $(depths:%=einstein_H7_d%.png)
deflated_png_H8 = $(depths:%=einstein_H8_d%.png)

all:$(deflated_png_H7) $(deflated_png_H8)

$(deflated_png_H7):einstein_H7_d%.png: einstein.pov shapes.inc subdivision.inc
	povray +a -D $< Declare=htile=7 Declare=depth=$* +O$@

$(deflated_png_H8):einstein_H8_d%.png: einstein.pov shapes.inc subdivision.inc
	povray +a -D $< Declare=htile=8 Declare=depth=$* +O$@

mp4list=five_deflations yellow_brick_road

$(mp4list:%=%.mp4): %.mp4: frames/%/frame0000.png
	ffmpeg -y -framerate 25 -pattern_type glob -i 'frames/$*/frame????.png' -c:v libx264 -pix_fmt yuv420p $@

#five_deflations.mp4: frames/five_deflations/five_deflations0000.png
#	ffmpeg -y -framerate 25 -pattern_type glob -i 'frames/five_deflations/five_deflations????.png' -c:v libx264 -pix_fmt yuv420p $@

frames/five_deflations/frame0000.png: five_deflations.pov frames/five_deflations
	povray -D +a five_deflations.pov Declare=AspectWide=1 +W1280 +H720 +ki0 +kf11 +kfi0 +kff2750 +Oframes/five_deflations/frame

frames/yellow_brick_road/frame0000.png: yellow_brick_road.pov frames/yellow_brick_road
	povray -D +a $< Declare=AspectWide=1 +W1280 +H720 +ki0 +kf200 +kfi0 +kff5000 +Oframes/yellow_brick_road/frame
#	povray -D +a $< Declare=AspectWide=1 +W1280 +H720 +ki0 +kf10 +kfi0 +kff250 +Oframes/yellow_brick_road/frame0
#	povray -D +a $< Declare=AspectWide=1 +W1280 +H720 +ki0 +kf100 +kfi0 +kff2500 +Oframes/yellow_brick_road/frame

five_deflations_ws.mp4: frames/five_deflations_ws/frame0000.png
	ffmpeg -y -framerate 25 -pattern_type glob -i 'frames/five_deflations_ws/five_deflations????.png' -c:v libx264 -pix_fmt yuv420p $@

frames/five_deflations_ws/five_deflations0000.png: five_declarions.pov frames/five_deflations_ws
	povray -D +a five_deflations.pov Declare=AspectWide=1 Declare=withscritta=1 +W1280 +H720 +ki0 +kf11 +kfi0 +kff2750 +Oframes/five_deflations_ws/frame

# comando di concatenazione, se serve:
#	ffmpeg -f concat -safe 0 -i subdivisionlist.txt -c copy subdivision.mp4

frames:
	mkdir $@

frames/five_deflations: frames
	mkdir $@

frames/five_deflations_ws: frames
	mkdir $@

