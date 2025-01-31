#!/usr/bin/env bash
# BUILD_INSTALL_URL for `installInstallBuild`
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Hook
# Type: DirectoryList
export BUILD_HOOK_PATH
BUILD_HOOK_PATH=${BUILD_HOOK_PATH-"bin/hooks:bin/build/hooks"}
