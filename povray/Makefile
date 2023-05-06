
depths = 0 1 2 3 4 5 6
deflated_suf = $(depths:%=H7_%) $(depths:%=H8_%)

deflated_png_H7 = $(depths:%=einstein_H7_d%.png)
deflated_png_H8 = $(depths:%=einstein_H8_d%.png)

all:$(deflated_png_H7) $(deflated_png_H8)

$(deflated_png_H7):einstein_H7_d%.png: einstein.pov shapes.inc subdivision.inc
	povray +a -D $< Declare=htile=7 Declare=depth=$* +O$@

$(deflated_png_H8):einstein_H8_d%.png: einstein.pov shapes.inc subdivision.inc
	povray +a -D $< Declare=htile=8 Declare=depth=$* +O$@

#subdivision_frames: frames/subdivision/subdivision000.png

frames:
	mkdir $@

dirs = $(depths:%=frames/subdivision_d%)
frames000 = $(dirs:%=%/subdivision000.png)

$(dirs):frames/subdivision_d%: frames
	mkdir $@

$(frames000):frames/subdivision_d%/subdivision000.png: subdivision.pov frames/subdivision_d%
	povray -D +a subdivision.pov Declare=AspectWide=1 Declare=depth=$* +W1280 +H720 +ki0 +kf2 +kfi0 +kff500 +Oframes/subdivision_d$*/

subdivision_d%.mp4: frames/subdivision_d%/subdivision000.png
	ffmpeg -framerate 25 -pattern_type glob -i 'frames/subdivision_d$*/subdivision???.png' -c:v libx264 -pix_fmt yuv420p $@

subdepths = 0 1 2 3 4

#subdivision.mp4: $(subdepths:%=subdivision_d%.mp4)
#	ffmpeg -f concat -safe 0 -i subdivisionlist.txt -c copy subdivision.mp4
