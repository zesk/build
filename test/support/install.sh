#!/usr/bin/env bash
#
# api-tests.sh
#
# API tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

__doesScriptInstallUninstall() {
  local binary=$1 script=$2 undoScript="$3"
  local uninstalledAlready

  uninstalledAlready=false
  if whichExists "$binary"; then
    __testSection "UNINSTALL $binary (already)" || :
    __environment "$undoScript" || return $?
    uninstalledAlready=true
  else
    consoleInfo "binary $binary is not installed - installing"
  fi
  __doesScriptInstall "$binary" "$script" || return $?
  if ! $uninstalledAlready; then
    __testSection "UNINSTALL $binary (just installed)" || :
    __environment "$undoScript" || return $?
    ! whichExists "$binary" || _environment "binary" "$(consoleCode "$binary")" "exists after uninstalling" || return $?
  fi
}
