#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: -
# bin: set test
# Docs: contextOpen ./docs/_templates/tools/debug.md

#
# Is build debugging enabled?
#
# Usage: buildDebugEnabled
# Exit Code: 1 - Debugging is not enabled
# Exit Code: 0 - Debugging is enabled
# Environment: BUILD_DEBUG - Set to 1 to enable debugging, blank to disable
#
buildDebugEnabled() {
    test "${BUILD_DEBUG-}"
}

#
# Start build debugging if it is enabled.
# This does `set -x` which traces and outputs every shell command
# Use it to debug when you can not figure out what is happening internally.
#
# Usage: buildDebugStart
# Example:     buildDebugStart
# Example:     # ... complex code here
# Example:     buildDebugStop
#
buildDebugStart() {
    if buildDebugEnabled; then
        set -x # Outputs each command for debugging
    fi
}
#
# Stop build debugging if it is enabled
# Usage: buildDebugStop
# See: buildDebugStart
#
buildDebugStop() {
    if buildDebugEnabled; then
        set +x # Debugging off
    fi
}
