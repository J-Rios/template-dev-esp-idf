
SHELL := /bin/bash
DIR_CONTAINER_SCRIPTS := "./container/scripts"

.PHONY: help setup remove run save

help:
	@ echo ""
	@ echo "Usage:"
	@ echo "  setup: Setup and build the development environment container"
	@ echo "  run: Run the development environment container"
	@ echo "  save: Save changes done in the development environment container"
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
	@ $(SHELL) $(DIR_CONTAINER_SCRIPTS)/container_run.sh

save:
	@ chmod +x $(DIR_CONTAINER_SCRIPTS)/container_save.sh
	@ $(SHELL) $(DIR_CONTAINER_SCRIPTS)/container_save.sh
