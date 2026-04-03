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
  find "$1" -name '*.sh' ! -path '*/.*/*' | bashLintFiles
}

buildPreRelease() {
  local handler="_${FUNCNAME[0]}"
  local home
  local exitCode=0
  local interruptCode && interruptCode=$(returnCode interrupt)

  home=$(catchReturn "$handler" buildHome) || return $?

  __buildPreReleaseStep "$handler" "$interruptCode" "Deprecated cleanup" "$home/bin/build/deprecated.sh" || exitCode=$?
  [ "$exitCode" != "$interruptCode" ] || return "$interruptCode"

  __buildPreReleaseStep "$handler" "$interruptCode" "Identical repair (internal, long)" "$home/bin/build/repair.sh" --internal || exitCode=$?
  [ "$exitCode" != "$interruptCode" ] || return "$interruptCode"

  __buildPreReleaseStep "$handler" "$interruptCode" "Linting" __buildPreReleaseLintFiles "$home" || exitCode=$?
  [ "$exitCode" != "$interruptCode" ] || return "$interruptCode"

  __buildPreReleaseStep "$handler" "$interruptCode" "Usage compile" buildUsageCompile || exitCode=$?
  [ "$exitCode" != "$interruptCode" ] || return "$interruptCode"

  __buildPreReleaseStep "$handler" "$interruptCode" "Fingerprint" fingerprint || exitCode=$?
  [ "$exitCode" != "$interruptCode" ] || return "$interruptCode"

  __buildPreReleaseStep "$handler" "$interruptCode" "Test index build" buildTestSuiteIndex || exitCode=$?
  [ "$exitCode" != "$interruptCode" ] || return "$interruptCode"

  # catchEnvironment "$handler"  "$home/bin/documentation.sh" --clean || exitCode=$?
  __buildPreReleaseStep "$handler" "$interruptCode" "Documentation build" "$home/bin/documentation.sh" || exitCode=$?
  [ "$exitCode" != "$interruptCode" ] || return "$interruptCode"
  #
  # Commit changes
  #
  if [ "$exitCode" -eq 0 ] && gitRepositoryChanged; then
    statusMessage decorate info "Committing changes ..."
    catchEnvironment "$handler" gitCommit -- "buildPreRelease $(hookVersionCurrent)" || exitCode=$?
    statusMessage --last decorate info "Committed and ready to release."
  else
    statusMessage --last decorate info "No changes to commit."
  fi

  # Completed message
  local text && text="$(catchEnvironment "$handler" hookVersionCurrent)" || return $?
  if [ "$exitCode" != 0 ]; then
    decorate big "$text Failed" | decorate error
  else
    decorate big "$text Built" | decorate success
  fi
  return "$exitCode"
}
_buildPreRelease() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
