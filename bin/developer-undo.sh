#!/usr/bin/env bash
#
# developer.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Zesk Developer scripts

if isFunction __buildAliasesUndo; then
  __buildAliasesUndo
fi

unset buildPreRelease __buildAliasesUndo 2>/dev/null
