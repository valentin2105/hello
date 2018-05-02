.DEFAULT_GOAL := info
REPO="valentinnc/hello"

info:
	@echo "Make"
	@echo "			- build (build and push project)"
	@echo "			- deploy (deploy latest image)"
	@echo
# Launch Dev environment
build:
	docker build -t ${REPO}:${COMMIT} .
	docker push ${REPO}:${COMMIT} 

deploy:
	$(eval COMMIT := $(shell git rev-parse HEAD))
	sed -i 's/image: latest/image: ${COMMIT}/g' helm/values.yaml
	cd helm/values.yaml && helm upgrade hello .
	git checkout helm/values.yaml
