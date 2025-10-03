#!/usr/bin/env bash
#
# tar-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Covers: tarCreate
# Covers: tarExtractPattern
testTarExtractFilePattern() {
  local handler="returnMessage"
  local temp base content IFS

  temp=$(fileTemporaryName "$handler" -d) || return $?

  base="$temp/base"
  __catchEnvironment "$handler" mkdir -p "$base/a/b/c/d" || return $?
  __catchEnvironment "$handler" mkdir -p "$base/a/e/foo/bar" || return $?
  __catchEnvironment "$handler" mkdir -p "$base/a/e/bar/apron" || return $?
  __catchEnvironment "$handler" mkdir -p "$base/a/e/bar/dog" || return $?

  __catchEnvironment "$handler" printf "%s\n" "up" >"$base/a/e/bar/apron/a.json" || return $?
  __catchEnvironment "$handler" printf "%s\n" "down" >"$base/a/e/bar/apron/b.json" || return $?
  __catchEnvironment "$handler" printf "%s\n" "you" >"$base/a/e/bar/dog/a.json" || return $?
  __catchEnvironment "$handler" printf "%s\n" "you" >"$base/a/e/bar/dog/b.json" || return $?
  __catchEnvironment "$handler" printf "%s\n" "to" >"$base/a/e/a.json" || return $?
  __catchEnvironment "$handler" printf "%s\n" "to" >"$base/a/e/b.json" || return $?
  __catchEnvironment "$handler" printf "%s\n" "never" >"$base/a/b/c/a.json" || return $?
  __catchEnvironment "$handler" printf "%s\n" "never" >"$base/a/b/c/b.json" || return $?
  __catchEnvironment "$handler" printf "%s\n" "give" >"$base/a/e/bar/a.json" || return $?
  __catchEnvironment "$handler" printf "%s\n" "let" >"$base/a/e/bar/b.json" || return $?
  __catchEnvironment "$handler" printf "%s\n" "going" >"$base/a/b/c/d/a.json" || return $?
  __catchEnvironment "$handler" printf "%s\n" "going" >"$base/a/b/c/d/b.json" || return $?

  __catchEnvironment "$handler" muzzle pushd "$temp" || return $?
  assertExitCode 0 tarCreate foo.tar.gz base || return $?$()

  IFS=" " content="$(__catchEnvironment "$handler" tarExtractPattern '*/a.json' <foo.tar.gz | sort)" || return $?
  content=${content//$'\n'/ }
  assertEquals "$content" "give going never to up you" || return $?

  IFS=" " content="$(__catchEnvironment "$handler" tarExtractPattern '*/e/*/a.json' <foo.tar.gz | sort)" || return $?
  content=${content//$'\n'/ }
  assertEquals "$content" "give up you" || return $?

  IFS=" " content="$(__catchEnvironment "$handler" tarExtractPattern '*/e*/a.json' <foo.tar.gz | sort)" || return $?
  content=${content//$'\n'/ }
  assertEquals "$content" "give to up you" || return $?

  IFS=" " content="$(__catchEnvironment "$handler" tarExtractPattern '*/b/*/a.json' <foo.tar.gz | sort)" || return $?
  content=${content//$'\n'/ }
  assertEquals "$content" "going never" || return $?

  IFS=" " content="$(__catchEnvironment "$handler" tarExtractPattern '*/b.json' <foo.tar.gz | sort)" || return $?
  content=${content//$'\n'/ }
  assertEquals "$content" "down going let never to you" || return $?
  __catchEnvironment "$handler" muzzle popd || return $?

  __catch "$handler" rm -rf "$temp" || return $?
}
