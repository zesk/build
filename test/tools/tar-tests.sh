#!/usr/bin/env bash
#
# tar-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testExtractFilePattern() {
  local temp base

  temp=$(__environment mktemp -d) || return $?

  base="$temp/base"
  __environment mkdir -p "$base/a/b/c/d" || return $?
  __environment mkdir -p "$base/a/e/foo/bar" || return $?
  __environment mkdir -p "$base/a/e/bar/dog" || return $?
  __environment printf "%s\n" "never" >"$base/a/b/c/d/a.json" || return $?
  __environment printf "%s\n" "up" >"$base/a/b/c/a.json" || return $?
  __environment printf "%s\n" "going" >"$base/a/e/a.json" || return $?
  __environment printf "%s\n" "to" >"$base/a/e/bar/a.json" || return $?
  __environment printf "%s\n" "you" >"$base/a/e/bar/dog/a.json" || return $?

  __environment muzzle pushd "$temp" || return $?
  tarCreate foo.tar.gz temp
  tarExtractPattern '*/a.json' <foo.tar.gz
}
