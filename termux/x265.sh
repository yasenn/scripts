export F="$(fzf)"; export E="$(echo $F | vipe)"; ffmpeg -i $F  -vcodec libx265 -vtag hvc1 $E; ffprobe $E && termux-media-scan $E 
