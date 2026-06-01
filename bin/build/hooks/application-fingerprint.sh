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

  local home && home=$(catchReturn "$handler" buildHome) || return $?
  catchReturn "$handler" hookRun --application "$home" application-files | catchReturn "$handler" hookRun --application "$home" fingerprint --name "$HOOK_NAME" "$@" || return $?
}
___hookApplicationFingerprint() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookApplicationFingerprint "$@"
