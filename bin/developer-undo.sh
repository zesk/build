#!/usr/bin/env bash
#
# developer.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Zesk Developer scripts

if isFunction __buildConfigureUndo; then
  __buildConfigureUndo
fi

unset __buildConfigureUndo 2>/dev/null
