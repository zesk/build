#!/bin/bash
#
# Identical template
#
# Original of usageDocument
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL usageDocumentSimple EOF

# Output a simple error message for a function
# Requires: bashFunctionComment
# Requires: decorate read printf
usageDocumentSimple() {
  local source="${1-}" functionName="${2-}" exitCode="${3-}" color icon="❌" line prefix && shift 3

  case "$exitCode" in 0) icon="🏆" color=info ;; 1) color="error" ;; 2) color="bold-red" ;; *) color="orange" ;; esac
  printf -- "%s [%s] %s\n" "$icon" "$(decorate "code" "$exitCode")" "$(decorate "$color" "$*")"
  while read -r line; do
    printf "%s%s\n" "$prefix" "$(decorate color "$line")"
    prefix=""
  done < <(bashFunctionComment "$source" "$functionName")
  return "$exitCode"
}
usageDocument() {
  usageDocumentSimple "$@"
}
