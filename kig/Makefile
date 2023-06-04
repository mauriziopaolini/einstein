#
# the original kig source has a polygon with sides of length 1
# the polygon *must* be defined counterclockwise; the user must
# manually "export" to an asymptote file.  Then "make"
#
# stl uses millimeters hence the scaling factor at the end so
# that the resulting tile has sides 1cm long
#

#
# erosion is relative to side length
#
erosion = 0.02

#
# a large value should produce large triangles.  This has no
# visual impact with respect to a small value, since no curved
# sides are present
#
meshsize = 4

#
# height is the tile thickness, relative to the side
#
height = 0.2

#
# scale produces an stl with units expressed in mm
#
scale = 10

all: realspectre.stl

%.list: %.asy asy2list.sh
	./asy2list.sh <$< >$@

%.eroded: %.list erode
#	./erode 0.03 <$< | tac >$@
	./erode $(erosion) <$< >$@

%.tmg: %.eroded eroded2tmg.sh
	./eroded2tmg.sh $(meshsize) $* <$< >$@

%.msh: %.tmg
	tmg -g0 <$< >/dev/null

%.off: %.msh msh2off
	./msh2off $(height) <$< >$@

%.stl: %.off
	ctmconv $< $@ --scale $(scale)
