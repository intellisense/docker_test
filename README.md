# Simple docker configuration to run nginx and gunicorn in separate containers and test nginx proxy pass to upstream gunicorn #

### Prerequisites ###
* This project uses `docker`, `docker-machine` and `docker-compose`

### Set it up ###

```
cd /path/to/docker_test/
docker-machine create test --driver virtualbox --virtualbox-disk-size "2000" --virtualbox-cpu-count 2 --virtualbox-memory "1024"
docker-machine env test
eval "$(docker-machine env test)"
docker build -t docker_test:test .
docker-compose build
docker-compose up -d
docker-machine ip test
```

Go to browser and paste the IP you get from command `docker-machine ip test` and you should see the response `Hello, World!`

### Installation of prerequisites on Mac via Homebrew ###

```
brew update && brew upgrade --all && brew cleanup && brew prune
# install docker
brew install docker

# install docker-machine and start its service
brew install docker-machine
brew services start docker-machine

# install docker-compose
sudo curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)"
sudo chmod +x /usr/local/bin/docker-compose

# test docker-compose installed correctly
docker-compose -v
```