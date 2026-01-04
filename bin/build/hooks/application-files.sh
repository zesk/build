#!/usr/bin/env bash
#
# Get a complete list of files which make up an application's state.
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# fn: runHook application-files
# Get a complete list of files which make up an application's state. Should include anything which is code, not design. (fine line)
# Argument: ... - Arguments. Optional. Arguments are passed to the find command.
# Argument: --debug - Flag. Optional. Show debugging information.
# Argument: --not - Flag. Optional. Show list of files which are still excluded by APPLICATION_CODE_IGNORE but show files which are NOT included by extension.
__hookApplicationFiles() {
  local handler="_${FUNCNAME[0]}"
  local home debugFlag=false notFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --debug) debugFlag=true ;;
    --not) notFlag=true ;;
    *)
      break
      ;;
    esac
    shift
  done
  home=$(catchReturn "$handler" buildHome) || return $?

  local extensionText
  extensionText=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_CODE_EXTENSIONS) || return $?
  [ -n "$extensionText" ] || throwArgument "$handler" "Requires APPLICATION_CODE_EXTENSIONS to be non-blank" || return $?

  local ignoreList ii=()
  ignoreList=$(buildEnvironmentGet APPLICATION_CODE_IGNORE 2>/dev/null) || :
  if [ -n "$ignoreList" ]; then
    local ignore finished=false
    while ! $finished; do
      IFS="" read -r -d ':' ignore || finished=true
      ignore="${ignore%$'\n'}"
      [ -z "$ignore" ] || ii+=(! -path "*$ignore*")
    done <<<"$ignoreList"
  fi
  local extensions=()
  IFS=":" read -r -a extensions <<<"$extensionText" || :
  [ "${#extensions[@]}" -gt 0 ] || throwArgument "$handler" "No extensions found in $(decorate code "$extensionText")?" || return $?
  local ff=()
  if $notFlag; then
    for extension in "${extensions[@]}"; do
      ff+=(! -name "*.$extension")
    done
  else
    for extension in "${extensions[@]}"; do
      [ ${#ff[@]} -eq 0 ] || ff+=(-or)
      ff+=(-name "*.$extension")
    done
  fi
  jsonFile=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_JSON) || return $?

  set -- directoryChange "$home" find "." -type f \( "${ff[@]}" \) ! -path '*/.*/*' ! -path "*/$jsonFile" "${ii[@]+"${ii[@]}"}" "$@"
  ! $debugFlag || decorate each quote "$@"
  "$@"
}
___hookApplicationFiles() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookApplicationFiles "$@"
