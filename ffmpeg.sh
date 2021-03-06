提取字幕流
1）原始文本输出
ffmpeg -i mrt.mkv2 -an -vn -bsf:s mov2textsub -scodec copy -f rawvideo sub.txt
ffmpeg -i mrt.mkv2 -an -vn -c:s copy -f rawvideo -map 0:s sub2.txt
2）ass格式输出
ffmpeg -i mrt.mkv2 -an -vn -scodec copy sub3.srt

提取音视频
ffmpeg -i mrt.mkv2 -acodec copy -vcodec copy -sn mrt.mp4

增加字幕流
ffmpeg -i mrt.mp4 -i sub3.srt -map 0:0 -map 0:1 -map 1 -c:a copy -c:v copy -c:s copy video.mkv


将mrt.mkv2 分解为mrt.mp4 + sub3.srt 修改字幕合并为video.mkv


pcm-wav
./bin/ffmpeg -f s16le -ar 44.1k -ac 2 -i xx.pcm rec.wav



#for png
rm $(ls | egrep -v '(build.sh|logo.png)')
ffmpeg -i ./logo.png -vf crop=iw/2:ih:0 left.png
ffmpeg -i ./logo.png -vf crop=iw/2:ih:iw/2  right.png
ffmpeg -i left.png -vf pad=2*iw left2.png
ffmpeg -i ./left2.png  -i right.png -filter_complex overlay=w:0 full.png
