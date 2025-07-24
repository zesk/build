#!/usr/bin/env bash
#
# Identical map tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Usage: {fn} usageFunction fileNameToUse
# stdin: converts magic attributes
# Requires: quoteSedReplacement
_identicalMapAttributesFilter() {
  local usage="${1-}" file="${2-}" base home full dir aa=()

  home=$(__catch "$usage" buildHome) || return $?
  home="${home%/}/"
  full=$(__catchEnvironment "$usage" realPath "$file") || return $?
  aa+=(-e 's/__FULL__/'"$(quoteSedReplacement "$full")"'/g')

  base=$(__catchEnvironment "$usage" basename "$full") || return $?
  aa+=(-e 's/__EXTENSION__/'"$(quoteSedReplacement "${base##*.}")"'/g')
  aa+=(-e 's/__BASE__/'"$(quoteSedReplacement "$base")"'/g')

  file="${file#"$home"}"
  aa+=(-e 's/__FILE__/'"$(quoteSedReplacement "$file")"'/g')

  dir=$(__catchEnvironment "$usage" dirname -- "$file") || return $?
  aa+=(-e 's/__DIRECTORY__/'"$(quoteSedReplacement "$dir")"'/g')

  __catchEnvironment "$usage" sed "${aa[@]}" || return $?
}

# Usage: {fn} usageFunction fileToModify fileNameToUse
_identicalMapAttributesFile() {
  local usage="$1" && shift
  local file temp

  file=$(usageArgumentFile "$usage" "file" "${1-}") || return $?
  shift
  temp="$file.$$"
  _identicalMapAttributesFilter "$usage" "${1-}" <"$file" >"$temp" || returnClean $? "$temp" || return $?
  __catchEnvironment "$usage" mv -f "$temp" "$file" || returnClean "$?" "$temp" || return $?
}
