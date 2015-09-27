source config

docker run -d   -v "$CFG:/src" -p 127.0.1.1:4000:4000 --name jekyll grahamc/jekyll serve -H 0.0.0.0
