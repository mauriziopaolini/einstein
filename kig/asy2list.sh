#!/bin/bash
#
# the resulting file contains a list of the vertices of the polygons
#
# the last line contain the number of polygons
# each polygon is decribed in a block of lines:
#   first line of block: number of vertices
#   subsequent lines: coordinates of each vertex
#

function filter ()
{
  reading=""

  while read w1 w2 line
  do
    if [ "$w1" = "path" -a "$w2" = "polygon" ]; then reading=1; fi
    if [ -z "$reading" ]; then continue; fi
    if [ -n "$line" ]; then w2="$w2 $line"; fi
    if [ -n "$w2" ]; then w1="$w1 $w2"; fi
    if echo "$w1" | grep -q ';$'; then reading=""; fi
    pair=`echo "$w1" | sed -e "s/--/--\n/g" | cut -s -f2- -d'(' | cut -s -f1 -d')'`
    if [ -z "$pair" ]; then continue; fi
    echo "$pair" | tr ',' ' '
  done
}

function filter0 ()
{
  countcc=0
  while read line
  do
    echo "$line" | filter >$tempfile
    num=`cat $tempfile | wc -l`
    echo "$num"
    cat $tempfile
    countcc=$[ $countcc + 1 ]
  done
  echo "0"
  echo "$countcc"
}

tempfile="/tmp/asy2list_$$.tmp"

#
# glue lines ending with '--' with the following
#
#cat | tr '\n' '#' | sed -e 's/--#/--/g' | sed -e 's/#/\n/g' | grep "^path polygon =" | head -n 1 | filter >$tempfile
cat | tr '\n' '#' | sed -e 's/--#/--/g' | sed -e 's/#/\n/g' | grep "^path polygon =" | filter0 


#num=`cat $tempfile | wc -l`

#echo "$num"
#cat $tempfile

rm $tempfile

