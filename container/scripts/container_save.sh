#!/usr/bin/env bash
set -e

# Actual script directory path
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Get Container Image Name and Container ID
IMG_NAME=$(cat "${DIR}/../config/container_name.txt")
CONTAINER_ID=$(cat "${DIR}/../config/container_id.txt")

# Save current state of the Container
podman commit ${CONTAINER_ID} ${IMG_NAME}

exit 0
