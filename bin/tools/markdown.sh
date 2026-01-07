#!/usr/bin/env bash
#
# markdown.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Local markdown editing
#

__addNoteTo() {
  local handler="$1" && shift
  local home="$1" && shift

  local target="$home/bin/build/$1" docTarget="$home/documentation/source/$1"

  statusMessage --last decorate info "Adding note to $1"

  catchEnvironment "$handler" cp "$home/$1" "$target" || return $?
  catchEnvironment "$handler" printf -- "\n%s" "(this file is a copy - please modify the original)" "" >>"$target" || return $?
  catchEnvironment "$handler" cp "$target" "$docTarget" || return $?
  catchEnvironment "$handler" git add "$target" "$docTarget" || return $?
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
  local home

  home=$(catchReturn "$handler" buildHome) || return $?

  __addNoteTo "$handler" "$home" README.md
  __addNoteTo "$handler" "$home" LICENSE.md

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
