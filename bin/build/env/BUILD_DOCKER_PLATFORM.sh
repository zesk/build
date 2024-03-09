#!/usr/bin/env bash
# See: dockerLocalContainer
# Copyright &copy; 2024 Market Acumen, Inc.
# > docker buildx ls
# linux/arm64,
# linux/amd64,
# linux/amd64/v2,
# linux/riscv64,
# linux/ppc64le,
# linux/s390x,
# linux/386,
# linux/mips64le,
# linux/mips64,
# linux/arm/v7,
# linux/arm/v6
export BUILD_DOCKER_PLATFORM
_BUILD_DOCKER_PLATFORM() {
  local os=linux chip
  case "$(uname -m)" in
    *arm*) chip=arm64 ;;
    *mips*) chip=mips64 ;;
    *x86* | *amd*) chip=amd64 ;;
    *) chip=default ;;
  esac
  printf "%s/%s" "$os" "$chip"
}
BUILD_DOCKER_PLATFORM=${BUILD_DOCKER_PLATFORM:-"$(_BUILD_DOCKER_PLATFORM)"}

# ~/marketruler/devops 👉 docker buildx ls
# NAME/NODE       DRIVER/ENDPOINT STATUS  BUILDKIT             PLATFORMS
# default         docker
#   default       default         running v0.11.7+d3e6c1360f6e linux/arm64, linux/amd64, linux/amd64/v2, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/mips64le, linux/mips64, linux/arm/v7, linux/arm/v6
# desktop-linux * docker
#   desktop-linux desktop-linux   running v0.11.7+d3e6c1360f6e linux/arm64, linux/amd64, linux/amd64/v2, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/mips64le, linux/mips64, linux/arm/v7, linux/arm/v6
