.DEFAULT_GOAL := info

info:
	@echo "Make"
	@echo "			- build (build and push project)"
	@echo "			- deploy (deploy latest image)"
	@echo
# Launch Dev environment
build:
	$(eval COMMIT := $(shell git rev-parse HEAD))
	sudo docker build -t valentinnc/hello:${COMMIT} .
	sudo docker push valentinnc/hello:${COMMIT} 

run:
	$(eval COMMIT := $(shell git rev-parse HEAD))
	go build
	./Hello


deploy:
	$(eval COMMIT := $(shell git rev-parse HEAD))
	sed -i 's/tag: latest/tag: ${COMMIT}/g' helm/values.yaml
	cd helm/ && helm --kube-context=${CLUSTER} upgrade hello .
	git checkout helm/values.yaml
