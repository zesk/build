#!/usr/bin/env bash
#
# Debian-specific
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__pcregrep() {
  pcre2grep "$@"
}

__pcregrepInstall() {
  packageWhich pcre2grep pcre2-utils || return $?
}
