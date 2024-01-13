#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "Please provide name and image count"
    exit
fi

mkdir -p raw
mkdir -p out

count=10
if [ -n "$2" ]
then
  count=$2
fi 

echo "Creating gif with $count images"

for i in $(seq 1 $count)
do
  imagesnap raw/${1}_${i}.jpg
  echo "Taking picture number $i"
  if [ $? -ne 0 ]; then
    echo "Failed to take picture number $i"
    exit 1
  fi
done

convert -delay 20 raw/*.jpg out/${1}_out.gif
if [ $? -ne 0 ]; then
  echo "Failed to create gif, keeping images for manual processing..."
  exit 1
fi

rm -rf raw/${1}_*
