#!/usr/bin/env bash
#
# tar-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Covers: tarCreate
# Covers: tarExtractPattern
testTarExtractFilePattern() {
  local temp base content IFS

  temp=$(__environment mktemp -d) || return $?

  base="$temp/base"
  __environment mkdir -p "$base/a/b/c/d" || return $?
  __environment mkdir -p "$base/a/e/foo/bar" || return $?
  __environment mkdir -p "$base/a/e/bar/apron" || return $?
  __environment mkdir -p "$base/a/e/bar/dog" || return $?

  __environment printf "%s\n" "up" >"$base/a/e/bar/apron/a.json" || return $?
  __environment printf "%s\n" "down" >"$base/a/e/bar/apron/b.json" || return $?
  __environment printf "%s\n" "you" >"$base/a/e/bar/dog/a.json" || return $?
  __environment printf "%s\n" "you" >"$base/a/e/bar/dog/b.json" || return $?
  __environment printf "%s\n" "to" >"$base/a/e/a.json" || return $?
  __environment printf "%s\n" "to" >"$base/a/e/b.json" || return $?
  __environment printf "%s\n" "never" >"$base/a/b/c/a.json" || return $?
  __environment printf "%s\n" "never" >"$base/a/b/c/b.json" || return $?
  __environment printf "%s\n" "give" >"$base/a/e/bar/a.json" || return $?
  __environment printf "%s\n" "let" >"$base/a/e/bar/b.json" || return $?
  __environment printf "%s\n" "going" >"$base/a/b/c/d/a.json" || return $?
  __environment printf "%s\n" "going" >"$base/a/b/c/d/b.json" || return $?

  __environment muzzle pushd "$temp" || return $?
  assertExitCode 0 tarCreate foo.tar.gz base || return $?$()

  IFS=" " content="$(__environment tarExtractPattern '*/a.json' <foo.tar.gz | sort)" || return $?
  content=${content//$'\n'/ }
  assertEquals "$content" "give going never to up you" || return $?

  IFS=" " content="$(__environment tarExtractPattern '*/e/*/a.json' <foo.tar.gz | sort)" || return $?
  content=${content//$'\n'/ }
  assertEquals "$content" "give up you" || return $?

  IFS=" " content="$(__environment tarExtractPattern '*/e*/a.json' <foo.tar.gz | sort)" || return $?
  content=${content//$'\n'/ }
  assertEquals "$content" "give to up you" || return $?

  IFS=" " content="$(__environment tarExtractPattern '*/b/*/a.json' <foo.tar.gz | sort)" || return $?
  content=${content//$'\n'/ }
  assertEquals "$content" "going never" || return $?

  IFS=" " content="$(__environment tarExtractPattern '*/b.json' <foo.tar.gz | sort)" || return $?
  content=${content//$'\n'/ }
  assertEquals "$content" "down going let never to you" || return $?
}
