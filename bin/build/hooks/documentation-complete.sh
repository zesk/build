#!/usr/bin/env bash
#
# documentationBuild succeeded
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# fn: {base}
#
# When documentation has been built.
# Summary: {base} hook
# See: documentationBuild
__hookDocumentationComplete() {
  local handler="_${FUNCNAME[0]}"
  local name __saved=("$@")

  name=$(buildEnvironmentGet APPLICATION_NAME) || return $?
  hookRunOptional notify --title "$name Documentation" "Built successfully $*"

  # IDENTICAL hookRunOptionalNext 1
  catchReturn "$handler" hookRunOptional --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "${__saved[@]+"${__saved[@]}"}" || return $?
}
___hookDocumentationComplete() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookDocumentationComplete "$@"
