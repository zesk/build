#!/bin/bash
#
# Run this if you want to upgrade your scripts
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __tools 13
# Usage: __tools command ...
# Load zesk build and run command
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

# Usage: {fn} search replace [ additionalCannonArgs ]
__deprecatedCannon() {
  local this="${BASH_SOURCE[0]##*/}"
  local ignoreStuff=(! -path "*/$this" ! -path '*/docs/release/*.md')
  statusMessage printf "%s %s\n" "$(consoleWarning "$1")" "$(consoleSuccess "$2")"
  cannon "$@" "${ignoreStuff[@]}" || :
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
  local this="${BASH_SOURCE[0]##*/}"
  local deprecatedToken deprecatedTokens exitCode ignoreStuff deprecatedIgnoreStuff

  exitCode=0
  deprecatedTokens=()

  deprecatedIgnoreStuff=(! -path '*/tools/usage.sh')
  __deprecatedCannon release-check-version.sh git-tag-version.sh

  # v0.3.12
  __deprecatedCannon 'failed "' 'buildFailed "' -name '*.sh' || :

  # v0.6.0
  __deprecatedCannon markdownListify markdown_FormatList

  # v0.6.1
  __deprecatedCannon 'usageWhich ' 'usageRequireBinary usage '

  # v0.7.0
  __deprecatedCannon 'APPLICATION_CHECKSUM' 'APPLICATION_ID'
  __deprecatedCannon 'application-checksum' 'application-id'
  deprecatedTokens+=(dockerPHPExtensions usageWrapper usageWhich "[^_]usageEnvironment")

  # v0.7.9
  __deprecatedCannon 'needAWS''Environment' 'awsHasEnvironment'
  __deprecatedCannon 'isAWSKey''UpToDate ' 'awsIsKeyUpToDate'

  # v0.7.10
  deprecatedToken+=('bin/build/pipeline')

  # Release v0.7.13
  __deprecatedCannon 'env''map.sh' 'map.sh'
  __deprecatedCannon 'mapCopyFileChanged' 'copyFileChanged --map'
  __deprecatedCannon 'escalateMapCopyFileChanged' 'copyFileChanged --map --escalate'
  __deprecatedCannon 'escalateCopyFileChanged' 'copyFileChanged --escalate'
  __deprecatedCannon 'yesNo ' 'parseBoolean '

  # Relesae v0.8.4
  __deprecatedCannon 'copyFile''ChangedQuiet' 'copyFile'

  # v0.10.0
  __deprecatedCannon 'prefix''Lines' wrapLines
  __deprecatedCannon 'trimSpace''Pipe' 'trimSpace'

  # v0.10.4
  __deprecatedCannon 'crontabApplication''Sync' crontabApplicationUpdate
  __deprecatedCannon 'usageMissing''Argument' usageArgumentMissing
  __deprecatedCannon 'usageUnknown''Argument' usageArgumentUnknown

  clearLine
  # Do all deprecations
  for deprecatedToken in "${deprecatedTokens[@]}"; do
    statusMessage consoleWarning "$deprecatedToken "
    if find . -type f ! -path '*/.*' "${deprecatedIgnoreStuff[@]}" ! -path "*/$this" ! -path './docs/release/*' -print0 | xargs -0 grep -l -e "$deprecatedToken"; then
      clearLine || :
      consoleError "DEPRECATED token \"$deprecatedToken\" found" || :
      exitCode=1
    fi
  done
  clearLine || :
  [ "$exitCode" -ne 0 ] || consoleSuccess "All deprecated tokens were not found"
  consoleSuccess "Completed deprecated script for Build $(consoleCode "$(jq -r .version "$(dirname "${BASH_SOURCE[0]}")/build.json")")"

  return "$exitCode"
}

__tools ../.. __deprecatedCleanup "$@"
