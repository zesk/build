#!/usr/bin/env bash
#
# markdown.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Local markdown editing
#

__buildBuildAddNoteTo() {
  local handler="$1" && shift
  local home="$1" && shift

  local source="$home/documentation/.template/$1"
  local target="$home/bin/build/$1"
  local docTarget="$home/documentation/source/$1"

  if [ -f "$source" ]; then
    statusMessage --last decorate info "Adding note to $1"
    catchEnvironment "$handler" cp "$source" "$target" || return $?
    catchEnvironment "$handler" printf -- "\n%s" "(this file is a copy - please modify the original)" "" >>"$target" || return $?
    catchEnvironment "$handler" cp "$target" "$docTarget" || return $?
    catchEnvironment "$handler" git add "$target" "$docTarget" || return $?
  else
    statusMessage --last decorate warning "No $(decorate file "$source") found"
  fi
}

# Distribute the README.md and LICENSE.md files to important places.
#
# Argument: --skip-commit - Skip the commit if the files change
# Requires: jq throwArgument statusMessage decorate  buildHome  catchReturn __addNoteTo __buildMarker
# Requires: git gitInsideHook gitRepositoryChanged statusMessage throwEnvironment
__buildBuildUpdateMarkdown() {
  local handler="$1" && shift
  local home="$1" && shift

  local f && for f in README.md LICENSE.md; do __buildBuildAddNoteTo "$handler" "$home" "$f"; done
}
___buildBuildUpdateMarkdown() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
