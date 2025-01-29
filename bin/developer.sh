#!/usr/bin/env bash
#
# developer.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Zesk Developer scripts

__buildAliases() {
  local home

  home=$(__environment buildHome) || return $?

  # shellcheck disable=SC2139
  alias t="$home/bin/build/tools.sh"
  alias tools=t
}

buildPreRelease() {
  local home

  home=$(__environment buildHome) || return $?

  statusMessage decorate info "Deprecated cleanup ..."
  __execute "$home/bin/build/deprecated.sh" || exitCode=$?
  statusMessage decorate info "Identical repair (internal, long) ..."
  __execute "$home/bin/build/identical-repair.sh" --internal || exitCode=$?
  statusMessage decorate info "Documentation"
  __execute "$home/bin/documentation.sh" || exitCode=$?
  find "$home" -name '*.sh' ! -path '*/.*/*' | bashLintFiles || exitCode=$?
  if [ "$exitCode" -eq 0 ]; then
    if gitRepositoryChanged; then
      statusMessage decorate info "Committing changes ..."
      gitCommit -- "buildPreRelease $(hookVersionCurrent)"
    else
      statusMessage decorate info --last "No changes to commit."
    fi
  fi
  return "$exitCode"
}

__buildAliases
