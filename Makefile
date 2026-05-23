
SHELL := /bin/bash
DIR_CONTAINER := "./container"

.PHONY: build-container run-container

help:
	@ echo ""
	@ echo "Usage:"
	@ echo "  build-container: Build the development environment container"
	@ echo "  run-container: Run the development environment container"
	@ echo ""

build-container:
	@ chmod +x $(DIR_CONTAINER)/build.sh
	@ $(SHELL) $(DIR_CONTAINER)/build.sh

run-container:
	@ chmod +x $(DIR_CONTAINER)/run.sh
	@ $(SHELL) $(DIR_CONTAINER)/run.sh
