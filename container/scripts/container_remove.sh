#!/usr/bin/env bash
set -e

# Actual script directory path
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Get Image Name
IMG_NAME=$(cat "${DIR}/../config/container_name.txt")

# Remove all containers created from this image
CONTAINERS=$(podman ps -a --filter ancestor="${IMG_NAME}" --format "{{.ID}}")
if [ -n "${CONTAINERS}" ]; then
    echo "Removing containers for image ${IMG_NAME}..."
    podman rm -f ${CONTAINERS}
else
    echo "No containers found for image ${IMG_NAME}."
fi

# Remove the image
if podman image exists "${IMG_NAME}" >/dev/null 2>&1; then
    echo "Removing image ${IMG_NAME}..."
    podman rmi -f "${IMG_NAME}"
else
    echo "Image ${IMG_NAME} does not exist."
fi

exit 0
