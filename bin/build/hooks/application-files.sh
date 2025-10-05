#!/usr/bin/env bash
#
# Get a complete list of files which make up an application's state.
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# Get a complete list of files which make up an application's state.
# Argument: ... - Arguments. Optional. Arguments are passed to the find command.
__hookApplicationFiles() {
  local handler="_${FUNCNAME[0]}"
  local home

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || returnThrowArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      break
      ;;
    esac
    shift
  done
  home=$(returnCatch "$handler" buildHome) || return $?

  local extensionText
  extensionText=$(returnCatch "$handler" buildEnvironmentGet APPLICATION_CODE_EXTENSIONS) || return $?
  [ -n "$extensionText" ] || returnThrowArgument "$handler" "Requires APPLICATION_CODE_EXTENSIONS to be non-blank" || return $?

  local extensions=()
  IFS=":" read -r -a extensions <<<"$extensionText" || :
  [ "${#extensions[@]}" -gt 0 ] || returnThrowArgument "$handler" "No extensions found in $(decorate code "$extensionText")?" || return $?
  local ff=()
  for extension in "${extensions[@]}"; do
    [ ${#ff[@]} -eq 0 ] || ff+=(-or)
    ff+=(-name "*.$extension")
  done
  jsonFile=$(returnCatch "$handler" buildEnvironmentGet APPLICATION_JSON) || return $?

  directoryChange "$home" find "." -type f \( "${ff[@]}" \) ! -path '*/.*/*' ! -path "*/$jsonFile" "$@"
}
___hookApplicationFiles() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookApplicationFiles "$@"
