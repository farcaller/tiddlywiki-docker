# tiddlywiki-docker

A minimalistic docker container for tiddlywiki that's updated nightly and will
track the latest TW release from nixpkgs.

Usage

```
docker run ghcr.io/farcaller/tiddlywiki-docker:5.2.5 ...
```

The entrypoint specifies the path to tiddlywiki already and it's better not to
modify it, as that path is unstable and unique to every build.
