#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONTAINER=ralves/ros2:src

function main {
    cd ${SCRIPT_DIR}
    sudo docker build -t ${CONTAINER} .
}

main
