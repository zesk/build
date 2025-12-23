#!/usr/bin/env bash
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#

# Tag: package-install
# Tag: package-install-last
testDocumentationMkdocs() {
  local handler="returnMessage"

  local tempDocs
  local home

  home=$(catchReturn "$handler" buildHome) || return $?

  tempDocs=$(fileTemporaryName "$handler" -d) || return $?

  catchEnvironment "$handler" cp -r "$home/documentation" "$tempDocs/documentation" || return $?

  catchReturn "$handler" rm -f "$tempDocs/documentation/mkdocs.yml" || return $?

  if [ -d "$tempDocs/documentation/.site" ]; then
    catchEnvironment "$handler" rm -rf "$tempDocs/documentation/.site" || return $?
  fi
  if [ ! -d "$tempDocs/documentation/.docs" ]; then
    catchEnvironment "$handler" mkdir -p "$tempDocs/documentation/.docs" || return $?
    catchEnvironment "$handler" printf -- "%s\n" "# Hello, world" "" "{tools}" >"$tempDocs/documentation/.docs/index.md" || return $?
  fi
  version=1.0 timestamp=$(timingStart) assertExitCode 0 documentationMkdocs --path "$tempDocs/documentation" || return $?
  assertExitCode 0 whichExists mkdocs || return $?
  assertDirectoryExists "$tempDocs/documentation/.site" || return $?
  assertFileExists "$tempDocs/documentation/mkdocs.yml" || return $?
  catchEnvironment "$handler" rm -rf "$tempDocs" || return $?
}
