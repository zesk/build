#!/usr/bin/env bash
# BUILD_INSTALL_URL for `installInstallBuild`
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Hook
# Type: ApplicationDirectoryList
export BUILD_HOOK_DIRS
BUILD_HOOK_DIRS=${BUILD_HOOK_DIRS-"bin/hooks:bin/build/hooks"}
