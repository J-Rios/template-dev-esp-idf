#!/usr/bin/env bash
set -e

# Actual script directory path
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Get Project Name
PROJECT_NAME="$(basename "$(realpath "$DIR/../..")")"

# Get Container Image and User Name
IMG_NAME=$(cat "${DIR}/../config/container_name.txt")
CONTAINER_USER=$(cat "${DIR}/../config/container_user.txt")

###############################################################################

# SSH Host Configuration to mount
DIR_HOST_SSH_CFG="/home/${USER}/.ssh"
DIR_CONTAINER_SSH_CFG_MOUNT="/home/${CONTAINER_USER}/.ssh"

# Git Host Configuration to mount
DIR_HOST_GIT_CFG="/home/${USER}/.gitconfig"
DIR_CONTAINER_GIT_CFG_MOUNT="/home/${CONTAINER_USER}/.gitconfig"

# Mount point
PROJECT_DIR_TO_MOUNT="${DIR}/../.."
PROJECT_MOUNT_POINT="/home/${CONTAINER_USER}/workspace/${PROJECT_NAME}"

###############################################################################

# Show Container Information
echo ""
echo "--------------------------------------------------"
echo "ESP-IDF Development Environment Container."
echo "Execute \"code\" command to start the IDE."
echo "Execute \"exit\" command to exit the Container."
echo "--------------------------------------------------"
echo ""

# Allow root user to run GUI Applications (connect to X server)
#xhost +local:root > /dev/null 2>&1

###############################################################################

# Build Podman run command arguments safely
RUN_ARGS=(run -it --network="host" --ipc=host --rm --privileged)
if [ -n "${DISPLAY:-}" ]; then
    RUN_ARGS+=(--env="DISPLAY=${DISPLAY}")
fi
if [ -n "${SSH_AUTH_SOCK:-}" ] && [ -S "${SSH_AUTH_SOCK}" ]; then
    RUN_ARGS+=(--env="SSH_AUTH_SOCK=${SSH_AUTH_SOCK}")
    RUN_ARGS+=(--volume="${SSH_AUTH_SOCK}:${SSH_AUTH_SOCK}")
fi
if [ -d "${DIR_HOST_SSH_CFG}" ]; then
    RUN_ARGS+=(--volume="${DIR_HOST_SSH_CFG}:${DIR_CONTAINER_SSH_CFG_MOUNT}")
fi

if [ -f "${DIR_HOST_GIT_CFG}" ]; then
    RUN_ARGS+=(--volume="${DIR_HOST_GIT_CFG}:${DIR_CONTAINER_GIT_CFG_MOUNT}")
fi
if [ -d "/tmp/.X11-unix" ]; then
    RUN_ARGS+=(--volume="/tmp/.X11-unix:/tmp/.X11-unix")
fi
if [ -d "/run/udev" ]; then
    RUN_ARGS+=(--volume="/run/udev:/run/udev:ro")
fi
if [ -d "/dev/bus/usb" ]; then
    RUN_ARGS+=(--volume="/dev/bus/usb:/dev/bus/usb")
else
    echo "Warning: USB forwarding not available (missing /dev/bus/usb)."
fi
RUN_ARGS+=(--volume="${PROJECT_DIR_TO_MOUNT}:${PROJECT_MOUNT_POINT}")
RUN_ARGS+=("${IMG_NAME}")

# Launch the image container
podman "${RUN_ARGS[@]}"

###############################################################################

echo ""
exit 0
