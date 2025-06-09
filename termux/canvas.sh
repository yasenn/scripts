#!/bin/bash

# Select image file using fzf
input_file=$(fzf --prompt="Select a portrait image: ")

# Exit if no file selected
if [[ -z "$input_file" ]]; then
    echo "No file selected. Exiting."
    exit 1
fi

# Calculate average color of the image
average_color=$(convert "$input_file" -resize 1x1 -format "%[fx:int(255*r)],%[fx:int(255*g)],%[fx:int(255*b)]" info:)

# Create output filename
output_file="${input_file%.*}_composite.jpg"

# Process the image
convert "$input_file" \
    -resize x1000! -background "rgb($average_color)" -gravity west -extent 1880x1000 \
    -bordercolor red -border 40x40
    "$output_file"

echo "Successfully created: $output_file"
termux-open "$output_file"
