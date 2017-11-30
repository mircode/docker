set app=%1%

docker image rm -f %app%
docker build -t %app%:latest ./ --build-arg app=%app%
docker image prune --force

docker container rm -f %app%
docker run -d --name %app%  %app%:latest
docker exec -it %app% bash