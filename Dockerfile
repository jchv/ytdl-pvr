FROM docker.io/python:alpine
RUN mkdir /input /output
RUN apk add --no-cache ffmpeg curl jq
COPY requirements.txt /
RUN pip install --upgrade pip
RUN pip install -r /requirements.txt
COPY ytdl-pvr.sh /ytdl-pvr
RUN chmod +x /ytdl-pvr
ENTRYPOINT ["/bin/sh", "/ytdl-pvr"]
