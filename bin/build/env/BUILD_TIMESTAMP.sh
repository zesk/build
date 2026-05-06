#!/usr/bin/env bash
# Name: Build Timestamp
# Time when a build was initiated, set upon first invocation if not already
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Deployment
# Type: UnsignedInteger
export BUILD_TIMESTAMP
BUILD_TIMESTAMP="${BUILD_TIMESTAMP:-$(($(date +%s) + 0))}"
