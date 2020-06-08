#!/bin/bash
if ! (which id > /dev/null 2>&1); then
    2>& echo "id must be available"
    exit 10
fi

uid="$(id -u)"
gid="$(id -g)"
nuid="$(id -un)"
ngid="$(id -gn)"

name="${1:-"myhwpviewer:1.0"}"

if [[ $1 == "-h" ]] || [[ $1 == "--help" ]]; then
    echo "usage: $0"
    echo "usage: $0 name:ver"
    echo "e.g.: $0 hwpviewer:1.0"
    echo "if name:ver is not given, by default, it is $name"
    exit 0
fi

if timedatectl show | egrep Timezone | cut -d '=' -f2 > /dev/null 2>&1 ; then
    MY_TIMEZONE="$(timedatectl show | egrep Timezone | cut -d '=' -f2)"
else
    if cat /etc/timezone | head -1 > /dev/null 2>&1; then
        MY_TIMEZONE="$(cat /etc/timezone | head -1)"
    else
        MY_TIMEZONE="America/Los_Angeles"
    fi
fi

cp ./Dockerfile.template ./Dockerfile
set -x
docker build \
       --build-arg __USER__="${nuid}" \
       --build-arg __GROUP__="${ngid}" \
       --build-arg __UID__="${uid}" \
       --build-arg __GID__="${gid}" \
       --build-arg __TIMEZONE__="${MY_TIMEZONE}" \
       -t ${name} \
       -f Dockerfile $PWD


