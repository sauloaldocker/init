#https://github.com/krishnasrinivas/wetty/blob/master/Dockerfile
FROM node:0.10.38
MAINTAINER Nathan LeClaire <nathan@docker.com>

RUN useradd --create-home --shell /bin/bash --home /home/term term && \
    echo 'term:term' | chpasswd

RUN apt-get update && \
    apt-get install -y vim nano

#USER term

RUN mkdir /home/term/app && \
    git clone https://github.com/krishnasrinivas/wetty.git /home/term/app && \
    cd /home/term/app && \
    npm install 

WORKDIR /home/term/app

#USER root

EXPOSE 3000

ENTRYPOINT ["node"]

CMD ["app.js", "-p", "3000"]
