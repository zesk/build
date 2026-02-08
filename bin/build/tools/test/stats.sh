#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Argument: handler - Function. Required. Error handler.
# Argument: statsDirectory - Directory. Required. Directory to scan.
# Argument: statsFile ... - File. Required. File to count lines.
__collectStats() {
  local handler="$1" && shift
  local statsDirectory="$1" && shift
  [ -d "$statsDirectory" ] || throwArgument "$handler" "statsDirectory is not a directory" || return $?
  while [ $# -gt 0 ]; do
    local f="$statsDirectory/$1" v=0
    [ ! -f "$f" ] || v=$(catchReturn "$handler" fileLineCount "$f") || return $?
    catchReturn "$handler" environmentValueWrite "$1" "$v" || return $?
    shift
  done
}
