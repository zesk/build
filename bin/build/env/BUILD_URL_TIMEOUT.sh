#!/usr/bin/env bash
# Timeout in seconds for fetching URLs in `urlFetch`
# See: urlFetch
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Build Configuration
# Type: PositiveInteger
export BUILD_URL_TIMEOUT
BUILD_URL_TIMEOUT="${BUILD_URL_TIMEOUT-10}"
