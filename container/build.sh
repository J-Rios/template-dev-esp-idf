#!/usr/bin/env bash
set -e

# Actual script directory path
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Get Image Name
IMG_NAME=$(cat ${DIR}/container_name.txt)

# Build The Container Image
podman build -t ${IMG_NAME} -f ${DIR}/Containerfile .

exit 0
