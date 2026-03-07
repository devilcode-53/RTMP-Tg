FROM jrottenberg/ffmpeg:4.4-alpine

ENV INPUT_SOURCE="https://files.catbox.moe/c591mi.mp3" 
ENV TELEGRAM_URL="rtmps://dc5-1.rtmp.t.me/s/" 
ENV STREAM_KEY="3431441178:faC7_q0dcIKBACguvoxtEg"

ENTRYPOINT ffmpeg -re -f lavfi -i color=c=black:s=320x180:r=1 \
    -stream_loop -1 -i "$INPUT_SOURCE" \
    -c:v libx264 -preset ultrafast -tune zerolatency -pix_fmt yuv420p -g 2 \
    -c:a aac -b:a 128k -ar 44100 \
    -f flv "$TELEGRAM_URL$STREAM_KEY"
