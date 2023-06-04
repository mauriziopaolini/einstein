#!/bin/bash
#

h=$1
if [ -z "$h" ]; then echo "FATAL: h is not given"; exit 1; fi

mshname="pippo"
mshname=$2

function process ()
{
  first=1

  while read x y
  do
    if [ -n "$first" ]
    then
      first=""
      firstx=$x
      firsty=$y
      echo "subdomain $x, $y"
    else
      echo "piece $x, $y"
    fi
  done
  echo "piece $firstx, $firsty"
}

echo "graf 0"
echo "domain"

cat | process

echo "enddomain"

echo "h $h"
echo "mesh"
echo "flipdiag"
echo "pigra"
echo "flipdiag"
echo "writemsh $mshname.msh"
echo "quit"
