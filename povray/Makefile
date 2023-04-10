
depths = 0 1 2 3 4 5 6
deflated_suf = $(depths:%=H7_%) $(depths:%=H8_%)

deflated_png_H7 = $(depths:%=einstein_H7_d%.png)
deflated_png_H8 = $(depths:%=einstein_H8_d%.png)

all:$(deflated_png_H7) $(deflated_png_H8)

$(deflated_png_H7):einstein_H7_d%.png: einstein.pov shapes.inc subdivision.inc
	povray +a -D $< Declare=htile=7 Declare=depth=$* +O$@

$(deflated_png_H8):einstein_H8_d%.png: einstein.pov shapes.inc subdivision.inc
	povray +a -D $< Declare=htile=8 Declare=depth=$* +O$@

