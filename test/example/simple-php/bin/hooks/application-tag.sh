#!/bin/bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__applicationTag() {
  bins=(md5sum md5)
  for bin in "${bins[@]}"; do
    if which "$bin" >/dev/null; then
      sum="$("$bin" <./composer.lock | awk '{ print $1 }')"
      printf %s "${sum:0:8}"
      return 0
    fi
  done
}

__applicationTag "$@"
