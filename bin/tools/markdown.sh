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
  local homeTarget="$home/$1"

  [ -f "$source" ] || throwArgument "$handler" "$source does not exist" || return $?
  catchEnvironment "$handler" cp "$source" "$target" || return $?
  statusMessage --last decorate info "Adding note to $target"
  catchEnvironment "$handler" printf -- "\n%s" "(this file is a copy - please modify the original)" "" >>"$target" || return $?
  catchEnvironment "$handler" cp "$target" "$docTarget" || return $?
  catchEnvironment "$handler" cp "$target" "$homeTarget" || return $?
  catchEnvironment "$handler" git add "$target" "$docTarget" "$homeTarget" || return $?
}

# Distribute the README.md and LICENSE.md files to important places.
#
# Requires: __buildBuildAddNoteTo
__buildBuildUpdateMarkdown() {
  local handler="$1" && shift
  local home="$1" && shift

  local f && for f in README.md LICENSE.md; do __buildBuildAddNoteTo "$handler" "$home" "$f"; done
}
___buildBuildUpdateMarkdown() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
