#!/usr/bin/env bash
# Time when a build was initiated, set upon first invocation if not already
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Deployment
export BUILD_TIMESTAMP
BUILD_TIMESTAMP="${BUILD_TIMESTAMP:-$(($(date +%s) + 0))}"
