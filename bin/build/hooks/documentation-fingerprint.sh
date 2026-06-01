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
__hookApplicationFingerprint() {
  local handler="_${FUNCNAME[0]}"

  local auditFlag=false

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
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  local home && home=$(catchReturn "$handler" buildHome) || return $?
  local auditFile=/dev/null doTheDiff=false
  if $auditFlag; then
    auditFile="$home/$HOOK_NAME.files.txt"
    local auditFilePrevious="$home/$HOOK_NAME.files.before.txt"
    if [ -f "$auditFile" ]; then
      catchReturn "$handler" mv -f "$auditFile" "$auditFilePrevious" || return $?
      doTheDiff=true
    fi
  fi
  catchReturn "$handler" hookRun --application "$home" documentation-files -print0 | xargs -0 -n 1 sha1sum | sort -k 2 | tee "$auditFile" | textSHA || return $?
  if $doTheDiff; then
    diff -u "$auditFile" "$auditFilePrevious" | dumpPipe "$HOOK_NAME --audit" 1>&2
  fi
}
___hookApplicationFingerprint() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookApplicationFingerprint "$@"
