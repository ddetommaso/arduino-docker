# Stage 1: Build Stage
FROM ubuntu:20.04 AS builder

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive

# Install build dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    wget

# Build arguments for Arduino IDE and CLI versions
ARG ARDUINO_IDE_VERSION=2.2.1

# Download Arduino IDE and CLI
WORKDIR /
RUN wget https://github.com/arduino/arduino-ide/releases/download/${ARDUINO_IDE_VERSION}/arduino-ide_${ARDUINO_IDE_VERSION}_Linux_64bit.zip

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

ARG USERNAME=docky
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG PLUGDEV_GROUP_ID
ARG DIALOUT_GROUP_ID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

COPY --from=builder /arduino-ide_${ARDUINO_IDE_VERSION}_Linux_64bit.zip /tmp/arduino-ide.zip

RUN unzip /tmp/arduino-ide.zip -d /usr/local/share/ && \
    mv /usr/local/share/arduino-ide_* /usr/local/share/arduino-ide && \
    rm /tmp/arduino-ide.zip && \
    chown $USER_UID:$USER_GID /usr/local/share/arduino-ide;

ENV PATH=${PATH}:/usr/local/share/arduino-ide

RUN groupmod -g ${PLUGDEV_GROUP_ID} plugdev && usermod -a -G plugdev ${USERNAME}
RUN groupmod -g ${DIALOUT_GROUP_ID} dialout && usermod -a -G dialout ${USERNAME}

WORKDIR /workspace

USER $USERNAME

RUN mkdir /home/${USERNAME}/.arduinoIDE && mkdir /home/${USERNAME}/.arduino15
