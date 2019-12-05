#!/bin/bash
set -ve
#UPDATE TO YOUR ACCOUNT AND TAG
BUILDER_IMAGE=XXXXXXXXXXXX.dkr.ecr.us-west-2.amazonaws.com/xxx-build:1.0.13

test -t 1 && USE_TTY="-t"

command="make $@"

docker run \
    -i \
    ${USE_TTY} \
    -v $(pwd):/working \
    -w /working \
    -e ENV=$ENV \
    ${BUILDER_IMAGE} \
    bash -c "$command"