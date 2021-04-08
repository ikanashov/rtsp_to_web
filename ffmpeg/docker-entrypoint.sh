#!/bin/sh

echo "copy index.html to data"
cp /index.html /data/index.html


ffmpeg -fflags nobuffer \
 -rtsp_transport tcp \
 -i ${RTSP_URL}\
 -vsync 0 \
 -copyts \
 -vcodec copy \
 -movflags frag_keyframe+empty_moov \
 -an \
 -hls_flags delete_segments+append_list \
 -f segment \
 -segment_list_flags live \
 -segment_time 0.5 \
 -segment_list_size 1 \
 -segment_format mpegts \
 -segment_list /data/index.m3u8 \
 -segment_list_type m3u8 \
 -segment_list_entry_prefix / \
 /data/%3d.ts