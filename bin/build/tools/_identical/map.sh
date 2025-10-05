#!/usr/bin/env bash
#
# Identical map tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# handler: {fn} usageFunction fileNameToUse
# stdin: converts magic attributes
# Requires: quoteSedReplacement
_identicalMapAttributesFilter() {
  local handler="${1-}" file="${2-}" base home full dir aa=()

  home=$(returnCatch "$handler" buildHome) || return $?
  home="${home%/}/"
  full=$(catchEnvironment "$handler" realPath "$file") || return $?
  aa+=(-e 's/__FULL__/'"$(quoteSedReplacement "$full")"'/g')

  base=$(catchEnvironment "$handler" basename "$full") || return $?
  aa+=(-e 's/__EXTENSION__/'"$(quoteSedReplacement "${base##*.}")"'/g')
  aa+=(-e 's/__BASE__/'"$(quoteSedReplacement "$base")"'/g')

  file="${file#"$home"}"
  aa+=(-e 's/__FILE__/'"$(quoteSedReplacement "$file")"'/g')

  dir=$(catchEnvironment "$handler" dirname -- "$file") || return $?
  aa+=(-e 's/__DIR__/'"$(quoteSedReplacement "$dir")"'/g')
  aa+=(-e 's/__DIRECTORY__/'"$(quoteSedReplacement "$dir")"'/g')

  catchEnvironment "$handler" sed "${aa[@]}" || return $?
}

# handler: {fn} usageFunction fileToModify fileNameToUse
_identicalMapAttributesFile() {
  local handler="$1" && shift
  local file temp

  file=$(usageArgumentFile "$handler" "file" "${1-}") || return $?
  shift
  temp="$file.$$"
  _identicalMapAttributesFilter "$handler" "${1-}" <"$file" >"$temp" || returnClean $? "$temp" || return $?
  catchEnvironment "$handler" mv -f "$temp" "$file" || returnClean "$?" "$temp" || return $?
}
