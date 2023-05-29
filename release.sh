sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

TAG_NAME=$(node -e 'console.log(require("./package.json").version)')
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker build -f Dockerfile.build -t zengmingjian/web-ide:latest -t zengmingjian/web-ide:$TAG_NAME .
docker push zengmingjian/web-ide:$TAG_NAME
