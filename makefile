# Create the docker images locally. If a BUILD_NUM is provided, we will also
# create an image with the tag BUILD_NUM.
build:
	docker build -t dwmkerr/terraform-ci:latest .
ifndef BUILD_NUM
	$(warning No build number is defined, skipping build number tag.)
else
	docker build -t dwmkerr/terraform-ci:$(BUILD_NUM) .	
endif

# Run the tests.
test: build
	./test.sh

# Deploy the images to the Docker Hub. Assumes you are logged in!
deploy: 
	docker push dwmkerr/terraform-ci:latest
ifndef BUILD_NUM
	$(warning No build number is defined, skipping push of build number tag.)
else
	docker push dwmkerr/terraform-ci:$(BUILD_NUM)
endif

# Make sure the makefile knows the commands below are commands, not targets.
.PHONY: build test deploy
