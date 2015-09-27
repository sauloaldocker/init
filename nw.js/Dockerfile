#docker build --rm -t sauloal/nw.js .

FROM dockerfile/nodejs

RUN apt-get update && apt-get install -y libc6-dev-* gcc-4.8-multilib g++-4.8-multilib

RUN npm install -g nw-builder --save-dev && \
    npm install -g node-pre-gyp && \
    npm install -g nw-gyp && \
    npm install -g flatten-packages

RUN useradd --create-home --uid 1000 -U --shell /bin/bash nw && \
    echo `echo "nw\nnw\n" | passwd nw` \
    adduser nw sudo && echo "nw ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER nw

WORKDIR /home/nw

