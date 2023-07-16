# ytdl-pvr
This is a quick Docker/Podman wrapper around a useful script that was posted to Hacker News via Pastebin, from here:

- https://news.ycombinator.com/item?id=36748568
- https://pastebin.com/s6kSzXrL

To use it, put a feeds.txt in the input folder containing a line-separated list of YouTube channel RSS feeds, then run a command like this:

```sh
podman run -v $PWD/feeds.txt:/input/feeds.txt -v $PWD/output:/output --rm -it $(podman build -q .)
```