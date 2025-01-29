#!/usr/bin/env bash
#
# developer.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Zesk Developer scripts

__buildAliasesUndo() {

  unalias t 2>/dev/null
  unalias tools 2>/dev/null
}

__buildAliasesUndo

unset buildPreRelease
