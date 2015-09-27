docker rm wetty
#docker run -p 0.0.0.0:3000:3000 --name wetty --hostname=wetty sauloal/wetty
docker run -d -p 127.0.1.1:3000:3000 --name wetty --hostname=wetty sauloal/wetty
