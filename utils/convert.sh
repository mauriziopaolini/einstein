#!/bin/bash
#

radiusl=100
radiusr=100

while [ -n "$1" ]
do
  if [ "$1" = "--radiusleft" -a -n "$2" ]
  then
    radiusl="$2"
    shift 2
    continue
  fi
  if [ "$1" = "--radiusright" -a -n "$2" ]
  then
    radiusr="$2"
    shift 2
    continue
  fi
  if [ "$1" = "--radius" -a -n "$2" ]
  then
    radiusl="$2"
    radiusr="$2"
    shift 2
    continue
  fi
  break
done

function usage ()
{
  echo 'This script converts a rabbit signature (often in the form of a periodic signature)'
  echo 'into a signature with characters in {0,2,6}" (i.e. forming a worm)'
  echo ""
  echo "usage: $0 [--radius <n>] rabbit-signature"
  echo "  --radius can be replaced by --radiusleft or --radiusright"
  echo ""
  echo "The size of radius (the size of the neighborhood of the rabbit string used to get the"
  echo "converted signature"
  echo ""
  echo "Examples:"
  echo "  $0 --radius 10000 [1]"
  echo "  $0 --radius 10000 [10]"
  echo "  $0 --radius 10000 [01]"
}

sig01=$1

if [ -z "$sig01" ]; then usage; exit 1; fi

# echo "Rabbit signature: $sig01"

rabbit=`./signature_convert --rabbitstring --totheleft $radiusl --totheright $radiusr --showworm $sig01`
status=$?

rabbitleft=`echo "$rabbit" | cut -f1 -d'('`
index=`echo "$rabbitleft" | wc -c`

echo index: $index

rabbit=`echo "$rabbit" | tr -d '()' | tr '0' '7' | tr '1' '8'`
#echo "Rabbit string: $rabbit"

echo "$rabbit" | ./inflate78 --index $index
