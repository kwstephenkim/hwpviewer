IMG_NAME="myhwpviewer:1.0"
HOST_HOME="host"

.PHONY: all build run

all: build run

build: Dockerfile gen-dockerfile.sh hwpviewer.sh
	./gen-dockerfile.sh ${IMAGE_NAME}

run: run-my-docker.sh
	./run-my-docker.sh ${IMG_NAME} -v$$HOME:/$$HOME/$(HOST_HOME)
