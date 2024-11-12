#!/usr/bin/env bash
# If this value is non-blank, then console `statusMessage`s are just output normally.
# See: statusMessage
# See: hasConsoleAnimation
# Continuous Integration - this is set to TRUE in
# - Bitbucket pipelines
# Copyright &copy; 2024 Market Acumen, Inc.
# Category: Continuous Integration
export CI
CI="${CI-}"
