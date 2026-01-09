#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# tar-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Covers: tarCreate
# Covers: tarExtractPattern
testTarExtractFilePattern() {
  local handler="returnMessage"
  local temp base content IFS

  temp=$(fileTemporaryName "$handler" -d) || return $?

  base="$temp/base"
  catchEnvironment "$handler" mkdir -p "$base/a/b/c/d" || return $?
  catchEnvironment "$handler" mkdir -p "$base/a/e/foo/bar" || return $?
  catchEnvironment "$handler" mkdir -p "$base/a/e/bar/apron" || return $?
  catchEnvironment "$handler" mkdir -p "$base/a/e/bar/dog" || return $?

  catchEnvironment "$handler" printf "%s\n" "up" >"$base/a/e/bar/apron/a.json" || return $?
  catchEnvironment "$handler" printf "%s\n" "down" >"$base/a/e/bar/apron/b.json" || return $?
  catchEnvironment "$handler" printf "%s\n" "you" >"$base/a/e/bar/dog/a.json" || return $?
  catchEnvironment "$handler" printf "%s\n" "you" >"$base/a/e/bar/dog/b.json" || return $?
  catchEnvironment "$handler" printf "%s\n" "to" >"$base/a/e/a.json" || return $?
  catchEnvironment "$handler" printf "%s\n" "to" >"$base/a/e/b.json" || return $?
  catchEnvironment "$handler" printf "%s\n" "never" >"$base/a/b/c/a.json" || return $?
  catchEnvironment "$handler" printf "%s\n" "never" >"$base/a/b/c/b.json" || return $?
  catchEnvironment "$handler" printf "%s\n" "give" >"$base/a/e/bar/a.json" || return $?
  catchEnvironment "$handler" printf "%s\n" "let" >"$base/a/e/bar/b.json" || return $?
  catchEnvironment "$handler" printf "%s\n" "going" >"$base/a/b/c/d/a.json" || return $?
  catchEnvironment "$handler" printf "%s\n" "going" >"$base/a/b/c/d/b.json" || return $?

  catchEnvironment "$handler" muzzle pushd "$temp" || return $?
  assertExitCode 0 tarCreate foo.tar.gz base || return $?$()

  IFS=" " content="$(catchEnvironment "$handler" tarExtractPattern '*/a.json' <foo.tar.gz | sort)" || return $?
  content=${content//$'\n'/ }
  assertEquals "$content" "give going never to up you" || return $?

  IFS=" " content="$(catchEnvironment "$handler" tarExtractPattern '*/e/*/a.json' <foo.tar.gz | sort)" || return $?
  content=${content//$'\n'/ }
  assertEquals "$content" "give up you" || return $?

  IFS=" " content="$(catchEnvironment "$handler" tarExtractPattern '*/e*/a.json' <foo.tar.gz | sort)" || return $?
  content=${content//$'\n'/ }
  assertEquals "$content" "give to up you" || return $?

  IFS=" " content="$(catchEnvironment "$handler" tarExtractPattern '*/b/*/a.json' <foo.tar.gz | sort)" || return $?
  content=${content//$'\n'/ }
  assertEquals "$content" "going never" || return $?

  IFS=" " content="$(catchEnvironment "$handler" tarExtractPattern '*/b.json' <foo.tar.gz | sort)" || return $?
  content=${content//$'\n'/ }
  assertEquals "$content" "down going let never to you" || return $?
  catchEnvironment "$handler" muzzle popd || return $?

  catchReturn "$handler" rm -rf "$temp" || return $?
}
