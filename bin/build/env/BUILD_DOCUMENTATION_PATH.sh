#!/usr/bin/env bash
# Name: Build Documentation Path List
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Bash
# Type: DirectoryList
# Search path for documentation settings file.
# A colon `:` separated list of paths to search for function documentation settings file for `__bashDocumentationCached`
# See: __bashDocumentationCached
export BUILD_DOCUMENTATION_PATH
BUILD_DOCUMENTATION_PATH="bin/build/documentation:${BUILD_DOCUMENTATION_PATH-}"
BUILD_DOCUMENTATION_PATH="${BUILD_DOCUMENTATION_PATH%:}"
