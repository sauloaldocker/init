CMD=$1

source config

docker run --rm -v "$CFG:/src" --name jekyll grahamc/jekyll rake $CMD
