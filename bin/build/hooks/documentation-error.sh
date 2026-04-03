#!/usr/bin/env bash
#
# documentationBuild failed
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# fn: {base}
#
# When documentation has been built but fails
# Summary: {base} hook
# See: documentationBuild
# See: __errorHandler
__hookDocumentationError() {
  local handler="_${FUNCNAME[0]}"

  local name exitCode="${1-}" __saved=("$@")

  shift
  name=$(buildEnvironmentGet APPLICATION_NAME) || return $?
  hookRunOptional notify --title "$name Documentation" "Failed with code \"$exitCode\": $*"

  # IDENTICAL hookRunOptionalNext 1
  catchReturn "$handler" hookRunOptional --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "${__saved[@]+"${__saved[@]}"}" || return $?
}
___hookDocumentationError() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookDocumentationError "$@"
