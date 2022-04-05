# Change input and output details

output_path="Elite/S1E1" # Output Path (Same will be pushed in main also)
input_url="https://p-def6.pcloud.com/cfZDjQL3TZ4rzvp6ZP9Tm7Z7ZJmC5r7Ze5ZZzoLZZmkdhvZoFZnHZnFZl7Z1pZDzZUJZoJZozZfFZhzZd5ZpHZ3HZLzE1239fM7yYVzgyet45yVIQGOo7/ELITE%20.%202018%20.%20S01%20EP01%20-%20Welcome.mkv" # Input direct file url
input_extension="mp4" # Extension of file url



# Change ffmpeg configurations according to yur need (If you don't know, don't touch)

wget --quiet -O video.$input_extension $input_url
mkdir $output_path

ffmpeg -hide_banner -y -i video.$input_extension \
  -vf scale=w=1920:h=1080:force_original_aspect_ratio=decrease -c:a copy -ar 48000 -c:v libx265 -profile:v main10 -crf 28 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 5000k -maxrate 5350k -bufsize 7500k -b:a copy k -hls_segment_filename $output_path/1080p_%03d.ts $output_path/1080p.m3u8

rm video.$input_extension
cd $output_path

echo '#EXTM3U
#EXT-X-VERSION:3
#EXT-X-STREAM-INF:BANDWIDTH=5000000,RESOLUTION=1920x1080
1080p.m3u8' > master.m3u8
