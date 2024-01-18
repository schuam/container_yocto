# Yocto Container

In order to build a Yocto project, you need a build host that has a bunch of
packages installed. If you look into the [Setting Up a Native Linux
Host](https://docs.yoctoproject.org/dev-manual/start.html#setting-up-a-native-linux-host)
section of Yocto's [Development Tasks
Manual](https://docs.yoctoproject.org/dev-manual/index.html), you will find the
sentence: "Collectively, the number of required packages is large if you want
to be able to cover all cases." You can find the list of required packages
[here](https://docs.yoctoproject.org/ref-manual/system-requirements.html#required-packages-for-the-build-host).

I few reasons kept me from installing all the packages on my machine:

- You can find lists of required packages (under the mentioned link) for
  Ubuntu/Debian, Fedora, open SUSE and AlmaLinux. But I run Arch and I didn't
  want to deal with looking for replacements for the packages that might not
  exist in Arch's packages repositories.
- I like to keep my system at least kind of clean. I kind of try to
  "containerize" thinks for special applications/scenarios. This also allows me
  to quickly get running with e.g. Yocto in case I need to switch machines or
  in cases where the build process runs on a separate CI/CD server.

So, I needed a Container. I know, I could have gone with the CROPS solution
mentioned in the [Setting Up to Use CROss PlatfomrS
(CROPS)](https://docs.yoctoproject.org/dev-manual/start.html#setting-up-to-use-cross-platforms-crops)
of Yocto's [Development Tasks
Manual](https://docs.yoctoproject.org/dev-manual/index.html), but for some
reason, I wanted to set up my own. One reason might have been, that I didn't
read the Development Tasks Manual, before I started setting up the container
:-).

Anyways, how do you use this container? -> Read the next section.


## Usage

You can find the image on
[dockerhub](https://hub.docker.com/r/schuam/docker_yocto) and pull use the
`docker pull` command from stated there or you can clone this git repo and
build the image yourself.

Since `bitbake` should not be run as root (see
[here](https://wiki.yoctoproject.org/wiki/Technical_FAQ#Why_can't_I_run_bitbake_as_root?)),
I added an additional user called `developer` to the container image. This user
has its own home directory and the default container workdir is set to a
directory called "workdir" in the developers home directory
(/home/developer/workdir).

While the `/home/developer/workdir` exists, I still advise to not mount your
project directory into that workdir. The reason is that `bitbake` uses apsolute
paths in differnt parts of a build project. So you might end up with links in
your build directory that work inside the container, but not on your host
machine. This might be fine, but I don't like it. That's way I use the command
a little further down to run the container.

I wrote a [post](https://schuam.de/en/posts/769d48ed26.html) about how I like
to set up the directory structure for Yocto projects. In case you do it the
same way, you should be able to run the following command as is, otherwise you
might have to figure out, how do mount your project directory inside the
container.

```
docker run -it --rm -v .:`pwd` --workdir=`pwd` <IMAGE_NAME>:<TAG>
```

Adjust the `<IMAGE_NAME>` and <TAG>. It depends on how you got the image.

In case the directories in which bitbakes stores downloaded files and shared
state files are not within your project directory, modify the `docker run`
command a little bit (the `DL_DIR` and `SSTATE_DIR` variables in your
`local.conf` file have to be set up accordingly):

```
docker run \
    -it --rm \
    -v .:`pwd` --workdir=`pwd` \
    -v /path/to/downloads/dir:`pwd`/bitbake/downloads \
    -v /path/to/sstate-cache/dir:`pwd`/bitbake/sstate-cache \
    --workdir=`pwd` \
    <IMAGE_NAME>:<TAG>
```

Inside the container, you should be able to work with yocto or better `bitbake`
as you are used to (at least as long as you cloned the `poky` repository inside
your project directory) or mounted it somehow somewhere else in the container.

