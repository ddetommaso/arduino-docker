# Arduino IDE 2.x Docker Container

This repository provides a Dockerized version of the Arduino IDE 2.x, allowing you to run Arduino development environments in isolated containers.

## Getting Started

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Build and Run

1. Clone the repository:

    ```bash
    git clone https://github.com/ddetommaso/arduino-docker
    cd arduino-docker
    ```

2. Build the Docker image:

    ```bash
    cd docker
    ./build.sh
    ```

3. Start the Arduino IDE:

    ```bash
    ./run.sh
    ```

### Customization

- **Arduino IDE Version**: Update the `ARDUINO_IDE_VERSION` variable in the `docker/.env` file to choose the Arduino IDE version.
- **Arduino packages and libraries**: Add packages and libraries to be installed in `CLI-init.sh` so that they will be installed with arduino-cli at the startup of the container.

### Start with your project

During its first execution, the Arduino-IDE initialize the environment by installing core packages. By default the IDE
is configured to save your files in the root directory `/workspace/project` which is binded with the `project` folder in your host machine. Moreover the `arduino-cli.yaml` will be an exact copy of the one inside the container, so that you can commit this configuration file in your project. Finally, the directories `~/.arduinoIDE`, `~/.arduino15` and `/workspace` are configured to be volumes associated to the container, thus their content will survive even after quitting the container unless you explicitly remove them.

