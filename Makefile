# -----------------------------------------------------------------------------
# constants
# -----------------------------------------------------------------------------

BASE_OS := ubuntu
BASE_OS_VERSION := 22.04

# IBT stands for "image build tool"
IBT := docker
GIT := git

IMAGE_FILE := Containerfile
IMAGE_NAME := schuam/${IBT}_yocto


# -----------------------------------------------------------------------------
# targets
# -----------------------------------------------------------------------------

.PHONY: help

# The idea of the help target is to print out a 'help' for the user that lists
# all targets and explains them. Each target that is supposed to be listed in
# the help must be commented like this:
# 
# ## <TARGET NAME>: This is a description of the target. In case the
# ## description is to long for one line, it can be split like this.
# <TARGET NAME>: dependencies
# [TAB]recipe

## help: Show this help
help: Makefile
	@echo ""
	@echo "The following targets exist:"
	@sed -n -e '/^## \S/ s/^## //p' -e 's/^## \s\+/: /p' $< | \
		awk -F ": " '{printf "\033[33m%-20s\033[0m%s\n", $$1, $$2};'
	@echo ""


## image: Build the container image
image:
	$(IBT) build \
		-f $(IMAGE_FILE) \
		-t $(IMAGE_NAME):latest \
		-t $(IMAGE_NAME):$(BASE_OS)-latest \
		-t $(IMAGE_NAME):$(shell date '+%Y-%m-%d') \
		-t $(IMAGE_NAME):`$(GIT) describe --tags --dirty --always` \
		--build-arg BASE_OS=$(BASE_OS) \
		--build-arg BASE_OS_VERSION=$(BASE_OS_VERSION) \
		.

