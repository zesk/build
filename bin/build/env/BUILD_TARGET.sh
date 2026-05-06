#!/usr/bin/env bash
# Name: Build Application Target File Name
# The file to generate when generating builds
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Deployment
# Type: String
# Default: app.tar.gz
export BUILD_TARGET
BUILD_TARGET=${BUILD_TARGET:-app.tar.gz}
