#!/bin/bash

# check if arguments are provided
if [ $# -eq 0 ] || [ "$1" == "-h" ]
  then
    echo "Usage: giffer.sh <name> [count]"
    echo "  <name>   : Name for the gif"
    echo "  [count]  : Number of images to capture (default: 10)"
    exit
fi

# check if ImageMagick is installed
if ! command -v convert &> /dev/null
then
  echo "Error: ImageMagick is not installed. Please install ImageMagick to use this script."
  exit 1
fi

# check if imagesnap is installed
if ! command -v imagesnap &> /dev/null
then
  echo "Error: imagesnap is not installed. Please install imagesnap to use this script."
  exit 1
fi

# ensure folders exist
mkdir -p raw
mkdir -p out

# prepare variables
name=$1
count=10
if [ -n "$2" ]
then
  count=$2
fi 

echo "Creating gif with $count images"

# take pictures
for i in $(seq 1 $count)
do
  imagesnap raw/${1}_${i}.jpg
  echo "Taking picture number $i"
  if [ $? -ne 0 ]; then
    echo "Failed to take picture number $i"
    exit 1
  fi
done

# create GIF
convert -delay 20 raw/*.jpg out/${1}_out.gif
if [ $? -ne 0 ]; then
  echo "Failed to create gif, keeping images for manual processing..."
  exit 1
fi

# create boomerang GIF
convert out/${1}_out.gif -coalesce -duplicate 1,-2-1 out/${1}_boomerang.gif
if [ $? -ne 0 ]; then
  echo "Failed to create boomerang gif"
  exit 1
fi

# remove raw images, after all went fine
rm -rf raw/${1}_*

