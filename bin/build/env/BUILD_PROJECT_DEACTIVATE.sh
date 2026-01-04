#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Type: Function
# Category: Application
# Set this to a function which cleans up the project context and
# will be run on `project-deactivate` hook which is sourced.
export BUILD_PROJECT_DEACTIVATE
BUILD_PROJECT_DEACTIVATE="${BUILD_PROJECT_DEACTIVATE-}"
