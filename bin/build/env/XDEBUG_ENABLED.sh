#!/usr/bin/env bash
# Copyright &copy; 2025 Market Acumen, Inc.
# Type: Boolean
# Category: PHP
# Vendor: xdebug
# Is xdebug enabled? Calling application can honor this environment variable to automatically connect to the debugger.
# See: https://github.com/zesk/zesk/blob/master/xdebug.php
export XDEBUG_ENABLED
XDEBUG_ENABLED="${XDEBUG_ENABLED-}"
