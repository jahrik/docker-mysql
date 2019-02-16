IMAGE="jahrik/arm-mysql"
TAG:=$(shell uname -m)
STACK=mysql

all: build

build:
	@docker build -t ${IMAGE}:$(TAG) .

push:
	@docker push ${IMAGE}:$(TAG)

deploy:
	@docker stack deploy -c docker-compose.yml $(STACK)
