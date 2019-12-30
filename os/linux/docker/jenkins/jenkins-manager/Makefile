include ./env
export

docker-build:
	docker build -t $(DOCKER_IMG_NAME):$(DOCKER_TAG_NAME) .

# This is meant to test the container on a developer's laptop, not for production services.
docker-run:
	./docker-run.sh
