#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Utility to check source code for identical sections which MUST match to succeed.
#
# See: identicalCheck
"$(dirname "${BASH_SOURCE[0]}")/tools.sh" identicalCheck "$@"
