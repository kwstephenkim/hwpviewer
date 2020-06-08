# hwpviewer

The goal is to provide a docker container that runs hwpviewer as much seamlessly as possible.

## Background

We, Koreans, do know so well that we need an hwp viewer. Sadly, the government agencies, banks, schools, etc, do not have any hesitation to force the people to use a proprietary software owned by Hancom. That happens by providing documents in forms of .hwp. If it were .doc, there are a lot of readers out there. As it is .hwp, anything but hwp viewer does not seem to work nicely, especially on Linux. 

The thing is Hancom has more interest in Windows and Mac as most of the users do not use Linux. As Korean essential services are not available for Linux users, Koreans use Linux less.

The "hwp viewer" has not been updated for Linux in a fast pace; it does not work with latest Ubuntu. It is actually challenging to get it work on other Linux distros such as Gentoo. 

## What's Done

In a nutshell, a docker container is built with the host user information in order that the sharing between the host and the container is easy. As hwp viewer is an X application, the container should be run with a couple of additional arguments for that. 

## Prerequisite

Docker is required. 

```
docker run hell-world
```

This involves docker image build and run. Thus, docker should be
installed per host distro. For Gentoo, perhaps:

```
$ emerge -v docker
```

Besides, the hwp viewer .deb package is required as well. For reasons, the .deb package should be downloaded manually:

 [https://www.hancom.com/cs_center/csDownload.do](https://www.hancom.com/cs_center/csDownload.do)

Hancom does not allow re-distribution. Curl or Wget do not appear to work to download the .deb package. Find something for Ubuntu. 


## Build

Basically, git clone, download hwpviewer deb file, and run
gen-dockerfile.sh.

Let's do git clone, and cd to the directory:
```
$ git clone https://github.com/kwstephenkim/hwpviewer.git
$ cd hwpviewer
```

As the HWP viewer is proprietary software owned by Hancom, the user
has to download it from Hancom website. We assume the file name is
this:
  hancomoffice-hwpviewer-Ubuntu-amd64.deb

The file should be in the hwpviewer directory.

Now, run the gen-dockerfile.sh script:
```
$ ./gen-dockerfile.sh --help
$ ./gen-dockerfile.sh myhwpviewer:1.0
```

Note that it builds a docker container with the host user's
credentials except password. The default password is, as shown in the
Dockerfile, sophiacorynn.

# Run

The docker container has the host user with the same uid. It also has
/home/$USER like the host. Thus, it would be convenient to mount some
host volumes to the docker container.

```
$ run-my-docker.sh --help
$ run-my-docker.sh myhwpviewer:1.0
```

Basicallt, the script, and in turn, the container will run hwpviewer.

If you are not familiar with docker, please note that all directories
that hwpviewer sees are not in the host system, which means
useless. To be useful, add -v options:

```
$ run-my-docker.sh myhwpviewer:1.0 -v$HOME/workspace:$HOME/workspace -v$HOME/mine:$HOME/yours
```

Firstly, the host $HOME/workspace is shared, and found by hwpviewer as $HOME/workspace. $HOME/mine on the host is shared but it goes in the container by different path: $HOME/yours.

Please do not give -v$HOME:$HOME if you are unsure what you are doing. You could do -v$HOME:$HOME/any

