#!/usr/bin/env bash
#
# Ubuntu-specific
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__pcregrep() {
  pcre2grep "$@"
}

__pcregrepBinary() {
  printf "%s\n" pcre2grep
}

