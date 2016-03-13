#!/bin/bash
for i in *.mp4; do
  ffmpeg -i "$i" -vn \
       -acodec libmp3lame -ac 2 -qscale:a 4 -ar 48000 \
        "`basename "$i" .mp4`.mp3"
done
