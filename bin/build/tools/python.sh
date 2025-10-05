#!/usr/bin/env bash
#
# Title: Python Language Support
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# bin: npm
# Binary paths are at bin/build/install
#

# Install `python`
#
# Summary: Install `python`
# When this tool succeeds the `python` binary is available in the local operating system.
# Return Code: 1 - If installation fails
# Return Code: 0 - If installation succeeds
# Binary: python.sh
pythonInstall() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if ! whichExists python; then
    returnCatch "$handler" packageGroupInstall "$@" python || return $?
  fi
}
_pythonInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Uninstall python
pythonUninstall() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if whichExists python; then
    returnCatch "$handler" packageGroupUninstall "$@" python || return $?
  fi
}
_pythonUninstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Utility to upgrade pip correctly
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
pipUpgrade() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  returnCatch "$handler" pipWrapper install --upgrade pip || return $?
}
_pipUpgrade() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Utility to install python dependencies via pip
# Installs python if it hasn't been using `pythonInstall`.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: pipPackage [ ... ] - String. Required. Pip package name to install.
pipInstall() {
  local handler="_${FUNCNAME[0]}"

  local names=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    *)
      names+=("$(usageArgumentString "$handler" "name" "${1-}")") || return $?
      ;;
    esac
    shift
  done

  [ ${#names[@]} -gt 0 ] || throwArgument "$handler" "No pip package names specified to install" || return $?

  local start
  start=$(timingStart) || return $?

  catchEnvironment "$handler" pythonInstall || return $?

  local prettyNames
  prettyNames="$(decorate each code "${names[@]}")"
  statusMessage decorate info "Installing $prettyNames ... "

  local quietLog
  quietLog=$(returnCatch "$handler" buildQuietLog "$handler") || return $?
  catchEnvironmentQuiet "$handler" "$quietLog" pipWrapper install "${names[@]}" || returnClean $? "$quietLog" || return $?
  catchEnvironment "$handler" rm -f "$quietLog" || return $?
  statusMessage --last timingReport "$start" "Installed $prettyNames in"
}
_pipInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Utility to uninstall python dependencies via pip
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: pipPackage [ ... ] - String. Required. Pip package name to uninstall.
pipUninstall() {
  local handler="_${FUNCNAME[0]}"

  local removeNames=() names=() debugFlag=false aa=() prettyNames=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --debug) debugFlag=true && aa+=("$argument") ;;
    *)
      argument="$(usageArgumentString "$handler" "name" "$argument")" || return $?
      names+=("$argument")
      if pythonPackageInstalled "$argument"; then
        prettyNames+=("$(decorate code "$argument")")
        removeNames+=("$argument")
        ! $debugFlag || statusMessage decorate info "Package $(decorate code "$argument") is installed and will be removed" || return $?
      else
        prettyNames+=("$(decorate subtle "$argument")")
        ! $debugFlag || statusMessage decorate info "Package $(decorate code "$argument") is NOT installed" || return $?
      fi
      ;;
    esac
    shift
  done

  [ ${#names[@]} -gt 0 ] || throwArgument "$handler" "No pip package names specified to uninstall" || return $?

  [ ${#removeNames[@]} -gt 0 ] || return 0

  local start

  start=$(timingStart) || return $?

  catchEnvironment "$handler" pythonInstall "${aa[@]+"${aa[@]}"}" || return $?

  local showNames
  showNames="$(decorate each quote "${prettyNames[@]}")"
  statusMessage decorate info "Uninstalling $showNames ... "

  local quietLog
  quietLog=$(returnCatch "$handler" buildQuietLog "$handler") || return $?

  statusMessage decorate info "Uninstalling pip packages $showNames ... "
  catchEnvironmentQuiet "$handler" "$quietLog" pipWrapper uninstall "${removeNames[@]}" || return $?
  if pythonPackageInstalled --any "${names[@]}"; then
    throwEnvironment "$handler" "One or more packages are still installed: $showNames" || return $?
  fi
  statusMessage --last timingReport "$start" "Uninstalled $showNames in"
}
_pipUninstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run pip whether it is installed as a module or as a binary
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: ... - Arguments. Optional. Arguments passed to `pip`
pipWrapper() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  returnCatch "$handler" pythonInstall || return $?
  if whichExists pip; then
    returnCatch "$handler" pip "$@" || return $?
  else
    returnCatch "$handler" python -m pip "$@" || return $?
  fi
}
_pipWrapper() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Is a package installed for python?
# Argument: pipPackage ... - String. Required. Package name(s) to check.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: --any - Flag. Optional. When specified changes the behavior such that if it returns return code 0 IFF any single package is installed.
# Return Code: 0 - IFF all packages are installed.
pythonPackageInstalled() {
  local handler="_${FUNCNAME[0]}" packages=() anyMode=false
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --any) anyMode=true ;;
    *)
      packages+=("$(usageArgumentString "$handler" "pipPackage" "$1")") || return $?
      ;;
    esac
    shift
  done

  [ ${#packages[@]} -gt 0 ] || throwArgument "$handler" "No pip package names passed" || return $?
  if [ ${#packages[@]} -eq 1 ]; then
    # root@6335ec37c5a8 ~/build > pipWrapper list | grep -q "pip"
    # ERROR: Pipe to stdout was broken
    # Exception ignored in: <_io.TextIOWrapper name='<stdout>' mode='w' encoding='utf-8'>
    # BrokenPipeError: [Errno 32] Broken pipe
    # pip is still writing to stdout when grep quits after finding the package, so simply suppress pip stderr
    # To avoid this, just do the temp file always as shown below
    pipWrapper list 2>/dev/null | grep -q "$(quoteGrepPattern "${packages[0]}")" || return 1
  else
    local allPackages
    allPackages=$(fileTemporaryName "$handler") || return $?
    returnCatch "$handler" pipWrapper list >"$allPackages" || returnClean $? "$allPackages" || return $?
    for package in "${packages[@]}"; do
      if ! grepSafe -q "$(quoteGrepPattern "$package")" <"$allPackages"; then
        # Not installed
        catchEnvironment "$handler" rm -f "$allPackages" || return $?
        return 1
      elif $anyMode; then
        # $package is installed and --any
        return 0
      else
        : # $package is installed, make sure all are
      fi
    done
    catchEnvironment "$handler" rm -f "$allPackages" || return $?
    return 0
  fi
}
_pythonPackageInstalled() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Set up a virtual environment for a project and install dependencies
# Argument: --application directory - Directory. Required. Path to project location.
# Argument: --require requirements - File. Optional. Requirements file for project.
# Argument: pipPackage ... - String. Optional. One or more pip packages to install in the virtual environment.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# When completed, a directory `.venv` exists in your project containing dependencies.
pythonVirtual() {
  local handler="_${FUNCNAME[0]}"

  local application="" pp=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --application) shift && application=$(usageArgumentDirectory "$handler" "$argument" "${1-}") || return $? ;;
    --require) shift && pp+=("--requirement" "$(usageArgumentFile "$handler" "$argument" "${1-}")") || return $? ;;
    *)
      pp+=("$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    esac
    shift
  done

  [ -n "$application" ] || application=$(returnCatch "$handler" buildHome) || return $?
  [ ${#pp[@]} -gt 0 ] || throwArgument "$handler" "Need at "
  catchEnvironment "$handler" pythonInstall || return $?

  local venv="$application/.venv" clean=()
  if [ ! -d "$venv" ] || [ ! -f "$venv/bin/activate" ]; then
    if ! pythonPackageInstalled venv; then
      catchEnvironment "$handler" pipWrapper install venv || return $?
    fi
    catchEnvironment "$handler" python -m venv "$venv" || return $?
    [ -d "$venv" ] || throwEnvironment "$handler" "Unable to create $venv" || return $?
    clean+=(rm -rf "$venv" --)
  fi
  catchEnvironment "$handler" source "$venv/bin/activate" || returnClean $? "${clean[@]}" || return $?
  returnCatch "$handler" pipUpgrade || returnClean $? "${clean[@]}" || return $?
  returnCatch "$handler" pipWrapper install "${pp[@]}" || returnClean $? "${clean[@]}" || return $?
}
_pythonVirtual() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
