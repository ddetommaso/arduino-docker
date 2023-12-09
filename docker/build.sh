#!/bin/bash

# Source the .env file to export environment variables
if [[ -f .env ]]; then
  # Use "source" or its shorthand "." to import the variables
  source .env
fi

# Display the Arduino IDE image name
echo "Arduino IDE Image Name: $ARDUINO_IDE_IMAGE_NAME"

# Build the Docker image
echo "Building Docker image '$ARDUINO_IDE_IMAGE_NAME'..."

docker build \
  --build-arg ARDUINO_IDE_VERSION="$ARDUINO_IDE_VERSION" \
  --build-arg USER_UID=$(id -u) \
  --build-arg USER_GID=$(id -g) \
  --build-arg PLUGDEV_GROUP_ID=$(getent group plugdev | cut -d: -f3) \
  --build-arg DIALOUT_GROUP_ID=$(getent group dialout | cut -d: -f3) \
  -t "$ARDUINO_IDE_IMAGE_NAME" .
