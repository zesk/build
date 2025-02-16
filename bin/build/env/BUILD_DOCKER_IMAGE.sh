#!/usr/bin/env bash
# Default docker image to use when launching `dockerLocalContainer`
# See: dockerLocalContainer
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Docker
# Type: String
export BUILD_DOCKER_IMAGE
BUILD_DOCKER_IMAGE=${DOCKER_LOCAL_IMAGE:-ubuntu:latest}
