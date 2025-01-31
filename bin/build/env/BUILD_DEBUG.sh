#!/usr/bin/env bash
# Constant for turning debugging on during build to find errors in the build scripts.
# Copyright &copy; 2025 Market Acumen, Inc.
# Enable debugging globally in the build scripts. Set to a comma (`,`) delimited list string to enable specific debugging, or `true` for ALL debugging, `false` (or blank) for NO debugging.
# Category: Build
# Type: CommaDelimitedList
export BUILD_DEBUG="${BUILD_DEBUG-}"
