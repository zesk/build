#!/usr/bin/env bash
# BUILD_HOME at . where this is installed at ./bin/build
# Copyright &copy; 2024 Market Acumen, Inc.
export BUILD_HOME

BUILD_HOME="${BUILD_HOME-}"
if [ -z "$BUILD_HOME" ]; then
  __buildHome() {
    # shellcheck disable=SC2015
    printf "%s\n" "$(cd "${BASH_SOURCE[0]%/*}/../../.." && pwd || printf "%s\n" "Unable to determine BUILD_HOME: $(pwd)")"
  }
  BUILD_HOME="$(__buildHome)"
  if [ -z "$BUILD_HOME" ]; then
    printf "%s\n" "Unable to determine BUILD_HOME - system is unstable" 1>&2
    false
  fi
fi
