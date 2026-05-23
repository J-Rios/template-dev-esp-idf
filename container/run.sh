#!/usr/bin/env bash
set -e

# Get Image Name
IMG_NAME=$(cat ${DIR}/container_name.txt)

# Run the Container
podman run -it --rm \
    -v $(pwd):/project:Z \
    --device /dev/bus/usb \
    --privileged \
    ${IMG_NAME}

exit 0
