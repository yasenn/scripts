#!/bin/bash

# Select image file using fzf
input_file=$(fzf --prompt="Select a portrait image: ")

# Exit if no file selected
if [[ -z "$input_file" ]]; then
    echo "No file selected. Exiting."
    exit 1
fi

# Calculate average color of the image
everage_color=$(convert "$input_file" -resize 1x1 -format "%[fx:int(255*r)],%[fx:int(255*g)],%[fx:int(255*b)]" info:)
average_color=$(convert "$input_file"  -resize 1x1 txt:- | grep -Po "#[[:xdigit:]]{6}")
read -r -ei $average_color -p " color " average_color

# Create output filename
output_file="${input_file%.*}_composite.jpg"

# Process square image
# convert "$input_file" \
#     -resize x1000! -background "rgb($average_color)" -gravity west -extent 1880x1000 \
#     "$output_file"


rm "$output_file"

# caption
line1="Божественная"
line2="литургия"

magick  "$input_file" \
  -resize x1080 \
  -background "rgb($average_color)" \
  -gravity west -extent 1920x1080 \
  -gravity center -fill black -comment "$label1" \
  "$output_file"

  # -font 'ST-Nizhegorodsky' -pointsize 36  \
  # -gravity center -fill black -annotate +0+0 "$label1" \
# Process portrait image
# magick  "$input_file" \
#     -resize x1080 -background "rgb($average_color)" -gravity west -extent 1920x1080 -font 'ST-Nizhegorodsky'  "$output_file"
# 
#  -fill black -size 300x -font 'ST-Nizhegorodsky' label:"$line1"  
#         -size $((1920 * 2 / 3))x caption:"${line1}\n${line2}" \
#         -trim +repage \
#         \( -clone 0 -background navy -alpha shape \) +swap -composite \
#         miff:- | convert "$input_file" - \
#         -gravity east -geometry "+100+${golden_y}" -composite \


#     -bordercolor red -border 40x40 \

# Calculate golden ratio vertical position (667px from top)
golden_y=$((1080 * 618 / 1000))

# Generate text image with proper sizing
# convert -background none -fill white -font 'ST-Nizhegorodsky' \
#         -size $((1920 * 2 / 3))x caption:"${line1}\n${line2}" \
#         -trim +repage \
#         \( -clone 0 -background navy -alpha shape \) +swap -composite \
#         miff:- | convert "$input_file" - \
#         -gravity east -geometry "+100+${golden_y}" -composite "$output_file"
# 
# identify $output_file
echo "Successfully created: $output_file"
termux-media-scan "$output_file"
termux-open "$output_file"
