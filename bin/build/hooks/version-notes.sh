#!/usr/bin/env bash
#
# Sample live version script, uses github API to fetch release version
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# Generate a default version notes
__hookVersionNotes() {
  local newVersion="$1" oldVersion="$2"
  name=$(buildEnvironmentGet APPLICATION_NAME)

  printf "%s\n" "# $name release $newVersion" ""
  if hasHook version-notes-copyright; then
    execute runHook version-notes-copyright "$@" || return $?
  else
    local year company
    year=$(date +%Y)
    company=$(buildEnvironmentGet BUILD_COMPANY)
    printf "%s\n" "> Copyright &copy; $year $company" ""
  fi
  printf "%s\n" "- Previous version: $oldVersion"
}
__hookVersionNotes "$@"
