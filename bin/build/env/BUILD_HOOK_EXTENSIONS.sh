#!/usr/bin/env bash
# List of extensions to look for in BUILD_HOOK_DIRS for hooks. Allows adding other language extensions (e.g. `py`, `php` etc.)
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Build Configuration
# Type: ColonDelimitedList
export BUILD_HOOK_EXTENSIONS
BUILD_HOOK_EXTENSIONS=${BUILD_HOOK_EXTENSIONS-":sh:bash"}
