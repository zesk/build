#!/usr/bin/env bash
#
# Load build system - part of zesk/build
#
# Deprecated, use `install-bin-build.sh`
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
echo "$(basename $0) is deprecated, use install-bin-build.sh" 1>&2
"$(dirname ${BASH_SOURCE[0]})/install-bin-build.sh" "$@"
