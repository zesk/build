#!/usr/bin/env bash
# Number of versions tags (d0, d1, d2, etc.) to look for before giving up in `gitTagVersion`
# Copyright &copy; 2026 Market Acumen, Inc.
# Type: PositiveInteger
# Category: Build Configuration
# See: gitTagVersion
export BUILD_MAXIMUM_TAGS_PER_VERSION
BUILD_MAXIMUM_TAGS_PER_VERSION="${BUILD_MAXIMUM_TAGS_PER_VERSION:-1000}"
