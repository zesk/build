#!/usr/bin/env bash
#
# Ubuntu-specific
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__pcregrep() {
  pcregrep "$@"
}

__pcregrepBinary() {
  printf "%s\n" pcregrep
}

__pcregrepPackage() {
  printf "%s\n" pcregrep
}
