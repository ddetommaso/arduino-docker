#!/bin/bash

# Source the .env file to export environment variables
if [[ -f .env ]]; then
  # Use "source" or its shorthand "." to import the variables
  source .env
fi

# Build the Docker image
echo "Building Docker image '$ARDUINO_IDE_IMAGE_NAME'..."

docker build \
  --build-arg ARDUINO_CLI_VERSION="$ARDUINO_CLI_VERSION" \
  --build-arg ARDUINO_IDE_VERSION="$ARDUINO_IDE_VERSION" \
  -t "$ARDUINO_IDE_IMAGE_NAME" .
