#!/usr/bin/env bash
# Name: Composer Version
# Version of composer to use for building vendor directory
# Copyright &copy; 2026 Market Acumen, Inc.
# Type: String
# Default: latest
# See: phpComposer
# Category: Installation
export BUILD_COMPOSER_VERSION
BUILD_COMPOSER_VERSION="${BUILD_COMPOSER_VERSION-latest}"
