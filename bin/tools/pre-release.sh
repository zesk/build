#!/usr/bin/env bash
#
# pre-release.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.

buildPreRelease() {
  local home
  local exitCode=0

  home=$(__environment buildHome) || return $?

  statusMessage decorate info "Deprecated cleanup ..."
  __execute "$home/bin/build/deprecated.sh" || exitCode=$?
  [ "$exitCode" = 0 ] || decorate error "Failed but continuing with release steps ..."
  statusMessage decorate info "Identical repair (internal, long) ..."
  __execute "$home/bin/build/identical-repair.sh" --internal || exitCode=$?
  [ "$exitCode" = 0 ] || decorate error "Failed but continuing with release steps ..."
  statusMessage decorate info "Linting"
  find "$home" -name '*.sh' ! -path '*/.*/*' | bashLintFiles || exitCode=$?
  [ "$exitCode" = 0 ] || decorate error "Failed but continuing with release steps ..."

  # __execute "$home/bin/documentation.sh" --clean || exitCode=$?
  __execute "$home/bin/documentation.sh" || exitCode=$?

  if [ "$exitCode" -eq 0 ]; then
    if gitRepositoryChanged; then
      statusMessage decorate info "Committing changes ..."
      gitCommit -- "buildPreRelease $(hookVersionCurrent)"
      statusMessage decorate info --last "Committed and ready to release."
    else
      statusMessage decorate info --last "No changes to commit."
    fi
  fi
  local color="success"
  if [ "$exitCode" != 0 ]; then
    color="error"
    text="Failed"
  fi
  bigText "$text" | decorate "$color"
  return "$exitCode"
}
