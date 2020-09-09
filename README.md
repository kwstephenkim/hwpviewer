# hwpviewer

The goal is to provide a docker container that runs hwpviewer as much seamlessly as possible.

## Background

We, Koreans, do know so well that we need an hwp viewer. Sadly, the
government agencies, banks, schools, etc, do not have any hesitation
to force the people to use a proprietary software owned by
Hancom. Very often, the must-read documents are distributed in forms
of .hwp; hwpviewer seems to be the only solid software that runs
locally and successfully parses the file format.

The thing is that Hancom has more interest in Windows and Mac as most of
the users do not use Linux. As Korean essential services are not
available for Linux users, Koreans use Linux less.

The "hwpviewer" update for Linux has not been fast-paced. It does not
support wide variety of Linux distributions. It does not support
latest versions of Debian and/or Ubuntu. 

## What's Done

In a nutshell, a docker container is built, where the host user
information is made available for the container. Thus, the X server
running on the host is shared by the docker container. Effectively,
the hwpviewer inside the container would behave as if it was a host
local X application.

## Prerequisite

This command should complete successfully:

```
docker run hell-world
```

For this, docker must be available on the system.

This involves docker image build and run. Thus, docker should be
installed per host distro. For Gentoo, perhaps:

```
$ emerge -v docker
```

Also, you might have to consider this:
```
$ sudo gpasswd -a $USER docker
```

Besides, the hwp viewer .deb package is required as well. For reasons,
the .deb package should be downloaded manually:

 [https://www.hancom.com/cs_center/csDownload.do](https://www.hancom.com/cs_center/csDownload.do)

Hancom does not allow re-distribution. Curl or Wget do not appear to
work to download the .deb package. Find the .deb package for Ubuntu,
download it, and move it to the git-clone'd directory.


## Build

Basically, git clone, download hwpviewer deb file to the directory, and make.

```
$ git clone https://github.com/kwstephenkim/hwpviewer.git
$ cd hwpviewer
```

As the HWP viewer is proprietary software owned by Hancom, the user
has to download it from Hancom website. We assume the file name is
this:
  hancomoffice-hwpviewer-Ubuntu-amd64.deb

The file should be in the hwpviewer directory. If the file name is
different, Dockerfile should be modified.

Now, run simply run "make" for the first time:
```
$ make
```

Afterwards:
```
$ make run
```

The script is a bit more complicated than needed. It's just because I have modified another Dockerfile I used for different purposes.
