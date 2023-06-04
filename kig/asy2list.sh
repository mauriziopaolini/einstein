#!/bin/bash
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

tempfile="/tmp/asy2list_$$.tmp"

cat | filter >$tempfile

num=`cat $tempfile | wc -l`

echo "$num"
cat $tempfile

rm $tempfile

