
depths = 0 1 2 3 4 5 6
deflated_suf = $(depths:%=H7_%) $(depths:%=H8_%)

deflated_png_H7 = $(depths:%=einstein_H7_d%.png)
deflated_png_H8 = $(depths:%=einstein_H8_d%.png)

all:$(deflated_png_H7) $(deflated_png_H8)

$(deflated_png_H7):einstein_H7_d%.png: einstein.pov shapes.inc subdivision.inc
	povray +a -D $< Declare=htile=7 Declare=depth=$* +O$@

$(deflated_png_H8):einstein_H8_d%.png: einstein.pov shapes.inc subdivision.inc
	povray +a -D $< Declare=htile=8 Declare=depth=$* +O$@

subdivision.mp4: frames/subdivision/subdivision0000.png
	ffmpeg -y -framerate 25 -pattern_type glob -i 'frames/subdivision/subdivision????.png' -c:v libx264 -pix_fmt yuv420p $@

frames/subdivision/subdivision0000.png: subdivision.pov frames/subdivision
	povray -D +a subdivision.pov Declare=AspectWide=1 +W1280 +H720 +ki0 +kf10.5 +kfi0 +kff2625 +Oframes/subdivision/

subdivision_ws.mp4: frames/subdivision_ws/subdivision0000.png
	ffmpeg -y -framerate 25 -pattern_type glob -i 'frames/subdivision_ws/subdivision????.png' -c:v libx264 -pix_fmt yuv420p $@

frames/subdivision_ws/subdivision0000.png: subdivision.pov frames/subdivision_ws
	povray -D +a subdivision.pov Declare=AspectWide=1 Declare=withscritta=1 +W1280 +H720 +ki0 +kf10.5 +kfi0 +kff2625 +Oframes/subdivision_ws/

# comando di concatenazione, se serve:
#	ffmpeg -f concat -safe 0 -i subdivisionlist.txt -c copy subdivision.mp4

frames:
	mkdir $@

frames/subdivision: frames
	mkdir $@

frames/subdivision_ws: frames
	mkdir $@

#
# obsoleted...
#
dirs = $(depths:%=frames/subdivision_d%)
frames000 = $(dirs:%=%/subdivision000.png)

$(dirs):frames/subdivision_d%: frames
	mkdir $@

$(frames000):frames/subdivision_d%/subdivision000.png: subdivision.pov frames/subdivision_d%
	povray -D +a subdivision.pov Declare=AspectWide=1 Declare=depth=$* +W1280 +H720 +ki0 +kf2 +kfi0 +kff500 +Oframes/subdivision_d$*/

subdepths = 0 1 2 3 4

