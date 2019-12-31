include ./env
export

build: docker-build
docker-build:
	docker build -t $(DOCKER_IMG_NAME):$(DOCKER_TAG_NAME) \
		--build-arg DOCKER_GID=$(DOCKER_GID) \
		--build-arg JENKINS_UID=$(JENKINS_UID) \
		--build-arg JENKINS_GID=$(JENKINS_GID) \
		.

run: docker-run
# This is meant to test the container on a developer's laptop, not for production services.
docker-run:
	./docker-run.sh

exec: docker-exec
docker-exec:
	docker exec -it $$(docker ps -f label=JENKINS_NODE=manager -q) /bin/bash

clean: docker-clean
docker-clean:
	docker volume rm jenkins_home || true
