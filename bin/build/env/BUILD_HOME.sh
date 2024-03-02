#!/usr/bin/env bash
# Constant for turning debugging on during build to find errors in the build scripts.
# Copyright &copy; 2024 Market Acumen, Inc.
export BUILD_HOME

BUILD_HOME="${BUILD_HOME-}"

if [ ! -d "$BUILD_HOME " ]; then
  if ! BUILD_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"; then
    printf "%s\n" "Unable to determine BUILD_HOME - system is unstable" 1>&2
  fi
fi
