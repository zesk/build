#!/usr/bin/env bash
# Time when a build was initiated, set upon first invocation if not already
# Copyright &copy; 2024 Market Acumen, Inc.
export BUILD_DATE_INITIAL
BUILD_DATE_INITIAL=${BUILD_DATE_INITIAL-$(($(date +%s) + 0))}
