#!/bin/bash
#
# Run this if you want to upgrade your scripts
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __tools 16
# Usage: {fn} [ relative [ command ... ] ]
# Load build tools and run command
# Argument: relative - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  local source="${BASH_SOURCE[0]}" e=253
  local here="${source%/*}" arguments=()
  local tools="$here/${1:-".."}/bin/build"
  [ -d "$tools" ] || _return $e "$tools is not a directory" || return $?
  tools="$tools/tools.sh" && [ -x "$tools" ] || _return $e "$tools not executable" "$@" || return $?
  shift && while [ $# -gt 0 ]; do arguments+=("$1") && shift; done
  # shellcheck source=/dev/null
  source "$tools" || _return $e source "$tools" "$@" || return $?
  [ ${#arguments[@]} -gt 0 ] || return 0
  "${arguments[@]}" || return $?
}

# IDENTICAL _return 19
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  _integer "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() {
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

__deprecatedIgnore() {
  local this="${BASH_SOURCE[0]##*/}"
  local ignoreStuff=(! -path "*/$this" ! -path '*/docs/release/*.md')
  printf "%s\n" "${ignoreStuff[@]}"
}

# Usage
__deprecatedFind() {
  local ignoreStuff
  read -d '' -r -a ignoreStuff < <(__deprecatedIgnore)
  while [ "$#" -gt 0 ]; do
    if find . -type f -name '*.sh' "${ignoreStuff[@]}" -print0 | xargs -0 grep -q "$1"; then
      return 0
    fi
    shift
  done
  return 1
}

# Usage: {fn} search replace [ additionalCannonArgs ]
__deprecatedCannon() {
  local ignoreStuff
  read -d '' -r -a ignoreStuff < <(__deprecatedIgnore)
  statusMessage printf "%s %s \n" "$(consoleWarning "$1")" "$(consoleSuccess "$2")"
  cannon "$@" "${ignoreStuff[@]}" || :
}

# Clean up deprecated code automatically. This can be dangerous (uses `cannon`) so use it on
# a clean build checkout and examine changes manually each time.
#
# Does various checks for deprecated code and updates code.
# Usage: {fn}
# fn: {base}
# Exit Code: 0 - All cleaned up
# Exit Code: 1 - If fails or validation fails
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

  # v0.11.1
  # Replace only if usageArgumentRequired has not been replaced yet as
  # usageArgumentRequired -> usageArgumentString
  # usageArgumentString -> usageArgumentEmptyString
  # usageArgumentString is still in use with a different semantic
  if __deprecatedFind usageArgumentRequired; then
    __deprecatedCannon 'usageArgumentRequired' usageArgumentREMOVETHISRequired
    __deprecatedCannon 'usageArgumentString' usageArgumentEmptyString
    __deprecatedCannon 'usageArgumentREMOVETHISRequired' usageArgumentRequired
  fi
  __deprecatedCannon 'usageArgumentRequired' usageArgumentString
  deprecatedTokens+=(crontab-application-sync.sh)
  __deprecatedCannon "show""Environment" environmentFileShow
  __deprecatedCannon "make""Environment" environmentFileApplicationMake
  __deprecatedCannon "dot""EnvConfigure"
  __deprecatedCannon "application""EnvironmentVariables" environmentApplicationVariables
  __deprecatedCannon "application""Environment" environmentApplicationLoad

  __deprecatedCannon "path""Append" listAppend

  deprecatedTokens+=("dotEnv""Configure")

  # v0.11.2
  __deprecatedCannon '_''environment''Output' outputTrigger

  # v0.11.4
  deprecatedTokens+=("ops"".sh" "__""ops")

  # v0.11.6
  __deprecatedCannon 'gitPre''CommitShellFiles' bashSanitize
  __deprecatedCannon 'validate''ShellScripts' bashLintFiles
  __deprecatedCannon 'validate''ShellScript' bashLint

  # v0.11.7

  # END OF CANNONS

  clearLine
  # Do all deprecations
  for deprecatedToken in "${deprecatedTokens[@]}"; do
    statusMessage consoleWarning "$deprecatedToken "
    if find . -type f ! -path "*/.*/*" "${deprecatedIgnoreStuff[@]}" ! -path "*/$this" ! -path './docs/release/*' -print0 | xargs -0 grep -l -e "$deprecatedToken"; then
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
