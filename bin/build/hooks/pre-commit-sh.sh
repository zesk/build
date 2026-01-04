#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../tools.sh"; then
  # fn: {base}
  # The `pre-commit-php` hook is the default handler for Bash files (`.sh`), and does the following:
  # 1. Checks all shell files for errors
  # BUILD_DEBUG: bashSanitize - Debug the patterns used to exclude files by `bashSanitize`
  __hookPreCommitShell() {
    local handler="_${FUNCNAME[0]}"

    statusMessage --last printf -- "%s %s (%s)\n" "$(decorate info "[pre-commit]")" "$(decorate code ".sh")" "$(decorate label "Shell files")"
    catchEnvironment "$handler" gitPreCommitListExtension sh | decorate bold-magenta || return $?
    local done=false changed=() file
    while ! $done; do
      read -r file || done=true
      [ -z "$file" ] || changed+=("$file")
    done < <(gitPreCommitListExtension sh)
    if buildDebugEnabled bashSanitize; then
      changed=(--debug "${changed[@]+"${changed[@]}"}")
    fi
    catchEnvironment "$handler" bashSanitize "${changed[@]+"${changed[@]}"}" || return $?

    unset "${FUNCNAME[0]}" "_${FUNCNAME[0]}"
  }
  ___hookPreCommitShell() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  __hookPreCommitShell "$@"
fi
