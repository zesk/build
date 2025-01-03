#!/usr/bin/env bash
#
# api-tests.sh
#
# API tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Usage: {fn} binary installer uninstaller
__checkFunctionInstallsAndUninstallsBinary() {
  __checkFunctionInstallsAndUninstalls "whichExists" "Binary" "$@"
}

# Usage: {fn} packageName installer uninstaller
__checkFunctionInstallsAndUninstallsPackage() {
  __checkFunctionInstallsAndUninstalls "packageIsInstalled" "Package" "$@"
}

# Usage: {fn} binary installer
__checkFunctionInstallsBinary() {
  __checkFunctionInstalls "whichExists" "Binary" "$@"
}

# Usage: {fn} packageName installer
__checkFunctionInstallsPackage() {
  __checkFunctionInstalls "packageIsInstalled" "Package" "$@"
}

# Usage: {fn} checkFunction noun thing installer uninstaller
__checkFunctionInstallsAndUninstalls() {
  local checkFunction="$1" noun="$2" thing="$3" installer="$4" uninstaller="$5"
  local uninstalledAlready=false

  if ! __testFunctionWasTested "$installer" "$uninstaller"; then
    if "$checkFunction" "$thing"; then
      __checkFunctionUninstalls "already installed" "$checkFunction" "$noun" "$thing" "$uninstaller" || return $?
      uninstalledAlready=true
    else
      printf "%s\n" "$(decorate label "$noun") $(decorate value "$thing") $(decorate info "is not installed - installing")"
    fi
    __checkFunctionInstalls "$checkFunction" "$noun" "$thing" "$installer" || return $?
    if ! $uninstalledAlready; then
      __checkFunctionUninstalls "just installed" "$checkFunction" "$noun" "$thing" "$uninstaller" || return $?
    fi
  else
    statusMessage decorate success "Skipping $(decorate code "$installer") and $(decorate code "$uninstaller") - already tested"
  fi
}

# Usage: {fn} checkFunction noun why thing ...
__checkFunctionInstalls() {
  local checkFunction="$1" noun="$2" thing="$3" && shift 3 || _argument "Missing arguments" || return $?

  __testSection "INSTALL $(decorate value "$noun") $(decorate code "$thing")"

  ! "$checkFunction" "$thing" || _environment "$noun" "$(decorate code "$thing")" "is already installed" || return $?
  __environment "$@" || return $?
  "$checkFunction" "$thing" || _environment "$noun" "$(decorate code "$thing")" "was not installed by" "$@" || return $?
}

# Usage: {fn} why checkFunction noun thing ...
__checkFunctionUninstalls() {
  local why="$1" && shift
  local checkFunction="$1" noun="$2" thing="$3" && shift 3 || _argument "Missing arguments" || return $?

  __testSection "UNINSTALL $(decorate value "$noun") $(decorate code "$thing") ($(decorate bold-red "$why"))"

  "$checkFunction" "$thing" || _environment "$noun" "$(decorate code "$thing")" "is NOT installed, can not uninstall" || return $?
  __environment "$@" || return $?
  ! "$checkFunction" "$thing" || _environment "$noun" "$(decorate code "$thing")" "is still installed after uninstallation ($why)" || return $?
}
