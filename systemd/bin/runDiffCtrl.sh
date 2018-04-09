#!/usr/bin/env bash

set -u

if [ -z "$DIFF_INSTANCE" ]; then
    echo "DIFF_INSTANCE environment variable is not set." >&2
    exit 1
fi

export DIFF_CURRENT_PV_AREA_PREFIX=DIFF_${DIFF_INSTANCE}_PV_AREA_PREFIX
export DIFF_CURRENT_PV_DEVICE_PREFIX=DIFF_${DIFF_INSTANCE}_PV_DEVICE_PREFIX
export DIFF_CURRENT_LEFT_CTRL_PREFIX=DIFF_${DIFF_INSTANCE}_LEFT_CTRL_PREFIX
export DIFF_CURRENT_RIGHT_CTRL_PREFIX=DIFF_${DIFF_INSTANCE}_RIGHT_CTRL_PREFIX
export DIFF_CURRENT_EGU=DIFF_${DIFF_INSTANCE}_EGU
# Only works with bash
export DIFF_PV_AREA_PREFIX=${!DIFF_CURRENT_PV_AREA_PREFIX}
export DIFF_PV_DEVICE_PREFIX=${!DIFF_CURRENT_PV_DEVICE_PREFIX}
export DIFF_LEFT_CTRL_PREFIX=${!DIFF_CURRENT_LEFT_CTRL_PREFIX}
export DIFF_RIGHT_CTRL_PREFIX=${!DIFF_CURRENT_RIGHT_CTRL_PREFIX}
export DIFF_EGU=${!DIFF_CURRENT_EGU}

# Create volume for autosave and ignore errors
/usr/bin/docker create \
    -v /opt/epics/startup/ioc/diff-ctrl-epics-ioc/iocBoot/iocDiffCtrl/autosave \
    --name diff-ctrl-epics-ioc-${DIFF_INSTANCE}-volume \
    lnlsdig/diff-ctrl-epics-ioc:${IMAGE_VERSION} \
    2>/dev/null || true

# Remove a possible old and stopped container with
# the same name
/usr/bin/docker rm \
    diff-ctrl-epics-ioc-${DIFF_INSTANCE} || true

/usr/bin/docker run \
    --net host \
    -t \
    --rm \
    --volumes-from diff-ctrl-epics-ioc-${DIFF_INSTANCE}-volume \
    --name diff-ctrl-epics-ioc-${DIFF_INSTANCE} \
    lnlsdig/diff-ctrl-epics-ioc:${IMAGE_VERSION} \
    -l "${DIFF_LEFT_CTRL_PREFIX}" \
    -r "${DIFF_RIGHT_CTRL_PREFIX}" \
    -P "${DIFF_PV_AREA_PREFIX}" \
    -R "${DIFF_PV_DEVICE_PREFIX}" \
    -g "${DIFF_EGU}"
