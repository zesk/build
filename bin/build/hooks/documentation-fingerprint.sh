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

# fn: hookRun documentation-fingerprint
# Summary: `application-fingerprint` hook default implementation
# Generate a unique ID for the state of the application code which changes if the code is modified.
#
# The default hook generates a fingerprint using `sha1sum` and the contents of each `application-files` file.
__hookDocumentationFingerprint() {
  local handler="_${FUNCNAME[0]}"

  local home && home=$(catchReturn "$handler" buildHome) || return $?
  catchReturn "$handler" hookRun --application "$home" documentation-files | catchReturn "$handler" hookRun --application "$home" fingerprint --name "$HOOK_NAME" "$@" || return $?
}
___hookDocumentationFingerprint() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookDocumentationFingerprint "$@"
