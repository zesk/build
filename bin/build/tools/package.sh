#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/package.md
# Test: ./test/tools/package-tests.sh

# Usage: {fn} usageFunction functionSuffix [ --help ] [ --manager packageManager ] [ --force ] ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --manager packageManager - Optional. String. Package manager to use. (apk, apt, brew)
# Argument: --force - Optional. Flag. Force even if it seems to be installed.
# Argument: --before beforeFunction - Optional. Function. One or more functions to run before list function. `muzzle`d.
__packageListFunction() {
  local handler="$1" functionVerb="$2"
  local manager=""
  local beforeFunctions=()

  shift 2

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --before)
      shift
      beforeFunctions+=("$(usageArgumentFunction "$handler" "$argument" "${1-}")") || return $?
      ;;
    # IDENTICAL managerArgumentHandler 5
    --manager)
      shift
      manager=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || __throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$handler" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$handler" "$manager does not exist" || return $?

  local listFunction="__${manager}${functionVerb}List"
  isFunction "$listFunction" || __throwEnvironment "$handler" "$listFunction is not defined" || return $?
  local beforeFunction
  [ ${#beforeFunctions[@]} -eq 0 ] || for beforeFunction in "${beforeFunctions[@]}"; do
    __catchEnvironment "$handler" muzzle "$beforeFunction" || return $?
  done
  __catchEnvironment "$handler" "$listFunction" || return $?
}

# Usage: {fn} usageFunction functionSuffix [ --help ] [ --manager packageManager ] [ --force ] ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --manager packageManager - Optional. String. Package manager to use. (apk, apt, brew)
# Argument: --force - Optional. Flag. Force even if it seems to be installed.
# Argument: --verbose - Optional. Flag. Force even if it seems to be installed.
# Argument: --show-log - Optional. Flag. Show the log of the package manager.
__packageUpFunction() {
  local handler="$1" suffix="$2" verb

  local manager="" forceFlag=false verboseFlag=false start lastModified showLog=false

  verb=$(lowercase "$suffix")
  shift 2
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL managerArgumentHandler 5
    --manager)
      shift
      manager=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || __throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    --force)
      forceFlag=true
      ;;
    --show-log)
      showLog=true
      ;;
    --verbose)
      verboseFlag=true
      ;;
    *)
      break
      ;;
    esac
    shift
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$handler" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$handler" "$manager does not exist" || return $?

  local packageFunction="__${manager}${suffix}"
  isFunction "$packageFunction" || __throwEnvironment "$handler" "$packageFunction is not a defined function" || return $?

  local name
  name="$(__catch "$handler" buildCacheDirectory)/.packageUpdate" || return $?

  if $forceFlag; then
    ! $verboseFlag || statusMessage decorate info "Forcing $manager $verb ..."
  elif [ -f "$name" ]; then
    local lastModified
    lastModified="$(fileModificationSeconds "$name")"
    # once an hour, technically
    local threshold=3600
    if [ "$lastModified" -lt "$threshold" ]; then
      ! $verboseFlag || statusMessage --last decorate info "Updated $lastModified (threshold is $threshold) seconds ago. System is up to date."
      return 0
    fi
  fi
  start=$(timingStart) || return $?
  ! $verboseFlag || statusMessage decorate warning "${suffix} ..."

  if ! $showLog; then
    local quietLog
    quietLog=$(__catch "$handler" buildQuietLog "${handler#_}${suffix}") || return $?
    exec 3>&1
    exec 1>"$quietLog"
  fi
  __catchEnvironment "$handler" "$packageFunction" "$@" || return $?
  if ! $showLog; then
    exec 1>&3
  fi
  ! $verboseFlag || statusMessage --last timingReport "$start" "$suffix $(decorate subtle "completed in")"
  date +%s >"$name" || :
}

# Upgrade packages lists and sources
# Usage: {fn} [ --help ] [ --manager packageManager ] [ --force ] ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --verbose - Optional. Flag. Display progress to the terminal.
# Argument: --manager packageManager - Optional. String. Package manager to use. (apk, apt, brew)
# Argument: --force - Optional. Flag. Force even if it was updated recently.
packageUpgrade() {
  __packageUpFunction "_${FUNCNAME[0]}" Upgrade "$@"
}
_packageUpgrade() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Update packages lists and sources
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --verbose - Optional. Flag. Display progress to the terminal.
# Argument: --manager packageManager - Optional. String. Package manager to use. (apk, apt, brew)
# Argument: --force - Optional. Flag. Force even if it was updated recently.
packageUpdate() {
  __packageUpFunction "_${FUNCNAME[0]}" Update "$@"
}
_packageUpdate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Fetch the binary name for the default package in a group
# Groups are:
# - mysql
# - mysqldump
packageDefault() {
  local handler="_${FUNCNAME[0]}"

  local lookup=() manager=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL managerArgumentHandler 5
    --manager)
      shift
      manager=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || __throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    -*)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    *)
      lookup+=("$(usageArgumentString "$handler" "binary" "$argument")") || return $?
      ;;
    esac
    shift
  done
  [ "${#lookup[@]}" -gt 0 ] || __throwArgument "$handler" "Need at least one name" || return $?

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$handler" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$handler" "$manager does not exist" || return $?

  local function="__${manager}Default"
  if ! isFunction "$function"; then
    __throwEnvironment "$handler" "Missing $function implementation for $manager" || return $?
  fi
  "$function" "${lookup[@]}"
}
_packageDefault() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Installs an apt package if a binary does not exist in the which path.
# The assumption here is that `packageInstallPackage` will install the desired `binary`.
#
# Confirms that `binary` is installed after installation succeeds.
#
# Summary: Install tools using `apt-get` if they are not found
# Usage: {fn} binary packageInstallPackage ...
# Example:     packageWhich shellcheck shellcheck
# Example:     packageWhich mariadb mariadb-client
# Argument: --manager packageManager - Optional. String. Package manager to use. (apk, apt, brew)
# Argument: binary - Required. String. The binary to look for
# Argument: packageName ... - Optional. String. The package name to install if the binary is not found in the `$PATH`. If not supplied uses the same name as the binary.
# Environment: Technically this will install the binary and any related files as a package.
packageWhich() {
  local handler="_${FUNCNAME[0]}"
  local binary="" packages=() manager="" forceFlag=false vv=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --force)
      forceFlag=true
      ;;
    --show-log | --verbose)
      vv=("$argument")
      ;;
    # IDENTICAL managerArgumentHandler 5
    --manager)
      shift
      manager=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || __throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    -*)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    *)
      if [ -z "$binary" ]; then
        binary=$(usageArgumentString "$handler" "binary" "$argument") || return $?
      else
        packages+=("$(usageArgumentString "$handler" "binary" "$argument")") || return $?
      fi
      ;;
    esac
    shift
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$handler" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$handler" "$manager does not exist" || return $?
  [ "${#packages[@]}" -gt 0 ] || packages+=("$binary")

  if ! $forceFlag; then
    [ -n "$binary" ] || __throwArgument "$handler" "Missing binary" || return $?
    # Already installed
    ! whichExists "$binary" || return 0
  fi
  # Install packages
  __environment packageInstall "${vv[@]+"${vv[@]}"}" --manager "$manager" --force "${packages[@]}" || return $?
  # Ensure binary now exists, otherwise fail
  whichExists "$binary" || __throwEnvironment "$handler" "$manager packages \"${packages[*]}\" did not add $binary to the PATH: ${PATH-}" || return $?
}
_packageWhich() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Installs an apt package if a binary does not exist in the `which` path (e.g. `$PATH`)
# The assumption here is that `packageUninstall` will install the desired `binary`.
#
# Confirms that `binary` is installed after installation succeeds.
#
# Summary: Install tools using `apt-get` if they are not found
# Usage: {fn} binary packageInstallPackage ...
# Example:     packageWhichUninstall shellcheck shellcheck
# Example:     packageWhichUninstall mariadb mariadb-client
# Argument: --manager packageManager - Optional. String. Package manager to use. (apk, apt, brew)
# Argument: binary - Required. String. The binary to look for.
# Argument: packageInstallPackage - Required. String. The package name to uninstall if the binary is found in the `$PATH`.
# Environment: Technically this will uninstall the binary and any related files as a package.
#
packageWhichUninstall() {
  local handler="_${FUNCNAME[0]}"

  local binary="" packages=() manager="" foundPath vv=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL managerArgumentHandler 5
    --manager)
      shift
      manager=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || __throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    --verbose)
      vv=("$argument")
      ;;
    *)
      if [ -z "$binary" ]; then
        binary=$(usageArgumentString "$handler" "binary" "$argument") || return $?
      else
        packages+=("$(usageArgumentString "$handler" "binary" "$argument")") || return $?
      fi
      ;;
    esac
    shift
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$handler" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$handler" "$manager does not exist" || return $?

  [ -n "$binary" ] || __throwArgument "$handler" "Missing binary" || return $?
  [ 0 -lt "${#packages[@]}" ] || __throwArgument "$handler" "Missing packages" || return $?
  if ! whichExists "$binary"; then
    return 0
  fi
  __catch "$handler" packageUninstall "${vv[@]+"${vv[@]}"}" --manager "$manager" "${packages[@]}" || return $?
  if foundPath="$(which "$binary")" && [ -n "$foundPath" ]; then
    __throwEnvironment "$handler" "packageUninstall ($manager) \"${packages[*]}\" did not remove $(decorate code "$foundPath") FROM the PATH: $(decorate value "${PATH-}")" || return $?
  fi
}
_packageWhichUninstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Install packages using a package manager.
#
# Supported managers:
# - apk
# - apt-get
# - brew
#
# Usage: {fn} [ package ... ]
# Example:     {fn} shellcheck
# Exit Code: 0 - If `apk` is not installed, returns 0.
# Exit Code: 1 - If `apk` fails to install the packages
# Summary: Install packages using a package manager
# Argument: package - One or more packages to install
# Artifact: `{fn}.log` is left in the `buildCacheDirectory`
# Argument: --verbose - Optional. Flag. Display progress to the terminal.
# Argument: --manager packageManager - Optional. String. Package manager to use. (apk, apt, brew)
# Argument: --force - Optional. Flag. Force even if it was updated recently.
# Argument: --show-log - Optional. Flag. Show package manager logs.
packageInstall() {
  local handler="_${FUNCNAME[0]}"

  local forceFlag=false packages=() manager="" verboseFlag=false showLog=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL managerArgumentHandler 5
    --manager)
      shift
      manager=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || __throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    --force)
      forceFlag=true
      ;;
    --verbose)
      verboseFlag=true
      ;;
    --show-log)
      vv+=(--show-log)
      ;;
    *)
      if ! inArray "$argument" "${packages[@]+"${packages[@]}"}"; then
        packages+=("$argument")
      fi
      ;;
    esac
    shift
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$handler" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$handler" "$manager does not exist" || return $?

  local __start quietLog installed

  __start=$(timingStart) || return $?
  installed="$(fileTemporaryName "$handler")" || return $?
  __catch "$handler" packageUpdate "${vv[@]+"${vv[@]}"}" || return $?
  local __installStart clean=()
  __installStart=$(timingStart) || return $?
  __catch "$handler" packageInstalledList --manager "$manager" >"$installed" || return $?
  clean+=("$installed")
  local standardPackages=() actualPackages=() package installFunction
  # Loads BUILD_TEXT_BINARY
  muzzle _packageStandardPackages "$manager" || __throwEnvironment "$handler" "Unable to fetch standard packages" || returnClean $? "${clean[@]}" || return $?
  IFS=$'\n' read -d '' -r -a standardPackages < <(_packageStandardPackages "$manager") || :
  if "$forceFlag"; then
    actualPackages=("${packages[@]}")
  else
    local package
    for package in "${packages[@]+"${packages[@]}"}" "${standardPackages[@]}"; do
      [ -n "$package" ] || continue
      if ! grep -q -e "^$package" <"$installed"; then
        if ! inArray "$package" "${actualPackages[@]+"${actualPackages[@]}"}"; then
          actualPackages+=("$package")
        fi
      elif $forceFlag; then
        if ! inArray "$package" "${actualPackages[@]+"${actualPackages[@]}"}"; then
          actualPackages+=("$package")
        fi
      fi
    done
  fi
  __catchEnvironment "$handler" rm -f "$installed" || return $?
  if [ "${#actualPackages[@]}" -eq 0 ]; then
    if [ "${#packages[@]}" -gt 0 ]; then
      ! $verboseFlag || statusMessage --last decorate success "Already installed: ${packages[*]}"
    fi
    return 0
  fi
  ! $verboseFlag || statusMessage decorate info "Installing ${packages[*]+"${packages[*]}"} ... "
  local installFunction="__${manager}Install"
  isFunction "$installFunction" || __throwEnvironment "$handler" "$installFunction is not defined" || return $?

  if ! $showLog; then
    local quietLog
    quietLog=$(__catch "$handler" buildQuietLog "${FUNCNAME[0]}") || return $?
    exec 3>&1
    exec 1>"$quietLog"
  fi
  __catchEnvironment "$handler" "$installFunction" "${actualPackages[@]}" || return $?
  if ! $showLog; then
    exec 1>&3
  fi
  ! $verboseFlag || statusMessage timingReport "$__installStart" "Installed ${packages[*]+"${packages[*]}"} in"
  ! $verboseFlag || printf -- " %s\n" "($(timingReport "$__start" "total"))"
}
_packageInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Is a package installed?
# Usage: {fn} [ package ... ]
# Argument: package - String. Required. One or more packages to check if they are installed
# Exit Code: 1 - If any packages are not installed
# Exit Code: 0 - All packages are installed
packageIsInstalled() {
  local handler="_${FUNCNAME[0]}"
  local packages=()
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      packages+=("$argument")
      ;;
    esac
    shift
  done
  [ "${#packages[@]}" -gt 0 ] || __throwArgument "$handler" "Requires at least one package" || return $?
  local installed
  installed=$(fileTemporaryName "$handler") || return $?
  __catch "$handler" packageInstalledList >"$installed" || return $?
  local package
  for package in "${packages[@]}"; do
    if ! grep -q -e "^$(quoteGrepPattern "$package")$" "$installed"; then
      __catchEnvironment "$handler" rm -rf "$installed" || return $?
      return 1
    fi
  done
  __catchEnvironment "$handler" rm -rf "$installed" || return $?
}
_packageIsInstalled() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Removes packages using the current package manager.
#
# Usage: {fn} [ package ... ]
# Example:     {fn} shellcheck
# Summary: Removes packages using package manager
# Argument: package - String. Required. One or more packages to uninstall
# Argument: --manager packageManager - Optional. String. Package manager to use. (apk, apt, brew)
packageUninstall() {
  local handler="_${FUNCNAME[0]}"

  local packages=() manager=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL managerArgumentHandler 5
    --manager)
      shift
      manager=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || __throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    *)
      packages+=("$argument")
      ;;
    esac
    shift
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$handler" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$handler" "$manager does not exist" || return $?

  [ 0 -lt "${#packages[@]}" ] || __throwArgument "$handler" "Requires at least one package to uninstall" || return $?

  local start quietLog standardPackages=()

  start=$(timingStart) || return $?
  quietLog=$(__catch "$handler" buildQuietLog "$handler") || return $?
  IFS=$'\n' read -d '' -r -a standardPackages < <(_packageStandardPackages "$manager") || :
  local package
  for package in "${packages[@]}"; do
    if inArray "$package" "${standardPackages[@]}"; then
      __throwEnvironment "$handler" "Unable to remove standard package $(decorate code "$package")" || return $?
    fi
  done
  local uninstallFunction="__${manager}Uninstall"
  isFunction "$uninstallFunction" || __throwEnvironment "$handler" "$uninstallFunction is not defined" || return $?

  statusMessage decorate info "Uninstalling ${packages[*]} ... "
  __catchEnvironmentQuiet "$handler" "$quietLog" "$uninstallFunction" "${packages[@]}" || return $?
  statusMessage --last timingReport "$start" "Uninstallation of ${packages[*]} completed in" || :
}
_packageUninstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_packageStandardPackages() {
  local manager="$1" packageFunction
  packageFunction="__${1}StandardPackages"
  isFunction "$packageFunction" || __throwEnvironment "$handler" "$packageFunction is not a defined function" || return $?
  __environment "$packageFunction" || return $?
}

# Is the package manager supported?
# Checks the package manager to be a valid, supported one.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: packageManager - String. Manager to check.
# Exit Code: 0 - The package manager is valid.
# Exit Code: 1 - The package manager is not valid.
packageManagerValid() {
  local handler="_${FUNCNAME[0]}"
  case "${1-}" in
  # _IDENTICAL_ helpHandler 1
  --help) "$handler" 0 && return $? || return $? ;;
  apk | apt | brew | port) return 0 ;;
  *) return 1 ;;
  esac
}
_packageManagerValid() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_packageDebugging() {
  local bin
  printf "\n"
  for bin in apk dpkg apt-get; do
    printf -- "%s: %s\n" "$bin" "$(which "$bin")"
  done
  # shellcheck disable=SC2012
  ls -lad /etc/ | dumpPipe "/etc/ listing"
}

# Determine the default package manager on this platform.
# Output is one of:
# - apk apt brew port
# See: platform
packageManagerDefault() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  export BUILD_PACKAGE_MANAGER
  __environment buildEnvironmentLoad BUILD_PACKAGE_MANAGER || return $?
  __packageManagerDefault "${BUILD_PACKAGE_MANAGER-}"
}
_packageManagerDefault() {
  true || packageManagerDefault --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List installed packages on this system using package manager
packageInstalledList() {
  __packageListFunction "_${FUNCNAME[0]}" "Installed" "$@"
}
_packageInstalledList() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List installed packages on this system using package manager
packageAvailableList() {
  __packageListFunction "_${FUNCNAME[0]}" "Available" --before packageUpdate "$@"
}
_packageAvailableList() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} [ value ]
# INTERNAL - has `packageUpdate` set the `restart` flag at some point?
# Argument: value - Set the restart flag to this value (blank to remove)
packageNeedRestartFlag() {
  local handler="_${FUNCNAME[0]}"
  local quietLog restartFile

  restartFile="$(__catch "$handler" buildCacheDirectory)/.needRestart" || return $?
  if [ $# -eq 0 ]; then
    if [ -f "$restartFile" ]; then
      __catchEnvironment "$handler" cat "$restartFile" || return $?
    else
      return 1
    fi
  else
    [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
    if [ "$1" = "" ]; then
      __catchEnvironment "$handler" rm -f "$restartFile" || return $?
    else
      printf "%s\n" "$@" >"$restartFile" || __throwEnvironment "$handler" "Unable to write $restartFile" || return $?
    fi
  fi
}
_packageNeedRestartFlag() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Install a package group
# Argument: group - String. Required. Currently allowed: "python"
# Any unrecognized groups are installed using the name as-is.
packageGroupInstall() {
  local handler="_${FUNCNAME[0]}"
  local groups=() manager=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL managerArgumentHandler 5
    --manager)
      shift
      manager=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || __throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    *)
      groups+=("$(usageArgumentString "$handler" "group" "$argument")") || return $?
      ;;
    esac
    shift
  done

  [ 0 -lt "${#groups[@]}" ] || __throwArgument "$handler" "Requires at least one package to map" || return $?

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$handler" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$handler" "$manager does not exist" || return $?

  local package group
  for group in "${groups[@]}"; do
    local packages=()
    while read -r package; do packages+=("$package"); done < <(packageMapping --manager "$manager" "$group")
    __catch "$handler" packageInstall --manager "$manager" "${packages[@]}" || return $?
  done
}
_packageGroupInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Uninstall a package group
# Argument: group - String. Required. Currently allowed: "python"
# Any unrecognized groups are uninstalled using the name as-is.
packageGroupUninstall() {
  local handler="_${FUNCNAME[0]}"
  local groups=() manager=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL managerArgumentHandler 5
    --manager)
      shift
      manager=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || __throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    *)
      groups+=("$(usageArgumentString "$handler" "group" "$argument")") || return $?
      ;;
    esac
    shift
  done

  [ 0 -lt "${#groups[@]}" ] || __throwArgument "$handler" "Requires at least one package to map" || return $?

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$handler" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$handler" "$manager does not exist" || return $?

  local package group
  for group in "${groups[@]}"; do
    local packages=()
    while read -r package; do packages+=("$package"); done < <(packageMapping --manager "$manager" "$group")
    __catch "$handler" packageUninstall --manager "$manager" "${packages[@]}" || return $?
  done
}
_packageGroupUninstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: packageName - A simple package name which will be expanded to specific platform or package-manager specific package names
# Argument: --manager packageManager - Optional. String. Package manager to use. (apk, apt, brew)
packageMapping() {
  local handler="_${FUNCNAME[0]}"
  local packages=() manager=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL managerArgumentHandler 5
    --manager)
      shift
      manager=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || __throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    *)
      packages+=("$argument")
      ;;
    esac
    shift
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$handler" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$handler" "$manager does not exist" || return $?

  [ 0 -lt "${#packages[@]}" ] || __throwArgument "$handler" "Requires at least one package to map" || return $?
  local method="__${manager}PackageMapping"
  isFunction "$method" || __throwEnvironment "$handler" "Missing method $method for package manager $manager" || return $?
  local package
  for package in "${packages[@]}"; do
    __catchEnvironment "$handler" "$method" "$package" || return $?
  done
}
_packageMapping() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
