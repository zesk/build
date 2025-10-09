#!/usr/bin/env bash
#
# Test flags
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Argument: flags - String. Flags to test
# Argument: testName - String. Test name to check for true or false value.
# Tests flags for first occurrence of a flag which takes priority over later ones.
testFlagBoolean() {
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

testFlagPlatformMatch() {
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
