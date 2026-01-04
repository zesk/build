#!/usr/bin/env bash
# If this value is non-blank, then console `statusMessage`s are just output normally.
# See: statusMessage
# See: hasConsoleAnimation
# Continuous Integration - this is set to a non-blank value in:
#
# - Bitbucket pipelines
#
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Continuous Integration
# Type: String
export CI
CI="${CI-}"
