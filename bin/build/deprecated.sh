#!/bin/bash
#
# Run this if you want to upgrade your scripts
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL bashHeader2 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

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
  local deprecatedToken deprecatedTokens=(dockerPHPExtensions usageWrapper usageWhich usageEnvironment) exitCode=0 ignoreStuff=() deprecatedIgnoreStuff=()

  ignoreStuff=(! -path '*/deprecated.sh' ! -path '*/docs/release/*.md')

  deprecatedIgnoreStuff=(! -path '*/tools/usage.sh')
  bin/build/cannon.sh release-check-version.sh git-tag-version.sh "${ignoreStuff[@]}" || :
  # v0.3.12
  bin/build/cannon.sh 'failed "' 'buildFailed "' -name '*.sh' "${ignoreStuff[@]}" || :

  for deprecatedToken in "${deprecatedTokens[@]}"; do
    if find . -type f ! -path '*/.*' "${ignoreStuff[@]}" "${deprecatedIgnoreStuff[@]}" -print0 | xargs -0 grep -l "$deprecatedToken"; then
      consoleError "DEPRECATED token \"$deprecatedToken\" found"
      exitCode=1
    fi
  done
  # v0.6.0
  bin/build/cannon.sh markdownListify markdownFormatList "${ignoreStuff[@]}"

  # v0.6.1
  bin/build/cannon.sh 'usageWhich ' 'usageRequireBinary usage ' "${ignoreStuff[@]}"

  # v0.7.0
  bin/build/cannon.sh 'APPLICATION_CHECKSUM' 'APPLICATION_ID' "${ignoreStuff[@]}"
  bin/build/cannon.sh 'application-checksum' 'application-id' "${ignoreStuff[@]}"

  return $exitCode
}

deprecatedCleanup
