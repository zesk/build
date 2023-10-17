#!/bin/bash

docker run --platform linux/arm64 -v "$(pwd):/opt/atlassian/bitbucketci/agent/build" -it atlassian/default-image:4
