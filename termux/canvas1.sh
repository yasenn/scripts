#!/bin/bash

# Select image file using fzf
input_file=$(fzf --prompt="Select a portrait image: ")

# Exit if no file selected
if [[ -z "$input_file" ]]; then
    echo "No file selected. Exiting."
    exit 1
fi

image_width=$(identify -ping -format %w "$input_file")
image_heidght=$(identify -ping -format %h "$input_file")
cropoption="1x$image_heidght+"$((image_width - 1))+0
echo $cropoption
# Calculate average color of the image
everage_color=$(convert "$input_file" -crop $cropoption -resize 1x1 -format "%[fx:int(255*r)],%[fx:int(255*g)],%[fx:int(255*b)]" info:)
average_color=$(convert "$input_file"  -resize 1x1 txt:- | grep -Po "#[[:xdigit:]]{6}")
read -r -ei $average_color -p " color " average_color

# Create output filename
output_file="${input_file%.*}_composite.jpg"

# Process square image
# convert "$input_file" \
#     -resize x1000! -background "rgb($average_color)" -gravity west -extent 1880x1000 \
#     "$output_file"


[ -f "$output_file" ] && rm "$output_file" 


read -r -ei $line1 -p " line1 " line1
read -r -ei $line2 -p " line2 " line2

convert "$input_file" -resize x1280 \
 -background "rgb($average_color)" \
 -gravity west -extent 1920x1280 \
  \( -pointsize 196 -background none -fill red -stroke yellow -strokewidth 3 -font 'ST-Nizhegorodsky'  \
     -gravity center caption:"$line1\n$line2$(date +%d.%m.%Y)" \) \
  -gravity east -geometry +20+50 -composite \
  "$output_file"
termux-media-scan "$output_file"
termux-open "$output_file"

