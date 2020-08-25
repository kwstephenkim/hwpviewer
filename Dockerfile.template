FROM ubuntu:18.04
ARG __USER__="docker"
ARG __GROUP__="docker"
ARG __UID__="1000"
ARG __GID__="1000"
ARG __TIMEZONE__="America/Los_Angeles"
ARG __HANCOM__="hancomoffice-hwpviewer-Ubuntu-amd64.deb"
ARG DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND=noninteractive
RUN echo ${__TIMEZONE__}
RUN apt update -y
RUN ln -snf /usr/share/zoneinfo/${__TIMEZONE__} /etc/localtime && echo ${__TIMEZONE__} > /etc/timezone
RUN apt install -y sudo build-essential emacs gedit
RUN apt install -y openssh-client openssh-server apache2 subversion git emacs
RUN apt install -y curl python zip unzip libfdt-dev libfdt1 libwebkitgtk-3.0 gvfs
RUN service ssh restart
COPY hwpviewer.sh /usr/bin/hwpviewer.sh
COPY ${__HANCOM__} .
RUN dpkg -i ${__HANCOM__} && rm -f ${__HANCOM__}
RUN echo "root:sophia_corynn" | chpasswd
RUN groupadd -g ${__GID__} ${__GROUP__} || true
RUN useradd -m \
    -G sudo -s /bin/bash -g ${__GID__} -u ${__UID__} ${__USER__}
RUN echo "${__USER__}:sophia_corynn" | chpasswd
USER ${__USER__}
WORKDIR /home/${__USER__}
CMD ["hwpviewer.sh"]

