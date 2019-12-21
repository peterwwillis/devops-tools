include ./env
export

docker-build:
	docker build -t $(DOCKER_IMG_NAME):$(DOCKER_TAG_NAME) .

# This is meant to test the container on a developer's laptop, not for production services.
docker-run:
	docker run --rm -it -p 8080:8080 $(DOCKER_IMG_NAME):$(DOCKER_TAG_NAME)

# This is like docker-run, but with all the extra goodies a developer might actually want
# to make the manager work similar to how they'd expect in production (or at least, fake it).
docker-run-fancy:
	docker run --rm -it -p 8080:8080 -v ~/.aws:/home/
