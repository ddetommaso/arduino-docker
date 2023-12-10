ARG DOCKER_SRC

FROM ${DOCKER_SRC}

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

WORKDIR /workspace

RUN chown $USER_UID:$USER_GID /usr/local/share/arduino-ide;
RUN chown $USER_UID:$USER_GID /usr/local/share/arduino-cli;
RUN chown $USER_UID:$USER_GID /workspace;

RUN groupmod -g ${PLUGDEV_GROUP_ID} plugdev && usermod -a -G plugdev ${USERNAME}
RUN groupmod -g ${DIALOUT_GROUP_ID} dialout && usermod -a -G dialout ${USERNAME}

USER $USERNAME

RUN mkdir /home/${USERNAME}/.arduinoIDE && mkdir /home/${USERNAME}/.arduino15
