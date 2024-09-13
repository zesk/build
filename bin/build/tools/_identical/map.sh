#!/usr/bin/env bash
#
# Identical map tools
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# Usage: {fn} usageFunction fileNameToUse
# stdin: converts magic attributes
_identicalMapAttributesFilter() {
  local usage="${1-}" file="${2-}" base home full dir extension

  home=$(__usageEnvironment "$usage" buildHome)
  home="${home%/}/"
  full=$(realPath "$file")
  base=$(basename "$full")
  file="${file#"$home"}"
  extension="${base##*.}"
  dir=$(dirname -- "$file")
  __usageEnvironment "$usage" sed \
    -e 's/__EXTENSION__/'"$(quoteSedReplacement "$extension")"'/g' \
    -e 's/__DIRECTORY__/'"$(quoteSedReplacement "$dir")"'/g' \
    -e 's/__FILE__/'"$(quoteSedReplacement "$file")"'/g' \
    -e 's/__FULL__/'"$(quoteSedReplacement "$full")"'/g' \
    -e 's/__BASE__/'"$(quoteSedReplacement "$base")"'/g'
}

# Usage: {fn} usageFunction fileToModify fileNameToUse
_identicalMapAttributesFile() {
  local usage="$1" && shift
  local file temp

  file=$(usageArgumentFile "$usage" "file" "${1-}") || return $?
  shift
  temp="$file.$$"
  _identicalMapAttributesFilter "$usage" "${1-}" <"$file" >"$temp" || _clean $? "$temp" || return $?
  __usageEnvironment "$usage" mv -f "$temp" "$file" || _clean "$?" "$temp" || return $?
}
