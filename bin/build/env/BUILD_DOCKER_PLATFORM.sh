#!/usr/bin/env bash
# See: dockerLocalContainer
# Category: Docker
# Copyright &copy; 2025 Market Acumen, Inc.
#
# The platform for `dockerLocalContainer`
#
# Contacts of this can be found via `docker buildx ls`
#
# Valid values are:
#
# - `linux/arm64`
# - `linux/amd64`
# - `linux/amd64/v2`
# - `linux/riscv64`
# - `linux/ppc64le`
# - `linux/s390x`
# - `linux/386`
# - `linux/mips64le`
# - `linux/mips64`
# - `linux/arm/v7`
# - `linux/arm/v6`
#
# If not specified, uses the default for the current platform.
#
# See: dockerPlatformDefault
# Type: String
export BUILD_DOCKER_PLATFORM
BUILD_DOCKER_PLATFORM=${BUILD_DOCKER_PLATFORM-}
