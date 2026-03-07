FROM jrottenberg/ffmpeg:4.4-alpine

COPY logo.jpg /logo.jpg

ENV INPUT_SOURCE="https://files.catbox.moe/c591mi.mp3" 
ENV TELEGRAM_URL="rtmps://dc5-1.rtmp.t.me/s/" 
ENV STREAM_KEY="3431441178:faC7_q0dcIKBACguvoxtEg"
ENTRYPOINT ffmpeg -re -f lavfi -i color=c=black:s=640x360:r=5 -loop 1 -i /logo.jpg \
    -stream_loop -1 -i "$INPUT_SOURCE" \
    -filter_complex "[1:v]scale=640:360[logo];[0:v][logo]overlay=shortest=1" \
    -c:v libx264 -preset superfast -tune stillimage -pix_fmt yuv420p -g 10 \
    -c:a aac -b:a 128k -ar 44100 \
    -f flv "$TELEGRAM_URL$STREAM_KEY"
