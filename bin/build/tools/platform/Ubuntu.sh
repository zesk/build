#!/usr/bin/env bash
#
# Ubuntu-specific
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__pcregrep() {
  pcregrep "$@"
}

__pcregrepInstall() {
  packageWhich pcregrep pcregrep || return $?
}
