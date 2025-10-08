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
  local handler="returnMessage"
  local checkFunction="" noun="" thing="" installer="" uninstaller=""

  checkFunction=$(usageArgumentFunction "$handler" "checkFunction" "${1-}") && shift || return $?
  noun=$(usageArgumentString "$handler" "noun" "${1-}") && shift || return $?
  thing=$(usageArgumentString "$handler" "binary" "${1-}") && shift || return $?
  installer=$(usageArgumentFunction "$handler" "installer" "${1-}") && shift || return $?
  uninstaller=$(usageArgumentFunction "$handler" "uninstaller" "${1-}") && shift || return $?

  local uninstalledAlready=false

  if ! __testFunctionWasTested "$installer" "$uninstaller"; then
    if "$checkFunction" "$thing"; then
      __checkFunctionUninstalls "$checkFunction" "$noun" "$thing" "$uninstaller" || return $?
      uninstalledAlready=true
    else
      printf "%s\n" "$(decorate label "$noun") $(decorate value "$thing") $(decorate info "is not installed - installing")"
    fi
    __checkFunctionInstalls "$checkFunction" "$noun" "$thing" "$installer" || return $?
    if ! $uninstalledAlready; then
      __checkFunctionUninstalls "$checkFunction" "$noun" "$thing" "$uninstaller" || return $?
    fi
  else
    statusMessage decorate success "Skipping $(decorate code "$installer") and $(decorate code "$uninstaller") - already tested"
  fi
}

# Usage: {fn} checkFunction noun why thing ...
# Usage: checkFunction - Function. Required.
# Usage: noun - String. Required.
# Usage: thing - String. Required. Thing which is going to be installed.
# Usage: installer - Function. Required. Function to test.
__checkFunctionInstalls() {
  local handler="returnMessage"
  local checkFunction="" noun="" thing="" installer=""

  checkFunction=$(usageArgumentFunction "$handler" "checkFunction" "${1-}") && shift || return $?
  noun=$(usageArgumentString "$handler" "noun" "${1-}") && shift || return $?
  thing=$(usageArgumentString "$handler" "binary" "${1-}") && shift || return $?
  installer=$(usageArgumentFunction "$handler" "installer" "${1-}") && shift || return $?

  __testSection "INSTALL $(decorate value "$noun") $(decorate code "$thing")"

  ! "$checkFunction" "$thing" || returnEnvironment "$noun" "$(decorate code "$thing")" "is already installed" || return $?
  assertExitCode 0 "$installer" "$@" || return $?
  "$checkFunction" "$thing" || returnEnvironment "$noun" "$(decorate code "$thing")" "was not installed by" "$@" || return $?
}

# Usage: {fn} why checkFunction noun thing ...
__checkFunctionUninstalls() {
  local handler="returnMessage"
  local checkFunction="" noun="" thing="" installer=""

  checkFunction=$(usageArgumentFunction "$handler" "checkFunction" "${1-}") && shift || return $?
  noun=$(usageArgumentString "$handler" "noun" "${1-}") && shift || return $?
  thing=$(usageArgumentString "$handler" "binary" "${1-}") && shift || return $?
  uninstaller=$(usageArgumentFunction "$handler" "installer" "${1-}") && shift || return $?

  __testSection "UNINSTALL $(decorate value "$noun") $(decorate code "$thing")"

  "$checkFunction" "$thing" || throwEnvironment "$handler" "$noun $(decorate code "$thing") is NOT installed, can not uninstall" || return $?
  assertExitCode 0 "$uninstaller" "$@" || return $?
  ! "$checkFunction" "$thing" || throwEnvironment "$handler" "$noun $(decorate code "$thing") is still installed after uninstallation" || return $?
}
