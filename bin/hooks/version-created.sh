#!/usr/bin/env bash
#
# Run during bin/build/new-release.sh when a new version is created
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# shellcheck source=/dev/null
set -eou pipefail

source "${BASH_SOURCE[0]%/*}/../build/tools.sh"

# fn: {base}
#
# Run whenever `new-version.sh` is run and a version was just created.
#
# Opens the release notes in the current editor.
#
# Environment: BUILD_VERSION_NO_OPEN - Do not open in the default editor. Set this is you do not want the behavior and do not have an override `version-created` hook
#
__buildVersionCreated() {
  local usage="_return"
  local home newDeprecated deprecatedConfiguration

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  __catchEnvironment "$usage" gitBranchify || return $?

  deprecatedConfiguration="$home/bin/build/deprecated.txt"
  [ -f "$deprecatedConfiguration" ] || __throwEnvironment "$usage" "Missing $deprecatedConfiguration" || return $?
  newDeprecated=$(fileTemporaryName "$usage") || return $?

  __catchEnvironment "$usage" printf -- "%s\n\n" "# $1" >"$newDeprecated" || return $?
  cat "$deprecatedConfiguration" >>"$newDeprecated"
  __catchEnvironment "$usage" mv -f "$newDeprecated" "$deprecatedConfiguration" || return $?
  __catchEnvironment "$usage" "$home/bin/build/hooks/version-created.sh" "$@" || return $?
}

__buildVersionCreated "$@"
