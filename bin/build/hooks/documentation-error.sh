#!/usr/bin/env bash
#
# documentationBuild failed
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# fn: {base}
#
# When documentation has been built but fails
#
# See: documentationBuild
# See: __errorHandler
__hookDocumentationError() {
  local name exitCode="${1-}"

  shift
  name=$(buildEnvironmentGet APPLICATION_NAME) || return $?
  hookRunOptional notify "$(printf "%s\n\n%s\n\n%s" "$name" "Documentation failed with code \"$exitCode\":" "$*")"
}

__hookDocumentationError "$@"
