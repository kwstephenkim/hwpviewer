#!/bin/bash
#
if (( $# == 0 )) || [[ $1 == "-h" ]] || [[ $1 == "--help" ]]; then
    echo "usage: $0 myhwpviewer:1.0 [options to docker run]"
    echo "usage: $0 myhwpviewer:1.0 -v$HOME/workspace:/workspace"
    exit 0
fi

container_name="${1:-myhwpviewer:1.0}"
shift 1

if ! (which id > /dev/null 2>&1); then
    echo "id must be available"
    exit 100
fi

uid="$(id -u)"
gid="$(id -g)"
nuid="$(id -un)"
ngid="$(id -gn)"

set -x
docker run --rm \
       -e DISPLAY=$DISPLAY \
       -e HOST_UID=$uid \
       -e HOST_GID=$gid \
       -e HOST_USER=$nuid \
       -e HOST_GROUP=$ngid \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v $HOME/.ssh:$HOME/.ssh \
       "$@" \
       -it $container_name
