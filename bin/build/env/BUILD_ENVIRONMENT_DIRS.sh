#!/usr/bin/env bash
# Search directory for environment definition files. `:` separated.
# Note these should be *in addition* to the default environment variables ALWAYS located at `$(buildHome)/bin/build/env`
# THe default is `$(buildHome)/bin/env`. Make sure to append to this as a `:`-list.
# Type: DirectoryList
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Build Configuration
# See: https://specifications.freedesktop.org/basedir-spec/latest/

# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/BUILD_HOME.sh"
export BUILD_ENVIRONMENT_DIRS
BUILD_ENVIRONMENT_DIRS=${BUILD_ENVIRONMENT_DIRS-"$BUILD_HOME/bin/env"}
