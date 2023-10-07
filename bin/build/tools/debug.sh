#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: -
# bin: set test

buildDebugEnabled() {
    test "${BUILD_DEBUG-}"
}
buildDebugStart() {
    if buildDebugEnabled; then
        set -x # Outputs each command for debugging
    fi
}
buildDebugStop() {
    if buildDebugEnabled; then
        set +x # Debugging off
    fi
}
