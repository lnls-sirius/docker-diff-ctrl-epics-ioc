Docker image to run the Position Diffence Control Soft EPICS IOC
==================================================================

This repository contains the Dockerfile used to create the Docker image to run the
[Soft EPICS IOC for Position Difference Control](https://github.com/lnls-dig/diff-ctrl-epics-ioc).

## Running the IOC

The simples way to run the IOC is to run:

    docker run --rm -it --net host lnlsdig/diff-ctrl-epics-ioc -l CTRL_LEFT -r CTRL_RIGHT

where `CTRL_LEFT` is the prefix used for the left slit, or scraper, side's controller
and `CTRL_RIGHT` is the prefix used for the right slit, or scraper, side's controller.
The options you can specify (after `lnlsdig/diff-ctrl-epics-ioc`) are:

- `-l CTRL_LEFT`: the prefix of the left slit, or scraper, side's controller IOC
- `-r CTRL_RIGHT`: the prefix of the right slit, or scraper, side's controller IOC
- `-P PREFIX1`: the value of the EPICS `$(P)` macro used to prefix the PV names
- `-R PREFIX2`: the value of the EPICS `$(R)` macro used to prefix the PV names
- `-g EGU`: the value of the engineering units displayed

## Creating a Persistent Container

If you want to create a persistent container to run the IOC, you can run a
command similar to:

    docker run -it --net host --restart always --name CONTAINER_NAME lnlsdig/diff-ctrl-epics-ioc -l CTRL_LEFT -r CTRL_RIGHT

where `CTRL_LEFT` and `CTRL_RIGHT` are as in the previous section and `CONTAINER_NAME`
is the name given to the container. You can also use the same options as described in the
previous section.

## Building the Image Manually

To build the image locally without downloading it from Docker Hub, clone the
repository and run the `docker build` command:

    git clone https://github.com/lnls-dig/docker-diff-ctrl-epics-ioc
    docker build -t lnlsdig/diff-ctrl-epics-ioc docker-diff-ctrl-epics-ioc
