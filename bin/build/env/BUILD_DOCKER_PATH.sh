#!/usr/bin/env bash
# Default path for the shell to map the current directory to when launching `dockerLocalContainer`
# See: dockerLocalContainer
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Docker
# Type: RemoteDirectory
export BUILD_DOCKER_PATH
BUILD_DOCKER_PATH=${DOCKER_LOCAL_PATH:-"/root/build"}
