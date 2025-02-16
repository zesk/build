#!/usr/bin/env bash
# Number of versions tags (d0, d1, d2, etc.) to look for before giving up in `git-tag-version`
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Build Configuration
# Type: List
export BUILD_PRECOMMIT_EXTENSIONS
BUILD_PRECOMMIT_EXTENSIONS="${BUILD_PRECOMMIT_EXTENSIONS:-"sh php js json md yml txt"}"
