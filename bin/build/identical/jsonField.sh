#!/bin/bash
#
# Identical template
#
# Original of jsonField
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# _IDENTICAL_ jsonField EOF

# Fetch a non-blank field from a JSON file with error handling
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: handler - Function. Required. Error handler.
# Argument: jsonFile - File. Required. A JSON file to parse
# Argument: ... - Arguments. Optional. Passed directly to jq
# stdout: selected field
# stderr: error messages
# Return Code: 0 - Field was found and was non-blank
# Return Code: 1 - Field was not found or is blank
# Requires: jq whichExists __throwEnvironment printf rm decorate head
jsonField() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local handler="$1" jsonFile="$2" value message && shift 2

  [ -f "$jsonFile" ] || __throwEnvironment "$handler" "$jsonFile is not a file" || return $?
  whichExists jq || __throwEnvironment "$handler" "Requires jq - not installed" || return $?
  if ! value=$(jq -r "$@" <"$jsonFile"); then
    message="$(printf -- "%s\n%s\n" "Unable to fetch selector $(decorate each code -- "$@") from JSON:" "$(head -n 100 "$jsonFile")")"
    __throwEnvironment "$handler" "$message" || return $?
  fi
  [ -n "$value" ] || __throwEnvironment "$handler" "$(printf -- "%s\n%s\n" "Selector $(decorate each code -- "$@") was blank from JSON:" "$(head -n 100 "$jsonFile")")" || return $?
  printf -- "%s\n" "$value"
}
_jsonField() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
