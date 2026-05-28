
SHELL := /bin/bash
DIR_CONTAINER_SCRIPTS := "./container/scripts"

.PHONY: help setup run run-cli remove

help:
	@ echo ""
	@ echo "Usage:"
	@ echo "  setup: Setup and build the development environment container"
	@ echo "  run: Run the development environment container"
	@ echo "  remove: Remove the development environment container"
	@ echo ""

setup:
	@ chmod +x $(DIR_CONTAINER_SCRIPTS)/container_build.sh
	@ $(SHELL) $(DIR_CONTAINER_SCRIPTS)/container_build.sh

remove:
	@ chmod +x $(DIR_CONTAINER_SCRIPTS)/container_remove.sh
	@ $(SHELL) $(DIR_CONTAINER_SCRIPTS)/container_remove.sh

run:
	@ chmod +x $(DIR_CONTAINER_SCRIPTS)/container_run.sh
	@ $(DIR_CONTAINER_SCRIPTS)/container_run.sh
