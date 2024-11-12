#!/usr/bin/env bash
# Version of composer to use for building vendor directory
# Copyright &copy; 2024 Market Acumen, Inc.
# Type: String
# Default: latest
# See: phpComposer
# Category: Development
export BUILD_COMPOSER_VERSION
BUILD_COMPOSER_VERSION="${BUILD_COMPOSER_VERSION-latest}"
