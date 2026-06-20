#!/usr/bin/env bash
#
# bash alias functions
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/bash.md
# Test: ./test/tools/bash-tests.sh

__bashApplicationAliasSetup() {
  local goAlias="g-$1" switchAlias="G-$1"

  muzzle unalias "$goAlias" "$switchAlias" 2>/dev/null || :
  # shellcheck disable=SC2139
  alias "$goAlias"="cd \"$2\""
  # shellcheck disable=SC2139
  alias "$switchAlias"="applicationHome \"$2\""
  printf "%s %s\n" "$(decorate label "$(textAlignLeft 40 "$3")")" "$(decorate each code "$goAlias" "$switchAlias")"
}

__bashApplicationAlias() {
  local handler="$1" && shift

  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  [ $# -ge 2 ] || throwArgument "$handler" "alias and path are required" || return $?
  local alias && alias=$(validate "$handler" String alias "${1-}") && shift || return $?
  local path && path=$(validate "$handler" UserDirectory path "${1-}") && shift || return $?
  local name="$*"
  [ -n "$name" ] || name="$(buildEnvironmentContext "$path" buildEnvironmentGet --quiet "APPLICATION_NAME" 2>/dev/null)"
  [ -n "$name" ] || name="${path##*/}"

  __bashApplicationAliasSetup "$alias" "$path" "$name"
}

__bashApplicationAliases() {
  local handler="$1" && shift
  local returnCode=0

  [ $# -eq 0 ] || helpArgument --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local alias path && while read -r alias path name; do
    local fullPath && if fullPath=$(validate "$handler" UserDirectory path "$path"); then
      __bashApplicationAliasSetup "$alias" "$fullPath" "$name" || return $?
    else
      decorate info "No project $(decorate file "$fullPath")" 1>&2 && returnEnvironment && returnCode=$?
    fi
  done
  return "$returnCode"
}
