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
#
# See: documentationBuild
__hookDocumentationComplete() {
  local name

  name=$(buildEnvironmentGet APPLICATION_NAME) || return $?
  hookRunOptional notify --title "$name Documentation" "Built successfully $*"
}

__hookDocumentationComplete "$@"
