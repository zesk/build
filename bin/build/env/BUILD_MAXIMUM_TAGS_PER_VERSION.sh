#!/usr/bin/env bash
# Number of versions tags (d0, d1, d2, etc.) to look for before giving up in `git-tag-version`
# Copyright &copy; 2024 Market Acumen, Inc.
# Category: Deployment
export BUILD_MAXIMUM_TAGS_PER_VERSION
BUILD_MAXIMUM_TAGS_PER_VERSION="${BUILD_MAXIMUM_TAGS_PER_VERSION:-1000}"
