#!/usr/bin/env bash
#
# Test flags
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Argument: flags - String. Flags to test
# Argument: testName - String. Test name to check for true or false value.
# Tests flags for first occurrence of a flag which takes priority over later ones.
__testFlagBoolean() {
  local maybe found smallest=""
  local name="${1-}" && shift
  local flags="${1-}" && shift
  local smallestValue="${1-}"

  for maybe in false true; do
    if found=$(stringOffsetInsensitive ";$name:$maybe;" ";$flags;") && [ "$found" -ge 0 ]; then
      if [ -z "$smallest" ]; then
        smallest="$found"
        smallestValue="$maybe"
      elif [ "$found" -lt "$smallest" ]; then
        smallest="$found"
        smallestValue="$maybe"
      fi
    fi
  done
  printf "%s\n" "$smallestValue"
}

__testFlagPlatformMatch() {
  local platform="${1-}" && shift
  local flags="${1-}" && shift

  local testPlatform

  while read -r testPlatform; do
    if [ "$testPlatform" = "$platform" ]; then
      testPlatform="!$platform"
    fi
    if isSubstringInsensitive ";Platform:$testPlatform;" ";$flags;"; then
      printf "%s\n" "Skipping Platform:$testPlatform (Flags=$flags)" 1>&2
      return 1
    fi
  done < <(__testPlatforms)
}

# Load flags associated with a test
# Parses a test comment header and fetches values which are in the form `# Test-Foo: value`
# Converts these to a string in the form:
#
#     Foo:value;Bar:anotherValue;Marker:true
#
# Which can be easily scanned by other tools to determine eligibility of a test to run or
# other options.
# Argument: source - File. Required. File to scan.
# Argument: functionName - String. Required. Function to fetch the flags for
# stdout: String
# stdin: none
__testLoadFlags() {
  local handler="$1" && shift
  local source="$1" functionName="$2"
  local values=()
  while read -r variableLine; do
    local __flags=() flag
    IFS=" " read -r -a __flags <<<"$(trimSpace "${variableLine#*:}")"
    [ "${#__flags[@]}" -eq 0 ] || for flag in "${__flags[@]}"; do
      [ -z "$flag" ] || values+=("$(trimSpace "${variableLine%%:*}"):$flag")
    done
  done < <(catchReturn "$handler" bashFunctionCommentVariable --prefix "$source" "$functionName" "Test-") || return $?
  [ ${#values[@]} -eq 0 ] || listJoin ";" "${values[@]}"
}

# Outputs the platform name
# Requires: __testPlatformName
_testPlatform() {
  __testPlatformName
}

# Outputs ALL platform names
# See: __testPlatformName
__testPlatforms() {
  local handler="_${FUNCNAME[0]}"
  local home
  home="$(catchReturn "$handler" buildHome)" || return $?
  find "$home/bin/build/tools/platform/" -type f -name '*.sh' -print0 | xargs -0 grep -A 1 '__testPlatformName()' | grep printf | awk '{ print $5 }' | sed 's/"//g'
}
___testPlatforms() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: testPattern - String. Required. Test string to match.
# Argument: testMatches ... - String. Optional. One or more tests to match with.
# Performs a case-insensitive anywhere-in-the-string match
# Return Code: 0 - Test was found in the list
# Return Code: 1 - Test was not found in the list
__testMatches() {
  local testPattern match

  testPattern=$(lowercase "$1")
  shift
  while [ "$#" -gt 0 ]; do
    match=$(lowercase "$1")
    if [ "${testPattern#*"$match"}" != "$testPattern" ]; then
      return 0
    fi
    shift
  done
  return 1
}
