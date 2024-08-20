#!/bin/bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
bins=(md5sum md5)
for bin in "${bins[@]}"; do
  if which "$bin" >/dev/null; then
    sum="$("$bin" <./composer.lock | awk '{ print $1 }')"
    printf %s "${sum:0:8}"
    exit 0
  fi
done
