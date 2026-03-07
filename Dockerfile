FROM jrottenberg/ffmpeg:4.4-alpine

# Use an image from the repo as the background
COPY logo.jpg /logo.jpg

# Variables (Set these in Railway Dashboard)
ENV INPUT_SOURCE="https://files.catbox.moe/c591mi.mp3"
ENV TELEGRAM_URL="rtmps://dc5-1.rtmp.t.me/s/"
ENV STREAM_KEY="3431441178:faC7_q0dcIKBACguvoxtEg"

# FIXED: Changed 'instill' to 'stillimage'
ENTRYPOINT ffmpeg -re -loop 1 -i /logo.jpg -stream_loop -1 -i "$INPUT_SOURCE" \
    -c:v libx264 -preset ultrafast -tune stillimage -pix_fmt yuv420p -r 1 -g 2 \
    -c:a aac -b:a 128k -ar 44100 -shortest \
    -f flv "$TELEGRAM_URL$STREAM_KEY"
