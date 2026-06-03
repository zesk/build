#!/usr/bin/env bash
#
# application-fingerprint.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# fn: hookRun application-fingerprint
# Summary: `application-fingerprint` hook default implementation
# Generate a unique ID for the state of the application code which changes if the code is modified.
#
# The default hook generates a fingerprint using `sha1sum` and the contents of each `application-files` file.
__hookFingerprint() {
  local handler="_${FUNCNAME[0]}"

  local auditFlag=false name="$HOOK_NAME"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --audit) auditFlag=true ;;
    --name) shift && name=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  local auditFile=/dev/null auditFilePrevious=""

  if $auditFlag; then
    auditFile="$(buildCacheDirectory "${FUNCNAME[0]}")/$name.txt"
    if [ -f "$auditFile" ]; then
      auditFilePrevious="$(fileTemporaryName "$handler")" || return $?
      catchReturn "$handler" mv -f "$auditFile" "$auditFilePrevious" || return $?
    fi
  fi
  sort -f -d -i | xargs -n 1 sha1sum | tee "$auditFile" | textSHA || return $?
  if [ -n "$auditFilePrevious" ]; then
    if ! diff -q "$auditFile" "$auditFilePrevious"; then
      diff -U0 "$auditFile" "$auditFilePrevious" | dumpPipe "$name --audit" 1>&2 || :
    fi
    catchReturn "$handler" returnClean $? "$auditFilePrevious" || return $?
  fi
}
___hookFingerprint() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookFingerprint "$@"
