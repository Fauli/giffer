#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit
fi

for i in {1..10}
do
./ImageSnap/imagesnap raw/${i}_${1}.jpg
   echo "Taking picture number $i"
done

convert -delay 20 raw/*.jpg out/${1}_out.gif
rm -rf raw/*
