DOCKER_IMAGE=docker-consul-template-haproxy

rm:
	docker rm -f ${DOCKER_IMAGE}

build:
	docker build -t ${DOCKER_IMAGE} .

run: build
	docker run -d -p 8000:8000 -p 8001:8001 -e CONSUL_ADDRESS=$$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' consul):8500 --name ${DOCKER_IMAGE} ${DOCKER_IMAGE}

run-consul:
	docker run -d -p 8500:8500 -h $$(docker-machine ip) --restart always --name consul progrium/consul -server -bootstrap

run-registrator:
	docker run -d -v /var/run/docker.sock:/tmp/docker.sock -h $$(docker-machine ip) --name=registrator gliderlabs/registrator consul://$$(docker-machine ip):8500

run-app:
	# An example of simple app https://github.com/agassner/docker-node
	docker run -d -e SERVICE_NAME=simple-app -h $$(docker-machine ip) --name app1 -p 8081:8080 simple-app
	docker run -d -e SERVICE_NAME=simple-app -h $$(docker-machine ip) --name app2 -p 8082:8080 simple-app

run-app3:
	docker run -d -e SERVICE_NAME=simple-app -h $$(docker-machine ip) --name app3 -p 8083:8080 simple-app

run-dependencies: run-consul run-registrator run-app

clean-up: rm clean-up-app
	docker rm -f registrator consul

clean-up-app:
	-docker rm -f app1 app2
