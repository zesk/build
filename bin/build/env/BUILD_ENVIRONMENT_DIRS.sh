#!/usr/bin/env bash
# Name: Build Environment Directory List
# Search directory for environment definition files. `:` separated.
# Note these should be *in addition* to the default environment variables ALWAYS located at `./bin/build/env`
# THe default is `$(buildHome)/bin/env`. Make sure to append to this as a `:`-list.
# Type: DirectoryList
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Build Configuration

# shellcheck source=/dev/null
export BUILD_ENVIRONMENT_DIRS
BUILD_ENVIRONMENT_DIRS="${BUILD_ENVIRONMENT_DIRS-"bin/env:bin/build/env"}"
