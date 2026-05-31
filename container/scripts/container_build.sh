#!/usr/bin/env bash
set -e

# Actual script directory path
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Get Container Image Name
IMG_NAME=$(cat "${DIR}/../config/container_name.txt")

# Build The Container Image
podman build -t ${IMG_NAME} -f "${DIR}/../Containerfile" .

# Setup Git repository to ignore file mode changes
git config core.filemode false

# Clear Docker Image build cache checkpoints
docker builder prune -f

exit 0
