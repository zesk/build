#!/usr/bin/env bash
#
# markdown.sh
#
# IDENTICAL licenseHeader 11
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#
# Local markdown editing
#

__buildBuildAddNoteTo() {
  local handler="$1" && shift
  local home="$1" && shift
  local source="$1" && shift
  local name && name=$(catchReturn "$handler" basename "$source") || return $?

  local targets=("$home/bin/build" "$home/documentation/source" "$home")

  [ -f "$source" ] || throwArgument "$handler" "$source does not exist" || return $?

  local modifiedSource && modifiedSource=$(fileTemporaryName "$handler") || return $?
  local clean=("$modifiedSource")
  (
    catchEnvironment "$handler" cp "$source" "$modifiedSource" || return $?
    statusMessage --last decorate info "Adding note to $source"
    catchEnvironment "$handler" printf -- "\n\n%s" "(This is a copy – original at ${source#"$home/"})" "" >>"$modifiedSource" || return $?
    local target && for target in "${targets[@]}"; do
      catchEnvironment "$handler" cp "$modifiedSource" "$target/$name" || return $?
      catchEnvironment "$handler" git add "$target/$name" || return $?
    done
  ) || returnClean $? "${clean[@]}" || return $?
}

# Distribute the README.md and LICENSE.txt files to important places.
#
# Requires: __buildBuildAddNoteTo
__buildBuildUpdateMarkdown() {
  local handler="$1" && shift
  local home="$1" && shift

  local f && for f in "$home/documentation/.template/README.md" "$home/documentation/template/docs/LICENSE.txt"; do __buildBuildAddNoteTo "$handler" "$home" "$f"; done
}
___buildBuildUpdateMarkdown() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
