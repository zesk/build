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
  local usage="$1" functionVerb="$2"
  local manager=""
  local beforeFunctions=()

  shift 2

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --before)
        shift
        beforeFunctions+=("$(usageArgumentFunction "$usage" "$argument" "${1-}")") || return $?
        ;;
      # IDENTICAL managerArgumentHandler 5
      --manager)
        shift
        manager=$(usageArgumentString "$usage" "$argument" "${1-}")
        packageManagerValid "$manager" || __throwArgument "$usage" "Manager is invalid: $(decorate code "$manager")" || return $?
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$usage" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$usage" "$manager does not exist" || return $?

  local listFunction="__${manager}${functionVerb}List"
  isFunction "$listFunction" || __throwEnvironment "$usage" "$listFunction is not defined" || return $?
  local beforeFunction
  [ ${#beforeFunctions[@]} -eq 0 ] || for beforeFunction in "${beforeFunctions[@]}"; do
    __catchEnvironment "$usage" muzzle "$beforeFunction" || return $?
  done
  __catchEnvironment "$usage" "$listFunction" || return $?
}

# Usage: {fn} usageFunction functionSuffix [ --help ] [ --manager packageManager ] [ --force ] ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --manager packageManager - Optional. String. Package manager to use. (apk, apt, brew)
# Argument: --force - Optional. Flag. Force even if it seems to be installed.
# Argument: --verbose - Optional. Flag. Force even if it seems to be installed.
# Argument: --show-log - Optional. Flag. Show the log of the package manager.
__packageUpFunction() {
  local usage="$1" suffix="$2" verb

  local manager="" forceFlag=false verboseFlag=false start lastModified showLog=false

  verb=$(lowercase "$suffix")
  shift 2
  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      # IDENTICAL managerArgumentHandler 5
      --manager)
        shift
        manager=$(usageArgumentString "$usage" "$argument" "${1-}")
        packageManagerValid "$manager" || __throwArgument "$usage" "Manager is invalid: $(decorate code "$manager")" || return $?
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
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$usage" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$usage" "$manager does not exist" || return $?

  local packageFunction="__${manager}${suffix}"
  isFunction "$packageFunction" || __throwEnvironment "$usage" "$packageFunction is not a defined function" || return $?

  local name
  name="$(__catchEnvironment "$usage" buildCacheDirectory)/.packageUpdate" || return $?
  __catchEnvironment "$usage" requireFileDirectory "$name" || return $?

  if $forceFlag; then
    ! $verboseFlag || statusMessage decorate info "Forcing $manager $verb ..."
  elif [ -f "$name" ]; then
    local lastModified
    lastModified="$(modificationSeconds "$name")"
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
    quietLog=$(__catchEnvironment "$usage" buildQuietLog "${usage#_}${suffix}") || return $?
    exec 3>&1
    exec 1>"$quietLog"
  fi
  __catchEnvironment "$usage" "$packageFunction" "$@" || return $?
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
  # _IDENTICAL_ usageDocument 1
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
  # _IDENTICAL_ usageDocument 1
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
  local usage="_${FUNCNAME[0]}"
  local binary="" packages=() manager="" forceFlag=false vv=()

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --force)
        forceFlag=true
        ;;
      --show-log | --verbose)
        vv=("$argument")
        ;;
      # IDENTICAL managerArgumentHandler 5
      --manager)
        shift
        manager=$(usageArgumentString "$usage" "$argument" "${1-}")
        packageManagerValid "$manager" || __throwArgument "$usage" "Manager is invalid: $(decorate code "$manager")" || return $?
        ;;
      -*)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
      *)
        if [ -z "$binary" ]; then
          binary=$(usageArgumentString "$usage" "binary" "$argument") || return $?
        else
          packages+=("$(usageArgumentString "$usage" "binary" "$argument")") || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$usage" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$usage" "$manager does not exist" || return $?
  [ "${#packages[@]}" -gt 0 ] || packages+=("$binary")

  if ! $forceFlag; then
    [ -n "$binary" ] || __throwArgument "$usage" "Missing binary" || return $?
    # Already installed
    ! whichExists "$binary" || return 0
  fi
  # Install packages
  __environment packageInstall "${vv[@]+"${vv[@]}"}" --manager "$manager" --force "${packages[@]}" || return $?
  # Ensure binary now exists, otherwise fail
  whichExists "$binary" || __throwEnvironment "$usage" "$manager packages \"${packages[*]}\" did not add $binary to the PATH: ${PATH-}" || return $?
}
_packageWhich() {
  # _IDENTICAL_ usageDocument 1
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
  local usage="_${FUNCNAME[0]}"

  local binary="" packages=() manager="" foundPath vv=()

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      # IDENTICAL managerArgumentHandler 5
      --manager)
        shift
        manager=$(usageArgumentString "$usage" "$argument" "${1-}")
        packageManagerValid "$manager" || __throwArgument "$usage" "Manager is invalid: $(decorate code "$manager")" || return $?
        ;;
      --verbose)
        vv=("$argument")
        ;;
      *)
        if [ -z "$binary" ]; then
          binary=$(usageArgumentString "$usage" "binary" "$argument") || return $?
        else
          packages+=("$(usageArgumentString "$usage" "binary" "$argument")") || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$usage" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$usage" "$manager does not exist" || return $?

  [ -n "$binary" ] || __throwArgument "$usage" "Missing binary" || return $?
  [ 0 -lt "${#packages[@]}" ] || __throwArgument "$usage" "Missing packages" || return $?
  if ! whichExists "$binary"; then
    return 0
  fi
  __catchEnvironment "$usage" packageUninstall "${vv[@]+"${vv[@]}"}" --manager "$manager" "${packages[@]}" || return $?
  if foundPath="$(which "$binary")" && [ -n "$foundPath" ]; then
    __throwEnvironment "$usage" "packageUninstall ($manager) \"${packages[*]}\" did not remove $(decorate code "$foundPath") FROM the PATH: $(decorate value "${PATH-}")" || return $?
  fi
}
_packageWhichUninstall() {
  # _IDENTICAL_ usageDocument 1
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
  local usage="_${FUNCNAME[0]}"

  local forceFlag=false packages=() manager="" verboseFlag=false showLog=false

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      # IDENTICAL managerArgumentHandler 5
      --manager)
        shift
        manager=$(usageArgumentString "$usage" "$argument" "${1-}")
        packageManagerValid "$manager" || __throwArgument "$usage" "Manager is invalid: $(decorate code "$manager")" || return $?
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
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$usage" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$usage" "$manager does not exist" || return $?

  local __start quietLog installed

  __start=$(timingStart) || return $?
  installed="$(__catchEnvironment "$usage" mktemp)" || return $?
  __catchEnvironment "$usage" packageUpdate "${vv[@]+"${vv[@]}"}" || return $?
  local __installStart
  __installStart=$(timingStart) || return $?
  __catchEnvironment "$usage" packageInstalledList --manager "$manager" >"$installed" || return $?

  local standardPackages=() actualPackages=() package installed installFunction
  # Loads BUILD_TEXT_BINARY
  muzzle _packageStandardPackages "$manager" || __throwEnvironment "$usage" "Unable to fetch standard packages" || return $?
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
  if [ "${#actualPackages[@]}" -eq 0 ]; then
    if [ "${#packages[@]}" -gt 0 ]; then
      ! $verboseFlag || statusMessage --last decorate success "Already installed: ${packages[*]}"
    fi
    return 0
  fi
  ! $verboseFlag || statusMessage decorate info "Installing ${packages[*]+"${packages[*]}"} ... "
  local installFunction="__${manager}Install"
  isFunction "$installFunction" || __throwEnvironment "$usage" "$installFunction is not defined" || return $?

  if ! $showLog; then
    local quietLog
    quietLog=$(__catchEnvironment "$usage" buildQuietLog "${FUNCNAME[0]}") || return $?
    exec 3>&1
    exec 1>"$quietLog"
  fi
  __catchEnvironment "$usage" "$installFunction" "${actualPackages[@]}" || return $?
  if ! $showLog; then
    exec 1>&3
  fi
  ! $verboseFlag || statusMessage timingReport "$__installStart" "Installed ${packages[*]+"${packages[*]}"} in"
  ! $verboseFlag || printf -- " %s\n" "($(timingReport "$__start" "total"))"
}
_packageInstall() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Is a package installed?
# Usage: {fn} [ package ... ]
# Argument: package - String. Required. One or more packages to check if they are installed
# Exit Code: 1 - If any packages are not installed
# Exit Code: 0 - All packages are installed
packageIsInstalled() {
  local usage="_${FUNCNAME[0]}"
  local packages=()
  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        packages+=("$argument")
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  [ "${#packages[@]}" -gt 0 ] || __throwArgument "$usage" "Requires at least one package" || return $?
  local installed
  installed=$(fileTemporaryName "$usage") || return $?
  __catchEnvironment "$usage" packageInstalledList >"$installed" || return $?
  local package
  for package in "${packages[@]}"; do
    if ! grep -q -e "^$(quoteGrepPattern "$package")$" "$installed"; then
      __catchEnvironment "$usage" rm -rf "$installed" || return $?
      return 1
    fi
  done
  __catchEnvironment "$usage" rm -rf "$installed" || return $?
}
_packageIsInstalled() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Removes packages using the current package manager.
#
# Usage: {fn} [ package ... ]
# Example:     {fn} shellcheck
# Summary: Removes packages using package manager
# Argument: package - String. Required. One or more packages to uninstall
packageUninstall() {
  local usage="_${FUNCNAME[0]}"

  local packages=() manager=""

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      # IDENTICAL managerArgumentHandler 5
      --manager)
        shift
        manager=$(usageArgumentString "$usage" "$argument" "${1-}")
        packageManagerValid "$manager" || __throwArgument "$usage" "Manager is invalid: $(decorate code "$manager")" || return $?
        ;;
      *)
        packages+=("$argument")
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __throwEnvironment "$usage" "No package manager" || return $?
  whichExists "$manager" || __throwEnvironment "$usage" "$manager does not exist" || return $?

  [ 0 -lt "${#packages[@]}" ] || __throwArgument "$usage" "Requires at least one package to uninstall" || return $?

  local start quietLog standardPackages=()

  start=$(timingStart) || return $?
  quietLog=$(__catchEnvironment "$usage" buildQuietLog "$usage") || return $?
  IFS=$'\n' read -d '' -r -a standardPackages < <(_packageStandardPackages "$manager") || :
  local package
  for package in "${packages[@]}"; do
    if inArray "$package" "${standardPackages[@]}"; then
      __throwEnvironment "$usage" "Unable to remove standard package $(decorate code "$package")" || return $?
    fi
  done
  local uninstallFunction="__${manager}Uninstall"
  isFunction "$uninstallFunction" || __throwEnvironment "$usage" "$uninstallFunction is not defined" || return $?

  statusMessage decorate info "Uninstalling ${packages[*]} ... "
  __catchEnvironmentQuiet "$usage" "$quietLog" "$uninstallFunction" "${packages[@]}" || return $?
  statusMessage --last timingReport "$start" "Uninstallation of ${packages[*]} completed in" || :
}
_packageUninstall() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_packageStandardPackages() {
  local manager="$1" packageFunction
  packageFunction="__${1}StandardPackages"
  isFunction "$packageFunction" || __throwEnvironment "$usage" "$packageFunction is not a defined function" || return $?
  __environment "$packageFunction" || return $?
}

# Is the package manager supported?
packageManagerValid() {
  case "$1" in
    apk | apt | brew) return 0 ;;
    *) return 1 ;;
  esac
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

# Determine the default manager
# See: platform
packageManagerDefault() {
  __packageManagerDefault
}

# List installed packages on this system using package manager
packageInstalledList() {
  __packageListFunction "_${FUNCNAME[0]}" "Installed" "$@"
}
_packageInstalledList() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List installed packages on this system using package manager
packageAvailableList() {
  __packageListFunction "_${FUNCNAME[0]}" "Available" --before packageUpdate "$@"
}
_packageAvailableList() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} [ value ]
# INTERNAL - has `packageUpdate` set the `restart` flag at some point?
# Argument: value - Set the restart flag to this value (blank to remove)
packageNeedRestartFlag() {
  local usage="_${FUNCNAME[0]}"
  local quietLog restartFlag

  restartFlag="$(__catchEnvironment "$usage" buildCacheDirectory)/.needRestart" || return $?
  if [ $# -eq 0 ]; then
    if [ -f "$restartFlag" ]; then
      __catchEnvironment "$usage" cat "$restartFlag" || return $?
    else
      return 1
    fi
  else
    if [ "$1" = "" ]; then
      rm -f "$restartFlag" || :
    else
      printf "%s\n" "$@" >"$restartFlag" || __throwEnvironment "$usage" "Unable to write $restartFlag" || return $?
    fi
  fi
}
_packageNeedRestartFlag() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
