#!/usr/bin/env bash
#
# Run during bin/pipeline/github-release.sh after release is completed
#
# Do any post-release steps you want (update your website etc.)
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __loader 11
set -eou pipefail
# Load zesk build and run command
__loader() {
  # shellcheck source=/dev/null
  if source "$(dirname "${BASH_SOURCE[0]}")/../../bin/build/tools.sh"; then
    "$@" || return $?
  else
    exec 1>&2 && printf 'FAIL: %s\n' "$@"
    return 42 # The meaning of life
  fi
}

# fn: {base}
#
# Optional hook run during `github-release.sh` after release is completed. Do any post-release work here.
#
__hookGithubReleaseAfter() {
  ! buildDebugEnabled || consoleSuccess "$(basename "${BASH_SOURCE[0]}") is the sample script, please update for production sites."
}

__loader __hookGithubReleaseAfter "$@"
