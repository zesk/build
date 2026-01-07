#!/usr/bin/env bash
#
# pre-release.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.

buildPreRelease() {
  local handler="_${FUNCNAME[0]}"
  local home
  local exitCode=0

  home=$(catchReturn "$handler" buildHome) || return $?

  statusMessage decorate info "Deprecated cleanup ..."
  catchEnvironment "$handler" "$home/bin/build/deprecated.sh" || exitCode=$?
  [ "$exitCode" = 0 ] || decorate error "Failed but continuing with release steps ..."
  statusMessage decorate info "Identical repair (internal, long) ..."
  catchEnvironment "$handler" "$home/bin/build/repair.sh" --internal || exitCode=$?
  [ "$exitCode" = 0 ] || decorate error "Failed but continuing with release steps ..."
  statusMessage decorate info "Linting"
  find "$home" -name '*.sh' ! -path '*/.*/*' | bashLintFiles || exitCode=$?
  [ "$exitCode" = 0 ] || decorate error "Failed but continuing with release steps ..."

  # catchEnvironment "$handler"  "$home/bin/documentation.sh" --clean || exitCode=$?
  catchEnvironment "$handler" "$home/bin/documentation.sh" || exitCode=$?

  if [ "$exitCode" -eq 0 ]; then
    if gitRepositoryChanged; then
      statusMessage decorate info "Committing changes ..."
      catchEnvironment "$handler" gitCommit -- "buildPreRelease $(hookVersionCurrent)" || return $?
      statusMessage --last decorate info "Committed and ready to release."
    else
      statusMessage --last decorate info "No changes to commit."
    fi
  fi
  local text
  text="$(catchEnvironment "$handler" hookVersionCurrent)" || return $?
  if [ "$exitCode" != 0 ]; then
    bigText "$text Failed" | decorate error
  else
    bigText "$text Built" | decorate success
  fi
  return "$exitCode"
}
_buildPreRelease() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
