#!/usr/bin/env bash
#
# Syntactic Sugar makes coding fun
#
# EDIT THIS FILE
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/_sugar.md
# Test: o ./test/tools/sugar-tests.sh
#
# -- CUT BELOW HERE --

# _IDENTICAL_ _text EOF

# Quote grep -e patterns for shell use
#
# Argument: text - EmptyString. Required. Text to quote.
# Output: string quoted and appropriate to insert in a grep search or replacement phrase
# Example:     grep -e "$(quoteGrepPattern "$pattern")" < "$filterFile"
# Requires: printf sed
quoteGrepPattern() {
  local value="${1-}"
  value=$(printf "%s\n" "$value" | sed 's/\([\\.*+?]\)/\\\1/g')
  value="${value//[/\\[}"
  value="${value//]/\\]}"
  value="${value//)/\\)}"
  value="${value//(/\\(}"
  value="${value//|/\\|}"
  value="${value//$'\n'/\\n}"
  printf "%s\n" "$value"
}
