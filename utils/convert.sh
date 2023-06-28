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

sig01=$1

if [ -z "$sig01" ]; then echo "usage: $0 rabbit-signature"; exit 1; fi

# echo "Rabbit signature: $sig01"

rabbit=`./signature_convert --rabbitstring --totheleft $radiusl --totheright $radiusr --showworm $sig01`
status=$?

rabbitleft=`echo "$rabbit" | cut -f1 -d'('`
index=`echo "$rabbitleft" | wc -c`

echo index: $index

rabbit=`echo "$rabbit" | tr -d '()' | tr '0' '7' | tr '1' '8'`
#echo "Rabbit string: $rabbit"

echo "$rabbit" | ./inflate78 --index $index
