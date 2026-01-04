#!/usr/bin/env bash
#
# Debian-specific
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__pcregrep() {
  pcre2grep "$@"
}

__pcregrepBinary() {
  printf "%s\n" pcre2grep
}

__pcregrepPackage() {
  printf "%s\n" pcre2-utils
}
