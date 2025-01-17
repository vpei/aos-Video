#!/bin/bash
# src must be 1024x1024 size
srcn=ic_launcher
srca=ic_launcher_foreground

# !!!!! SOURCE MUST BE 1024x1024 !!!!!
# !!!!! SOURCE MUST BE 1024x1024 !!!!!

# Define arrays for resolutions and directory names
resolutions=(256 384 512 768 1024)
#resolutions=(80 120 160 240 320)
densities=("mdpi" "hdpi" "xhdpi" "xxhdpi" "xxxhdpi")

# foreground needs to be scaled otherwise icon is too big
#convert ${srca}.png -resize 45% -gravity center -background none -extent 1024x1024 ${srca}2.png
#convert ${srca}.png -resize 67% -gravity center -background none -extent 1024x1024 ${srca}2.png
#convert ${srcn}.png -resize 67% -gravity center -extent 1024x1024 ${srcn}2.png
#cp ${srca}.png ${srca}2.png

# Create densities if they don't exist
for dir in "${densities[@]}"
do
  mkdir -p "res/mipmap-${dir}"
done

# Associate resolutions with directory names using associative array
declare -a dir_map
for ((i=0; i<${#resolutions[@]}; i++))
do
  dir_map[${resolutions[$i]}]=${densities[$i]}
done

# Loop through resolutions, resize images, and save them in the appropriate directory
for resolution in "${resolutions[@]}"
do
  dir="${dir_map[$resolution]}"
  echo convert size ${resolution}x${resolution} for res/mipmap-${dir}
  convert ${srcn}.png -resize ${resolution}x${resolution} -quality 100 res/mipmap-${dir}/${srcn}.webp
  convert ${srca}.png -resize ${resolution}x${resolution} -quality 100 res/mipmap-${dir}/${srca}.webp
done
