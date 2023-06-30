#!/bin/bash
#
# Accept input like "[abc]def." and transform it into
# Declare=Sigh=abcabc Declare=Sigl=abcdef
# as options to povray "hatconwaysig.pov"
#

quiet=""
if [ "$1" = "-q" ]; then quiet="1"; shift; fi

sig=$1

if [ -z "$sig" ]; then echo "usage: $0 <signature>"; fi

sig=`echo "$sig" | tr -d '.'`

if echo "$sig" | grep -q '[[]'
then
  period=`echo "$sig" | cut -f1 -d] | cut -f2 -d[`
  postperiod=`echo "$sig" | cut -f2 -d]`
  period="${period}${period}"
  period="${period}${period}"
  period="${period}${period}"
  period="${period}${period}"
  period="${period}${period}"
  sig="${period}${postperiod}"
else
  sig="222222222222${sig}"
fi

sigl=`echo "$sig" | rev | cut -c1-6 | rev`
sigh=`echo "$sig" | rev | cut -c7-12 | rev`

shift

if [ -z "$1" ]; then echo "Declare=Sigh=$sigh Declare=Sigl=$sigl"; exit; fi

if [ "$1" = "povray" ]
then
  shift
  if [ -z "$quiet" ]; then echo "executing povray with arguments from command line"; fi
  povray hatconwaysig.pov +a Declare=Sigh=$sigh Declare=Sigl=$sigl $*
fi
