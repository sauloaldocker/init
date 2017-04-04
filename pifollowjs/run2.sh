set -xeu

NAME=pifollowjs_dev
PORT=11224
IP=127.0.1.1
IP=0.0.0.0

SSLkey=$(readlink  -f ${HOME}/bin/letsencrypt/certs/etc/live/aflitos.net/privkey.pem)
SSLcert=$(readlink -f ${HOME}/bin/letsencrypt/certs/etc/live/aflitos.net/cert.pem   )

# ~/bin/letsencrypt/certs/etc/live/aflitos.net/
# cert.pem      -> ../../archive/aflitos.net/cert5.pem
# privkey.pem   -> ../../archive/aflitos.net/privkey5.pem
# chain.pem     -> ../../archive/aflitos.net/chain5.pem
# fullchain.pem -> ../../archive/aflitos.net/fullchain5.pem


docker stop ${NAME} || true
docker rm   ${NAME} || true

DATA=$HOME/bigdata/saulo/Dropbox/pifollow/js
SRC=$HOME/data
SRC_DATA=$SRC/docker/pifollowjs/pifollowjs

#docker run -d --name $NAME -v $SRC_DATA:/data -v $DATA:/data/server/v2/data/ -p $IP:$PORT:3000 dockerfile/nodejs bash /data/run.sh
docker run -d --name $NAME             \
-v $SRC_DATA:/data                     \
-v $DATA:/data/server/v2/data/         \
-v ${SSLkey}:/$(basename ${SSLkey}   ) \
-v ${SSLcert}:/$(basename ${SSLcert} ) \
--env=SSLkey=/$(basename ${SSLkey}   ) \
--env=SSLcert=/$(basename ${SSLcert} ) \
-p $IP:$PORT:3000 node bash /data/run.sh
