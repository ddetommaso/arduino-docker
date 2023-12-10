#!/bin/bash

CONFIG_FILE=~/.arduinoIDE/arduino-cli.yaml

arduino-cli core update-index --config-file $CONFIG_FILE

arduino-cli core install arduino:avr@1.8.6 --config-file $CONFIG_FILE

arduino-cli lib install AudioZero@1.0.0 --config-file "$CONFIG_FILE"

arduino-cli core list
