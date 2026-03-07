FROM jrottenberg/ffmpeg:4.4-alpine

COPY logo.jpg /logo.jpg

ENV INPUT_SOURCE="https://files.catbox.moe/c591mi.mp3" 
ENV TELEGRAM_URL="rtmps://dc5-1.rtmp.t.me/s/" 
ENV STREAM_KEY="3431441178:faC7_q0dcIKBACguvoxtEg"
ENTRYPOINT ffmpeg -re -loop 1 -i /logo.jpg -stream_loop -1 -i "$INPUT_SOURCE" \
    -vf "scale=640:360,format=yuv420p" \
    -c:v libx264 -preset ultrafast -tune stillimage -r 2 -g 4 \
    -c:a aac -b:a 128k -ar 44100 \
    -f flv "$TELEGRAM_URL$STREAM_KEY"
