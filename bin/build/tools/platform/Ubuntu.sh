#!/usr/bin/env bash
#
# Ubuntu-specific
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__pcregrep() {
  pcregrep "$@"
}

__pcregrepBinary() {
  printf "%s\n" pcregrep
}

__pcregrepInstall() {
  packageWhich pcregrep pcregrep || return $?
}
