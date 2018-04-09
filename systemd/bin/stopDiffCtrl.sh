#!/usr/bin/env bash

set -u

if [ -z "$DIFF_INSTANCE" ]; then
    echo "DIFF_INSTANCE environment variable is not set." >&2
    exit 1
fi

/usr/bin/docker stop \
    diff-ctrl-epics-ioc-${DIFF_INSTANCE}
