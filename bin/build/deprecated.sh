#!/bin/bash
#
# Run this if you want to upgrade your scripts
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

loadTools() {
  # shellcheck source=/dev/null
  if ! source "$(dirname "${BASH_SOURCE[0]}")/tools.sh"; then
    printf "%s\n" "Failed to load tools.sh" 1>&2
    return 1
  fi
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
deprecatedCleanup() {
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
  cannon 'env''map.sh' 'map.sh'
  cannon 'copyFileChanged --map ' 'copyFileChanged --map'
  cannon 'escalatedMapCopyFileChanged' 'copyFileChanged --map --escalate'
  cannon 'escalatedCopyFileChanged' 'copyFileChanged --escalate'
  cannon 'yesNo ' 'parseBoolean '

  return $exitCode
}

loadTools && deprecatedCleanup
