Docker image to run the Position Diffence Control Soft EPICS IOC
==================================================================

This repository contains the Dockerfile used to create the Docker image to run the
[Soft EPICS IOC for Position Difference Control](https://github.com/lnls-dig/diff-ctrl-epics-ioc).

## Running the IOC

The simples way to run the IOC is to run:

    docker run --rm -it --net host lnlsdig/diff-ctrl-epics-ioc -n CTRL_NEG -r CTRL_POS

where `CTRL_NEG` is the prefix used for the slit, or scraper, negative edge controller
and `CTRL_POS` is the prefix used for the slit, or scraper, positive edge controller.

The negative and positive edges are named so to indicate how are their positions
with respect to the beam center. Given that the beam is at position zero,
negative values with greater magnitude increase the distance of the negative edge
from the center, while greater positive position values for the positive edge increase the
distance of it from the beam center.

The options you can specify (after `lnlsdig/diff-ctrl-epics-ioc`) are:

- `-n CTRL_NEG`: the prefix of the negative edge controller IOC
- `-p CTRL_POS`: the prefix of the positive edge controller IOC
- `-P PREFIX1`: the value of the EPICS `$(P)` macro used to prefix the PV names
- `-R PREFIX2`: the value of the EPICS `$(R)` macro used to prefix the PV names
- `-g EGU`: the value of the engineering units displayed
- `-l LOW_LIM`: the low limit for the negative edge position
- `-h HIGH_LIM`: the high limit for the positive edge position

## Creating a Persistent Container

If you want to create a persistent container to run the IOC, you can run a
command similar to:

    docker run -it --net host --restart always --name CONTAINER_NAME lnlsdig/diff-ctrl-epics-ioc -n CTRL_NEG -p CTRL_POS

where `CTRL_NEG` and `CTRL_POS` are as in the previous section and `CONTAINER_NAME`
is the name given to the container. You can also use the same options as described in the
previous section.

## Building the Image Manually

To build the image locally without downloading it from Docker Hub, clone the
repository and run the `docker build` command:

    git clone https://github.com/lnls-dig/docker-diff-ctrl-epics-ioc
    docker build -t lnlsdig/diff-ctrl-epics-ioc docker-diff-ctrl-epics-ioc
