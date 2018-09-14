IMAGE = "jahrik/arm-visualizer"
TAG = "arm32v7"

all: build

build:
	@docker build -t ${IMAGE}:$(TAG) .
	@docker tag ${IMAGE}:$(TAG) ${IMAGE}:latest

push:
	@docker push ${IMAGE}:$(TAG)
	@docker push ${IMAGE}:latest

deploy:
	@docker stack deploy --resolve-image=never -c visualizer-stack.yml viz

.PHONY: all build push deploy
