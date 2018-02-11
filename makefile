# Grab the version number from the package.json.
version := $(shell jq -r .version package.json)
image := dwmkerr/terraform-ci

build:
	docker build -t $(image):latest .	
	docker tag $(image):latest $(image):$(version)

# Run the tests.
test: build
	./test.sh

# Deploy the images to the Docker Hub. Assumes you are logged in!
deploy: 
	docker push $(image):latest
	docker push $(image):$(version)

# Test the build.
circleci:
	circleci config validate
	circleci build --job test
	circleci build --job deploy

# Make sure the makefile knows the commands below are commands, not targets.
.PHONY: build test deploy
