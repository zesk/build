#!/usr/bin/env bash
# List of directories to search for hooks. Defaults to `bin/hooks:bin/build/hooks`.
# Colon (`:`) separated list.
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Build Configuration
# Type: ApplicationDirectoryList
export BUILD_HOOK_DIRS
BUILD_HOOK_DIRS=${BUILD_HOOK_DIRS-"bin/hooks:bin/build/hooks"}
