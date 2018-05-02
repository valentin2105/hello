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
	sudo docker run -d -p '80:8888' valentinnc/hello:${COMMIT}


deploy:
	$(eval COMMIT := $(shell git rev-parse HEAD))
	sed -i 's/tag: latest/tag: ${COMMIT}/g' helm/values.yaml
	cd helm/values.yaml && helm upgrade hello .
	git checkout helm/values.yaml
