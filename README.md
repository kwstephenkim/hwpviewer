# hwpviewer

The goal is to provide a docker container that runs hwpviewer as much seamlessly as possible.

한컴 뷰어를 리눅스 응용 프로그램처럼 실행할 수 있도록 해주는 프로젝트입니다.

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

한컴 뷰어는 우분투와 데비안, 그것도 약간 오래된 버전에서만 제대로 동작합니다. 굳이 동작하게
만드는 게 보통 어렵지 않은 일입니다만, 번잡한 일입니다. 불행히도 뷰어는 업데이트가 잦지 않습니다.

docker container는 이런 문제를 해결하기에 적합한 해법의 하나입니다.

## What's Done

In a nutshell, a docker container is built, where the host user
information is made available for the container. Thus, the X server
running on the host is shared by the docker container. Effectively,
the hwpviewer inside the container would behave as if it was a host
local X application.

요컨대, 오래된 우분투 배포판으로 만든 docker image에 한컴 패키지를 설치한 후, 호스트
의 X server를 container와 공유합니다.

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

위의 명령어를 보고 따라하세요. docker가 설치되어 있어야 하고, hello-world를 할 수 있어야 하며, 한컴
사이트에서 .deb 패키지를 다운받아야 합니다. 우분투용을 받으시면 됩니다.

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

빌드는 git clone으로 이 저장소의 소스를 받고, 거기다 한컴에서 받은 deb 파일을 복사한 후, make를 하면 됩니다.

실행은 거기서 make run을 해주면 됩니다.
