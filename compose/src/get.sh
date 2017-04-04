curl -L https://github.com/docker/compose/releases/download/1.5.2/docker-compose-`uname -s`-`uname -m` > docker-compose
sudo cp docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/bash/docker-compose > docker-compose-completion && sudo cp docker-compose-completion /etc/bash_completion.d/docker-compose
