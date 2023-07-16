if [ ! -f "/input/feeds.txt" ]
then
    >&2 echo "Failed to open file /input/feeds.txt. Exiting."
    exit 1
fi

if [ ! -d "/output" ]
then
    >&2 echo "Failed to switch to directory /output. Exiting."
    exit 1
fi

cd /output

grep "^[^#;]" /input/feeds.txt | while read feed
do
    echo "[ytdl-pvr] Downloading feed: $feed"
    curl --fail-with-body -L -s "$feed" | xq -r '.feed.entry[0:5] | .[].link."@href"' | yt-dlp \
        --batch-file - \
        --output="%(channel)s/%(upload_date)s %(title)s [%(id)s].%(ext)s" \
        --download-archive .ytdl-pvr-archive.txt  \
        --continue \
        --no-progress \
        --format 'bestvideo[vcodec^=avc1]+bestaudio[acodec^=mp4a]' \
        --remux-video "mp4" \
        --merge-output-format "mp4" \
        --no-mtime \
        --no-cache-dir \
        --write-thumbnail \
        --convert-thumbnails jpg \
        --embed-thumbnail \
        --embed-metadata \
        --embed-subs \
        --sub-lang en,en.* \
        --datebefore now || \
    echo "Continuing despite error."
done
