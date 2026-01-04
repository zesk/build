#!/usr/bin/env bash
#
# markdown.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Local markdown editing
#

__addNoteTo() {
  local home

  home=$(buildHome)
  statusMessage --last decorate info "Adding note to $1"
  cp "$home/$1" "$home/bin/build"
  printf -- "\n%s" "(this file is a copy - please modify the original)" | tee -a "$home/bin/build/$1" >"./documentation/source/$1"
  git add "bin/build/$1" "./documentation/source/$1"
}

#
# handler: {fn} [ --skip-commit ]
# Argument: --skip-commit - Skip the commit if the files change
# Requires: jq throwArgument statusMessage
__updateMarkdown() {
  local handler="_${FUNCNAME[0]}"
  local flagSkipCommit
  local argument

  local flagSkipCommit=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --skip-commit)
      flagSkipCommit=true
      statusMessage decorate warning "Skipping commit ..."
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  __addNoteTo README.md
  __addNoteTo LICENSE.md

  local buildMarker
  buildMarker=$(catchReturn "$handler" __buildMarker) || return $?

  #
  # Disable this to see what environment shows up in commit hooks for GIT*=
  #
  # env | sort >.update-md.env
  #

  # Do this as long as we are not in the hook
  if ! $flagSkipCommit; then
    if ! gitInsideHook; then
      if gitRepositoryChanged; then
        statusMessage --last decorate info "Committing "
        catchEnvironment "$handler" git commit -m "Updating build.json" "$buildMarker" || return $?
        catchEnvironment "$handler" git push origin || return $?
      fi
    else
      statusMessage --last decorate warning "Skipping update during commit hook" || :
    fi
  fi
}
___updateMarkdown() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
