#!/bin/bash
#
# Original of quoteSedPattern
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL quoteSedPattern EOF

# Summary: Quote sed search strings for shell use
# Quote a string to be used in a sed pattern on the command line.
# Argument: text - EmptyString. Required. Text to quote
# Output: string quoted and appropriate to insert in a sed search or replacement phrase
# Example:     sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"
# Example:     needSlash=$(quoteSedPattern '$.*/[\]^')
# Requires: printf sed
quoteSedPattern() {
  local value
  value=$(printf -- "%s\n" "${1-}" | sed 's~\([][$/'$'\t''^\\.*+?]\)~\\\1~g')
  value="${value//$'\n'/\\n}"
  printf -- "%s\n" "$value"
}

# Summary: Quote sed replacement strings for shell use
# Usage: quoteSedReplacement text separatorChar
# Argument: text - EmptyString. Required. Text to quote
# Argument: separatorChar - The character used to separate the sed pattern and replacement. Defaults to `/`.
# Output: string quoted and appropriate to insert in a sed search or replacement phrase
# Example:     sed "s/$(quoteSedPattern "$1")/$(quoteSedReplacement "$2")/g"
# Example:     needSlash=$(quoteSedPattern '$.*/[\]^')
# Requires: printf sed
quoteSedReplacement() {
  local value separator="${2-/}"
  value=$(printf -- "%s\n" "${1-}" | sed 's~\([\&'"$separator"']\)~\\\1~g')
  value="${value//$'\n'/\\n}"
  printf -- "%s\n" "$value"
}
