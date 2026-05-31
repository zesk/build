#!/usr/bin/env bash
#
# pre-release.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.

__buildPreReleaseStep() {
  local handler="$1" && shift
  local interruptCode="$1" && shift
  local message="$1" && shift
  local exitCode=0

  statusMessage decorate info "$message ... "
  iTerm2Badge -i "✏️🌎 $message"
  catchEnvironment "$handler" "$@" || exitCode=$?
  [ "$exitCode" != "$interruptCode" ] || return "$interruptCode"
  # shellcheck disable=SC2015
  [ "$exitCode" = 0 ] && statusMessage --last decorate success "✅ $message" || decorate error "[$exitCode 💣 $(returnCodeString "$exitCode")] failed but continuing with release steps ..."
  return "$exitCode"
}

__buildPreReleaseLintFiles() {
  find "$1" -name '*.sh' ! -path '*/.*/*' ! -path '*/bin/build/documentation/*' | bashLintFiles
}

buildPreRelease() {
  local handler="_${FUNCNAME[0]}"
  local home
  local exitCode=0
  local interruptCode && interruptCode=$(returnCode interrupt)

  home=$(catchReturn "$handler" buildHome) || return $?

  __buildPreReleaseStep "$handler" "$interruptCode" "Deprecated cleanup" "$home/bin/build/deprecated.sh" --fingerprint || exitCode=$?
  [ "$exitCode" != "$interruptCode" ] || return "$interruptCode"

  __buildPreReleaseStep "$handler" "$interruptCode" "Identical repair (internal, long)" "$home/bin/build/repair.sh" --internal --fingerprint || exitCode=$?
  [ "$exitCode" != "$interruptCode" ] || return "$interruptCode"

  __buildPreReleaseStep "$handler" "$interruptCode" "Linting" __buildPreReleaseLintFiles "$home" || exitCode=$?
  [ "$exitCode" != "$interruptCode" ] || return "$interruptCode"

  __buildPreReleaseStep "$handler" "$interruptCode" "Usage remove deprecated" buildFunctionsRemoveDeprecated || exitCode=$?
  [ "$exitCode" != "$interruptCode" ] || return "$interruptCode"

  __buildPreReleaseStep "$handler" "$interruptCode" "Functions compile" buildFunctionsCompile --fingerprint || exitCode=$?
  [ "$exitCode" != "$interruptCode" ] || return "$interruptCode"

  __buildPreReleaseStep "$handler" "$interruptCode" "Fingerprint" fingerprint || exitCode=$?
  [ "$exitCode" != "$interruptCode" ] || return "$interruptCode"

  __buildPreReleaseStep "$handler" "$interruptCode" "Test index build" buildTestSuiteIndex || exitCode=$?
  [ "$exitCode" != "$interruptCode" ] || return "$interruptCode"

  # catchEnvironment "$handler"  "$home/bin/documentation.sh" --clean || exitCode=$?
  __buildPreReleaseStep "$handler" "$interruptCode" "Documentation build" "$home/bin/documentation.sh" || exitCode=$?
  [ "$exitCode" != "$interruptCode" ] || return "$interruptCode"

  __buildBuildUpdateMarkdown "$handler" "$home" || return $?

  #
  # Commit changes
  #
  local version && version=$(hookVersionCurrent)
  muzzle __buildBuildJSONUpdate "$handler" || return $?
  if [ "$exitCode" -eq 0 ] && gitRepositoryChanged; then
    statusMessage decorate info "Committing changes ..."
    catchEnvironment "$handler" gitCommit -- "buildPreRelease $version" || exitCode=$?
    statusMessage --last decorate info "Committed and ready to release."
  else
    statusMessage --last decorate info "No changes to commit."
  fi

  # Completed message
  decorate big "$version Failed" | {
    # shellcheck disable=SC2015
    [ "$exitCode" = 0 ] && decorate error || decorate success
  }
  return "$exitCode"
}
_buildPreRelease() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
