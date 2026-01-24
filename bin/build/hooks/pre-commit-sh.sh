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
    local finished=false changed=()
    while ! $finished; do
      local file && read -r file || finished=true
      [ -n "$file" ] || continue
      changed+=("$file")
      printf -- "%s%s\n" "- " "$(decorate magenta "$file")"
    done < <(gitPreCommitListExtension sh)
    local ba=()
    if buildDebugEnabled bashSanitize; then
      ba=(--debug)
    fi
    catchEnvironment "$handler" bashSanitize "${ba[@]+"${ba[@]}"}" "${changed[@]+"${changed[@]}"}" || return $?
    if executableExists shfmt; then
      export SHFMT_ARGUMENTS
      catchReturn "$handler" buildEnvironmentLoad SHFMT_ARGUMENTS || return $?
      isArray SHFMT_ARGUMENTS || SHFMT_ARGUMENTS=()
      catchEnvironment "$handler" shfmt "${SHFMT_ARGUMENTS[@]+"${SHFMT_ARGUMENTS[@]}"}" -w "${changed[@]+"${changed[@]}"}" || return $?
    fi
    unset "${FUNCNAME[0]}" "_${FUNCNAME[0]}"
  }
  ___hookPreCommitShell() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  __hookPreCommitShell "$@"
fi
