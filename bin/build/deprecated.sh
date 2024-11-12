#!/bin/bash
#
# Run this if you want to upgrade your scripts
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __source 17
# Usage: {fn} source relativeHome  [ command ... ] ]
# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__source() {
  local me="${BASH_SOURCE[0]}" e=253
  local here="${me%/*}" a=()
  local source="$here/${2:-".."}/${1-}" && shift 2 || _return $e "missing source" || return $?
  [ -d "${source%/*}" ] || _return $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || _return $e "$source not an executable file" "$@" || return $?
  while [ $# -gt 0 ]; do a+=("$1") && shift; done
  # shellcheck source=/dev/null
  source "$source" || _return $e source "$source" "$@" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  "${a[@]}" || return $?
}

# IDENTICAL __tools 7
# Usage: {fn} [ relativeHome [ command ... ] ]
# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  __source bin/build/tools.sh "$@"
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
  read -d '' -r -a ignoreStuff < <(__deprecatedIgnore) || :
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
  local from="$1" to="$2" ignoreStuff
  shift 2
  read -d '' -r -a ignoreStuff < <(__deprecatedIgnore) || :
  statusMessage printf "%s %s \n" "$(consoleWarning "$from")" "$(consoleSuccess "$to")"
  cannon "$from" "$to" "${ignoreStuff[@]}" "$@" || :
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
  local deprecatedToken deprecatedTokens exitCode ignoreStuff deprecatedIgnoreStuff file

  set -eou pipefail

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
  __deprecatedCannon "application""EnvironmentVariables" environmentApplicationVariables
  __deprecatedCannon "application""Environment" environmentApplicationLoad

  # __deprecatedCannon "path""Append" listAppend

  # __deprecatedCannon "dot""EnvConfigure" 'environmentFileLoad .env --optional .env.local' ! -path '*/environment.sh'
  # deprecatedTokens+=("dotEnv""Configure")

  # v0.11.2
  __deprecatedCannon '_''environment''Output' outputTrigger

  # v0.11.4
  deprecatedTokens+=("ops"".sh" "__""ops")

  # v0.11.6
  __deprecatedCannon 'gitPre''CommitShellFiles' bashSanitize
  __deprecatedCannon 'validate''ShellScripts' bashLintFiles
  __deprecatedCannon 'validate''ShellScript' bashLint

  # v0.11.7

  # v0.11.8
  __deprecatedCannon 'aws-cli''.sh' "aws.sh"
  deprecatedToken+=('__''try')

  # v0.11.9
  __deprecatedCannon 'aws''ValidRegion' "awsRegionValid"

  # v0.11.10
  __deprecatedCannon '__''return' "__execute"

  # v0.11.14
  __deprecatedCannon 'create''TarFile' "tarCreate"

  # v0.12.2
  __deprecatedCannon 'awsSecurityGroupIP''Register' "awsSecurityGroupIPModify --register"

  # v0.14.3
  home=$(__environment buildHome) || return $?
  for file in "$home/bin/build/pipeline/"*.sh; do
    deprecatedToken+=("${file#"$home"}")
  done
  for file in "$home/bin/build/install/"*.sh; do
    deprecatedToken+=("${file#"$home"}")
  done

  # v0.14.6
  __deprecatedCannon 'aptListInstalled' "aptInstalledList"
  __deprecatedCannon 'aptInstall' "packageInstall" ! -path '*/apt.sh'
  __deprecatedCannon 'aptUninstall' "packageUninstall" ! -path '*/apt.sh'
  __deprecatedCannon 'aptUpdateOnce' "packageUpdate" ! -path '*/apt.sh'
  __deprecatedCannon 'whichApt' "packageWhich" ! -path '*/apt.sh'
  __deprecatedCannon 'whichAptUninstall' "packageWhichUninstall" ! -path '*/apt.sh'
  __deprecatedCannon 'aptNeedRestartFlag' "packageNeedRestartFlag" ! -path '*/apt.sh'

  # v0.15.1
  __deprecatedCannon 'console''Code' "decorate code" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Error' "decorate error" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Orange' "decorate orange" ! -path '*/colors.sh'
  __deprecatedCannon 'console''BoldOrange' "decorate bold-orange" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Blue' "decorate blue" ! -path '*/colors.sh'
  __deprecatedCannon 'console''BoldBlue' "decorate bold-blue" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Red' "decorate red" ! -path '*/colors.sh'
  __deprecatedCannon 'console''BoldRed' "decorate bold-red" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Green' "decorate green" ! -path '*/colors.sh'
  __deprecatedCannon 'console''BoldGreen' "decorate bold-green" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Cyan' "decorate cyan" ! -path '*/colors.sh'
  __deprecatedCannon 'console''BoldCyan' "decorate bold-cyan" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Yellow' "decorate yellow" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Magenta' "decorate magenta" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Black' "decorate black" ! -path '*/colors.sh'
  __deprecatedCannon 'console''BoldBlack' "decorate bold-black" ! -path '*/colors.sh'
  __deprecatedCannon 'console''BoldWhite' "decorate bold-white" ! -path '*/colors.sh'
  __deprecatedCannon 'console''White' "decorate white" ! -path '*/colors.sh'
  __deprecatedCannon 'console''BoldMagenta' "decorate bold-magenta" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Underline' "decorate underline" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Bold' "decorate bold" ! -path '*/colors.sh'
  __deprecatedCannon 'console''NoBold' "decorate no-bold" ! -path '*/colors.sh'
  __deprecatedCannon 'console''NoUnderline' "decorate no-underline" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Info' "decorate info" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Warning' "decorate warning" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Success' "decorate success" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Decoration' "decorate decoration" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Subtle' "decorate subtle" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Label' "decorate label" ! -path '*/colors.sh'
  __deprecatedCannon 'console''Value' "decorate value" ! -path '*/colors.sh'

  # v0.17.0
  deprecatedToken+=(' --env ')

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
