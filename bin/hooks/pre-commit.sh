#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../tools.sh"; then

  # Default pre commit hook for Zesk Build
  # - All shell files (`.sh`) are made executable (+x)
  # - `sugar.sh` is maintained (and checked to make sure the wrong version is not being edited)
  __hookPreCommit() {
    local handler="_${FUNCNAME[0]}"
    # gitPreCommitSetup is already called

    gitPreCommitHeader sh md json

    statusMessage decorate success Updating help files ...
    catchEnvironment "$handler" ./bin/update-md.sh --skip-commit || return $?

    statusMessage decorate success Updating _sugar.sh
    local original="bin/build/identical/_sugar.sh" nonOriginal="bin/build/tools/_sugar.sh"

    statusMessage decorate success Making shell files executable ...
    catchEnvironment "$handler" bashMakeExecutable | printfOutputPrefix -- "\n" || return $?

    if [ "$(fileNewest "$original" "$nonOriginal")" = "$nonOriginal" ]; then
      local nonOriginalWithEOF && nonOriginalWithEOF=$(fileTemporaryName "$handler") || return $?
      catchEnvironment "$handler" sed -e 's/IDENTICAL _sugar [0-9][0-9]*/IDENTICAL _sugar EOF/g' -e 's/DO NOT EDIT/EDIT/g' <"$nonOriginal" >"$nonOriginalWithEOF" || return $?
      local fileCopies=("$nonOriginalWithEOF" "$original")
      # Can not be trusted to not edit the right one
      if ! filesAreIdentical "${fileCopies[@]}"; then
        catchEnvironment "$handler" cp "${fileCopies[@]}" || returnClean "$nonOriginalWithEOF" || return $?
        decorate warning "Someone edited non-original file $nonOriginal"
        touch "${fileCopies[0]}" # make newer
      fi
      rm -f "$nonOriginalWithEOF" || :
    fi

    local home && home=$(catchReturn "$handler" buildHome) || return $?
    if ! find "$home/bin/build/documentation" -type f -name '*.sh' -empty | decorate warning | decorate wrap "- " "" | outputTrigger | printfOutputPrefix "%s\n" "$(decorate error "Zero documentation files:")"; then
      statusMessage decorate info "Building usage ..."
      catchEnvironment "$handler" find "$home/bin/build/documentation" -type f -name '*.sh' -empty -delete || return $?
      CI="" buildUsageCompile --skip-git || return $?
      if ! find "$home/bin/build/documentation" -type f -name '*.sh' -empty | decorate warning | decorate wrap "- " "" | outputTrigger | printfOutputPrefix "%s\n" "$(decorate error "Can not create documentation files:")" 1>&2; then
        return 1
      fi
    fi
    hookRunOptional --next "${BASH_SOURCE[0]}" pre-commit "$@"
  }
  ___hookPreCommit() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  __hookPreCommit "$@"
fi
