NAME=pifollowjs
PORT=11223
IP=127.0.1.1
IP=0.0.0.0
docker stop $NAME; docker rm $NAME

DATA=$HOME/bigdata/saulo/Dropbox/pifollow/js
SRC=$HOME/data
SRC_DATA=$SRC/docker/pifollowjs/pifollowjs

#docker run -d --name $NAME -v $SRC_DATA:/data -v $DATA:/data/server/v2/data/ -p $IP:$PORT:3000 dockerfile/nodejs bash /data/run.sh
docker run -d --name $NAME -v $SRC_DATA:/data -v $DATA:/data/server/v2/data/ -p $IP:$PORT:3000 node bash /data/run.sh
