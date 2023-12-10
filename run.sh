export USER_UID=$(id -u)
export USER_GID=$(id -g)
export PLUGDEV_GROUP_ID=$(getent group plugdev | cut -d: -f3)
export DIALOUT_GROUP_ID=$(getent group dialout | cut -d: -f3)

docker-compose build

docker-compose up

docker-compose down


