# Stage 1: Build Stage
FROM ubuntu:20.04 AS builder

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive

# Install build dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    wget

# Build arguments for Arduino IDE
ARG ARDUINO_IDE_VERSION=2.2.1
ARG ARDUINO_CLI_VERSION=0.34.2

# Download Arduino IDE
WORKDIR /

RUN wget https://github.com/arduino/arduino-ide/releases/download/${ARDUINO_IDE_VERSION}/arduino-ide_${ARDUINO_IDE_VERSION}_Linux_64bit.zip
RUN wget https://github.com/arduino/arduino-cli/releases/download/${ARDUINO_CLI_VERSION}/arduino-cli_${ARDUINO_CLI_VERSION}_Linux_64bit.tar.gz

FROM ubuntu:20.04

ENV TZ=Europe/Rome
ENV DEBIAN_FRONTEND noninteractive

USER root

RUN apt-get update

RUN apt-get install -y apt-utils x11-apps gnupg swig alsa-utils \
    libace-dev libc6 python3 python3-dev python3-pip \
    libgsl0-dev libncurses5-dev libsdl1.2-dev \
    subversion git gfortran cmake libxmu-dev \
    libode-dev wget unzip \
    qtbase5-dev qtdeclarative5-dev qtmultimedia5-dev \
    libqt5svg5 libqt5opengl5-dev \
    libopencv-dev freeglut3-dev libtinyxml-dev \
    libblas-dev coinor-libipopt-dev liblapack-dev \
    libmumps-dev qml-module-qtmultimedia \
    qml-module-qtquick-dialogs qml-module-qtquick-controls \
    libedit-dev libeigen3-dev libjpeg-dev libsimbody-dev \
    libxml2-dev openssh-server openssh-client psmisc \
    mesa-utils net-tools iputils-ping lsb-release mcedit \
    libssl-dev cmake-curses-gui;

RUN apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
    gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad gstreamer1.0-libav gstreamer1.0-tools \
    gstreamer1.0-plugins-ugly pulseaudio-utils libdlib-dev libsqlite3-dev \
    libftdi1 libusb-1.0-0-dev terminator telnet gnome-terminal protobuf-compiler sudo nano;

RUN apt-get install -y \
    curl \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release;

ARG ARDUINO_IDE_VERSION=2.2.1
ARG ARDUINO_CLI_VERSION=0.34.2

COPY --from=builder /arduino-ide_${ARDUINO_IDE_VERSION}_Linux_64bit.zip /tmp/arduino-ide.zip

RUN unzip /tmp/arduino-ide.zip -d /usr/local/share/ && \
    mv /usr/local/share/arduino-ide_* /usr/local/share/arduino-ide && \
    rm /tmp/arduino-ide.zip;

COPY --from=builder /arduino-cli_${ARDUINO_CLI_VERSION}_Linux_64bit.tar.gz /usr/local/share/arduino-cli.tar.gz

RUN mkdir /usr/local/share/arduino-cli && \
    tar xzvf /usr/local/share/arduino-cli.tar.gz -C /usr/local/share/arduino-cli

ENV PATH=${PATH}:/usr/local/share/arduino-ide:/usr/local/share/arduino-cli