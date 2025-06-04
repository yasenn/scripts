convert "$(fzf)" -set colorspace RGB +repage \
	\( -clone 0 -resize 1x1 -format "%[fx:floor(255*u.r)] %[fx:floor(255*u.g)] %[fx:floor(255*u.b)]" -write info: +delete \) \
	\( -clone 0 -resize 848x1280! \) \
	\( -clone 1 -resize 1920x1080! -background "rgb(%[fx:t==0?u.r:v.r], %[fx:t==0?u.g:v.g], %[fx:t==0?u.b:v.b])" -gravity center -extent 1920x1080 \) \
	-delete 0,1 -gravity west -geometry +0+0 -composite output.jpg
