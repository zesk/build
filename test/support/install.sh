#!/usr/bin/env bash
#
# api-tests.sh
#
# API tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Argument: binary
# Argument: installer
# Argument: uninstaller
__checkFunctionInstallsAndUninstallsBinary() {
  __checkFunctionInstallsAndUninstalls "executableExists" "Binary" "$@"
}

# Argument: packageName
# Argument: installer
# Argument: uninstaller
__checkFunctionInstallsAndUninstallsPackage() {
  __checkFunctionInstallsAndUninstalls "packageIsInstalled" "Package" "$@"
}

# Argument: binary
# Argument: installer
__checkFunctionInstallsBinary() {
  __checkFunctionInstalls "executableExists" "Binary" "$@"
}

# Argument: packageName
# Argument: installer
__checkFunctionInstallsPackage() {
  __checkFunctionInstalls "packageIsInstalled" "Package" "$@"
}

# Argument: checkFunction
# Argument: noun
# Argument: thing
# Argument: binary
# Argument: installer
# Argument: uninstaller
__checkFunctionInstallsAndUninstalls() {
  local handler="returnMessage"
  local checkFunction="" noun="" thing="" installer="" uninstaller=""

  checkFunction=$(validate "$handler" function "checkFunction" "${1-}") && shift || return $?
  noun=$(validate "$handler" string "noun" "${1-}") && shift || return $?
  thing=$(validate "$handler" string "binary" "${1-}") && shift || return $?
  installer=$(validate "$handler" function "installer" "${1-}") && shift || return $?
  uninstaller=$(validate "$handler" function "uninstaller" "${1-}") && shift || return $?

  local uninstalledAlready=false

  if ! testSuiteFunctionTested "$installer" "$uninstaller"; then
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

# Argument: checkFunction - Function. Required.
# Argument: noun - String. Required.
# Argument: thing - String. Required. Thing which is going to be installed.
# Argument: installer - Function. Required. Function to test.
__checkFunctionInstalls() {
  local handler="returnMessage"
  local checkFunction="" noun="" thing="" installer=""

  checkFunction=$(validate "$handler" function "checkFunction" "${1-}") && shift || return $?
  noun=$(validate "$handler" string "noun" "${1-}") && shift || return $?
  thing=$(validate "$handler" string "binary" "${1-}") && shift || return $?
  installer=$(validate "$handler" function "installer" "${1-}") && shift || return $?

  __testSection "INSTALL $(decorate value "$noun") $(decorate code "$thing")"

  ! "$checkFunction" "$thing" || returnEnvironment "$noun" "$(decorate code "$thing")" "is already installed" || return $?
  assertExitCode 0 "$installer" "$@" || return $?
  "$checkFunction" "$thing" || returnEnvironment "$noun" "$(decorate code "$thing") was not installed by $(decorate error "$installer")" || return $?
}

# Argument: checkFunction - Function. Required.
# Argument: noun - String. Required.
# Argument: thing - String. Required. Thing which is going to be installed.
# Argument: uninstaller - Function. Required. Function to test.
__checkFunctionUninstalls() {
  local handler="returnMessage"
  local checkFunction="" noun="" thing="" uninstaller=""

  checkFunction=$(validate "$handler" function "checkFunction" "${1-}") && shift || return $?
  noun=$(validate "$handler" string "noun" "${1-}") && shift || return $?
  thing=$(validate "$handler" string "binary" "${1-}") && shift || return $?
  uninstaller=$(validate "$handler" function "installer" "${1-}") && shift || return $?

  __testSection "UNINSTALL $(decorate value "$noun") $(decorate code "$thing")"

  "$checkFunction" "$thing" || throwEnvironment "$handler" "$noun $(decorate code "$thing") is NOT installed, can not uninstall" || return $?
  assertExitCode 0 "$uninstaller" "$@" || return $?
  ! "$checkFunction" "$thing" || throwEnvironment "$handler" "$noun $(decorate code "$thing") is still installed after uninstallation by $(decorate error "$uninstaller"))" || return $?
}
