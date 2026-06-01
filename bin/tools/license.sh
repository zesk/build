#!/usr/bin/env bash
#
# Fetch and update the license
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

buildFetchLicense() {
  local handler="_${FUNCNAME[0]}"

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local licenseSource="$home/documentation/template/docs/LICENSE.txt"
  urlFetch "https://www.apache.org/licenses/LICENSE-2.0.txt" | sed '/END OF/ q;' | sed '$d' | textTrimTail >"$licenseSource"
  __buildBuildUpdateMarkdown "$handler" "$home" || return $?
}
_buildFetchLicense() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
