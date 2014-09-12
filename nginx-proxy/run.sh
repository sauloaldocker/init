docker stop proxy; docker rm proxy

docker run -d -p 127.0.1.1:800:80 --net host -v /var/run/docker.sock:/tmp/docker.sock --name proxy -t jwilder/nginx-proxy
