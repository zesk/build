#!/usr/bin/env bash
#
# Ubuntu-specific
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__pcregrep() {
  pcre2grep "$@"
}

__pcregrepBinary() {
  printf "%s\n" pcre2grep
}
