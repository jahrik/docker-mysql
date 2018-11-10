IMAGE = "jahrik/arm-mysql"
TAG = "arm32v7"

all: build

build:
	@docker build -t ${IMAGE}:$(TAG) .
	@docker tag ${IMAGE}:$(TAG) ${IMAGE}:latest

push:
	@docker push ${IMAGE}:$(TAG)
	@docker push ${IMAGE}:latest

deploy:
	@docker stack deploy --resolve-image=never -c docker-compose.yml mysql

.PHONY: all build push deploy
