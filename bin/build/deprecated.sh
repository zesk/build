#!/bin/bash
#
# Run this if you want to upgrade your scripts
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __tools 12
# Load tools.sh and run command
__tools() {
  local relative="$1"
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}"
  shift && set -eou pipefail
  local tools="$here/$relative/bin/build/tools.sh"
  [ -x "$tools" ] || _return 97 "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return 42 source "$tools" "$@" || return $?
  "$@" || return $?
}

# IDENTICAL _return 6
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}" # make this a two-liner ;)
  shift || : && printf "[%d] ❌ %s\n" "$code" "${*-§}" 1>&2 || : && return "$code"
}

# Clean up deprecated code automatically. This can be dangerous (uses `cannon`) so use it on
# a clean build checkout and examine changes manually each time.
#
# Does various checks for deprecated code and updates code.
# Usage: deprecated.sh
# Exit Code: 0 - All cleaned up
# Exit Code: 1 - If fails or validation fails
# fn: deprecated.sh
#
__deprecatedCleanup() {
  local deprecatedToken deprecatedTokens exitCode ignoreStuff deprecatedIgnoreStuff

  exitCode=0
  deprecatedTokens=()
  ignoreStuff=(! -path '*/deprecated.sh' ! -path '*/docs/release/*.md')

  deprecatedIgnoreStuff=(! -path '*/tools/usage.sh')
  statusMessage consoleWarning "release-check-version.sh "
  cannon release-check-version.sh git-tag-version.sh "${ignoreStuff[@]}" || :

  # v0.3.12
  statusMessage consoleWarning "buildFailed "
  cannon 'failed "' 'buildFailed "' -name '*.sh' "${ignoreStuff[@]}" || :

  # v0.6.0
  statusMessage consoleWarning "markdownListify "
  cannon markdownListify markdown_FormatList "${ignoreStuff[@]}"

  # v0.6.1
  statusMessage consoleWarning "usageWhich "
  cannon 'usageWhich ' 'usageRequireBinary usage ' "${ignoreStuff[@]}"

  # v0.7.0
  statusMessage consoleWarning "APPLICATION_CHECKSUM "
  cannon 'APPLICATION_CHECKSUM' 'APPLICATION_ID' "${ignoreStuff[@]}"
  cannon 'application-checksum' 'application-id' "${ignoreStuff[@]}"
  deprecatedTokens+=(dockerPHPExtensions usageWrapper usageWhich usageEnvironment)

  # v0.7.9
  statusMessage consoleWarning "awsHasEnvironment "
  cannon 'needAWS''Environment' 'awsHasEnvironment' "${ignoreStuff[@]}"
  statusMessage consoleWarning "awsIsKeyUpToDate "
  cannon 'isAWSKey''UpToDate ' 'awsIsKeyUpToDate' "${ignoreStuff[@]}"

  # v0.7.10
  deprecatedToken+=('bin/build/pipeline')

  clearLine
  # Do all deprecations
  for deprecatedToken in "${deprecatedTokens[@]}"; do
    statusMessage consoleWarning "$deprecatedToken "
    if find . -type f ! -path '*/.*' "${ignoreStuff[@]}" "${deprecatedIgnoreStuff[@]}" -print0 | xargs -0 grep -l "$deprecatedToken"; then
      clearLine || :
      consoleError "DEPRECATED token \"$deprecatedToken\" found" || :
      exitCode=1
    fi
  done
  clearLine || :
  consoleSuccess "Completed deprecated script for Build $(consoleCode "$(jq -r .version "$(dirname "${BASH_SOURCE[0]}")/build.json")")"

  # Release v0.7.13
  cannon 'env''map.sh' 'map.sh' "${ignoreStuff[@]}"
  cannon 'mapCopyFileChanged' 'copyFileChanged --map' "${ignoreStuff[@]}"
  cannon 'escalateMapCopyFileChanged' 'copyFileChanged --map --escalate' "${ignoreStuff[@]}"
  cannon 'escalateCopyFileChanged' 'copyFileChanged --escalate' "${ignoreStuff[@]}"
  cannon 'yesNo ' 'parseBoolean ' "${ignoreStuff[@]}"

  # Relesae v0.8.4
  cannon 'copyFile''ChangedQuiet' 'copyFile' "${ignoreStuff[@]}"

  # v0.10.0
  cannon 'prefix''Lines' wrapLines "${ignoreStuff[@]}"
  cannon 'trimSpace''Pipe' 'trimSpace' "${ignoreStuff[@]}"

  return $exitCode
}

__tools __deprecatedCleanup
