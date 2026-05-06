#!/usr/bin/env bash
# Name: Build Hook Extension List
# Copyright &copy; 2026 Market Acumen, Inc.
# Type: ColonDelimitedList
# Category: Application
# List of extensions to run when looking for hooks
export BUILD_HOOK_EXTENSIONS
BUILD_HOOK_EXTENSIONS="${BUILD_HOOK_EXTENSIONS-sh}"
