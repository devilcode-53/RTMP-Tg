FROM jrottenberg/ffmpeg:4.4-alpine

# Use an image from the repo as the background
# Make sure you upload a file named 'logo.jpg' to your repo
COPY logo.jpg /logo.jpg

# Variables (You will set these in Railway Dashboard)
ENV INPUT_SOURCE="https://your-audio-link.mp3"
ENV TELEGRAM_URL="rtmps://dc4-1.rtmp.t.me/s/"
ENV STREAM_KEY="your-stream-key"

# Optimized command: 1 frame per second, low resolution, aac audio
ENTRYPOINT ffmpeg -re -loop 1 -i /logo.jpg -stream_loop -1 -i "$INPUT_SOURCE" \
    -c:v libx264 -preset ultrafast -tune instill -pix_fmt yuv420p -r 1 -g 2 \
    -c:a aac -b:a 128k -ar 44100 -shortest \
    -f flv "$TELEGRAM_URL$STREAM_KEY"
