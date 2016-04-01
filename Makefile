DOCKER_IMAGE=docker-consul-template-haproxy

rm:
	docker rm -f ${DOCKER_IMAGE}

build:
	docker build -t ${DOCKER_IMAGE} .

run: build
	docker run -d -p 8080:80 -e CONSUL_ADDRESS=$$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' consul) --name ${DOCKER_IMAGE} ${DOCKER_IMAGE}