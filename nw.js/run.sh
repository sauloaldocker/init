NAME=nw.js
docker stop $NAME; docker rm $NAME

SRC=$HOME/data
SRC_DATA=$SRC/docker/$NAME

docker run -it --rm --name $NAME -v $SRC_DATA:/home/nw/data --user 1000 sauloal/nw.js bash /home/nw/data/run.sh
