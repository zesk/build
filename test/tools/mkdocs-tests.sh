#!/usr/bin/env bash
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.
#

# Test-Plumber: false

# Tag: package-install
# Tag: package-install-last
# Leaks PATH PS1 VIRTUAL_ENV VIRTUAL_ENV_PROMPT _OLD_VIRTUAL_PATH _OLD_VIRTUAL_PS1
testDocumentationMkdocs() {
  local handler="returnMessage"

  local tempDocs
  local home

  mockEnvironmentStart PATH "$PATH"
  mockEnvironmentStart PS1
  mockEnvironmentStart VIRTUAL_ENV
  mockEnvironmentStart VIRTUAL_ENV_PROMPT
  mockEnvironmentStart _OLD_VIRTUAL_PATH
  mockEnvironmentStart _OLD_VIRTUAL_PS1

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
  version=1.0 timestamp=$(timingStart) assertExitCode 0 documentationMkdocs --path "$tempDocs/documentation" --package mkdocs-material || return $?
  assertExitCode 0 whichExists mkdocs || return $?
  assertDirectoryExists "$tempDocs/documentation/.site" || return $?
  assertFileExists "$tempDocs/documentation/mkdocs.yml" || return $?
  assertExitCode 0 isFunction deactivate || return $?
  assertExitCode 0 deactivate || return $?
  assertExitCode 1 whichExists mkdocs || return $?
  catchEnvironment "$handler" rm -rf "$tempDocs" || return $?

  mockEnvironmentStop PATH PS1 VIRTUAL_ENV VIRTUAL_ENV_PROMPT _OLD_VIRTUAL_PATH _OLD_VIRTUAL_PS1
}
