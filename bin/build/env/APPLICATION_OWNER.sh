#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Application
# Application: ALL
# Type: String
# The entity which owns or manages the application. Typically the owning company name.
# This is used in Copyright notices in code and other locations.
export APPLICATION_OWNER
__appOwnerLoader() {
  export BUILD_HOME
  # shellcheck source=/dev/null
  catchReturn returnMessage source "${BASH_SOURCE[0]%/*}/BUILD_HOME.sh" || return $?
  local home=${BUILD_HOME-}
  [ -n "$home" ] || return 0
  local f e && for e in BUILD_COMPANY COMPANY_NAME; do
    local f="$home/bin/env/$e.sh"
    if [ -f "$f" ]; then
      # shellcheck source=/dev/null
      catchReturn returnMessage source "$f" || return $?
      printf "%s\n" "${!e-}"
      return 0
    fi
  done
}
APPLICATION_OWNER="${APPLICATION_OWNER-}"
[ -n "$APPLICATION_OWNER" ] || APPLICATION_OWNER=$(__appOwnerLoader) || return $?
unset __appOwnerLoader
