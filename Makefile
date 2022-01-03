.EXPORT_ALL_VARIABLES:
IMAGE="jahrik/mysql"
ifeq ($(shell uname -m),aarch64)
	ARCH:=arm64v8
else ifeq ($(shell uname -m),x86_64)
	ARCH:=amd64
endif
TAG:=10.2
STACK=mysql

all: build

build:
	@docker build \
		-t ${IMAGE}:$(TAG) \
		--build-arg ARCH=${ARCH} \
		--build-arg TAG=${TAG} .

push:
	@docker push ${IMAGE}:$(TAG)

deploy:
	@docker stack deploy -c docker-compose.yml $(STACK)

.PHONY: all build push deploy
