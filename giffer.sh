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
imagesnap raw/${i}_${1}.jpg
   echo "Taking picture number $i"
done

convert -delay 20 raw/*.jpg out/${1}_out.gif
rm -rf raw/*
