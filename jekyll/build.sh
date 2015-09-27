source setup

docker run --rm -v "$CFG:/src" --name jekyll_build grahamc/jekyll build
