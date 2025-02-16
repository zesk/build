#!/usr/bin/env bash
# BUILD_HOME at . where this is installed at ./bin/build
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Build Configuration
# Type: Directory
export BUILD_HOME

BUILD_HOME="${BUILD_HOME-}"
if [ -z "$BUILD_HOME" ]; then
  BUILD_HOME="$(printf -- "%s\n" "$(cd "${BASH_SOURCE[0]%/*}/../../.." && pwd || printf -- "%s\n" "Unable to determine BUILD_HOME: $(pwd)")")"
  if [ ! -d "$BUILD_HOME" ]; then
    printf "%s\n" "Unable to determine BUILD_HOME - system is unstable: $BUILD_HOME" 1>&2
  fi
fi
