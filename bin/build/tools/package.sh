#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: ./docs/_templates/tools/package.md
# Test: ./test/tools/package-tests.sh

# Usage: {fn} usageFunction functionSuffix [ --help ] [ --manager packageManager ] [ --force ] ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --manager packageManager - Optional. String. Package manager to use. (apk, apt, brew)
# Argument: --force - Optional. Flag. Force even if it seems to be installed.
# Argument: --before beforeFunction - Optional. Function. One or more functions to run before list function. `muzzle`d.
__packageListFunction() {
  local usage="$1" functionVerb="$2"
  local argument nArguments argumentIndex saved
  local quietLog manager="" packageFunction name cacheFile=".packageUpdate" forceFlag=false start lastModified
  local beforeFunction

  shift 2
  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
        packageManagerValid "$manager" || __failArgument "$usage" "Manager is invalid: $(consoleCode "$manager")" || return $?
        ;;
      *)
        # IDENTICAL argumentUnknown 1
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __failEnvironment "$usage" "No package manager" || return $?
  whichExists "$manager" || __failEnvironment "$usage" "$manager does not exist" || return $?

  listFunction="__${manager}${functionVerb}List"
  isFunction "$listFunction" || __failEnvironment "$usage" "$listFunction is not defined" || return $?
  [ ${#beforeFunctions[@]} -eq 0 ] || for beforeFunction in "${beforeFunctions[@]}"; do
    __usageEnvironment "$usage" muzzle "$beforeFunction" || return $?
  done
  __usageEnvironment "$usage" "$listFunction" || return $?
}

# Usage: {fn} usageFunction functionSuffix [ --help ] [ --manager packageManager ] [ --force ] ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --manager packageManager - Optional. String. Package manager to use. (apk, apt, brew)
# Argument: --force - Optional. Flag. Force even if it seems to be installed.
__pacakgeUpFunction() {
  local usage="$1" suffix="$2"
  local argument nArguments argumentIndex saved
  local quietLog manager="" packageFunction name cacheFile=".packageUpdate" forceFlag=false start lastModified

  shift 2
  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      # IDENTICAL managerArgumentHandler 5
      --manager)
        shift
        manager=$(usageArgumentString "$usage" "$argument" "${1-}")
        packageManagerValid "$manager" || __failArgument "$usage" "Manager is invalid: $(consoleCode "$manager")" || return $?
        ;;
      --force)
        forceFlag=true
        ;;
      *)
        break
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __failEnvironment "$usage" "No package manager" || return $?
  whichExists "$manager" || __failEnvironment "$usage" "$manager does not exist" || return $?

  packageFunction="__${manager}${suffix}"
  isFunction "$packageFunction" || __failEnvironment "$usage" "$packageFunction is not a defined function" || return $?

  quietLog=$(__usageEnvironment "$usage" buildQuietLog "${usage#_}${suffix}") || return $?
  name=$(__usageEnvironment "$usage" buildCacheDirectory "$cacheFile") || return $?
  __usageEnvironment "$usage" requireFileDirectory "$name" || return $?

  if $forceFlag; then
    statusMessage consoleInfo "Forcing $manager $suffix ..."
  elif [ -f "$name" ]; then
    lastModified="$(modificationSeconds "$name")"
    # once an hour, technically
    if [ "$lastModified" -lt 3600 ]; then
      return 0
    fi
  fi
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  __usageEnvironmentQuiet "$usage" "$quietLog" "$packageFunction" "$@" || return $?
  statusMessage reportTiming "$start" "${suffix} in"
  date +%s >"$name" || :
  clearLine || :
}

# Upgrade packages lists and sources
# Usage: {fn} [ --help ] [ --manager packageManager ] [ --force ] ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --manager packageManager - Optional. String. Package manager to use. (apk, apt, brew)
# Argument: --force - Optional. Flag. Force even if it was updated recently.
packageUpgrade() {
  __pacakgeUpFunction "_${FUNCNAME[0]}" Upgrade "$@"
}
_packageUpgrade() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Update packages lists and sources
# Usage: {fn} [ --help ] [ --manager packageManager ] [ --force ] ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --manager packageManager - Optional. String. Package manager to use. (apk, apt, brew)
# Argument: --force - Optional. Flag. Force even if it was updated recently.
packageUpdate() {
  __pacakgeUpFunction "_${FUNCNAME[0]}" Update "$@"
}
_packageUpdate() {
  # IDENTICAL usageDocument 1
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
# Argument: packageName ... - Required. String. The package name to install if the binary is not found in the `$PATH`.
# Environment: Technically this will install the binary and any related files as a package.
#
packageWhich() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local binary="" packages=() manager=""

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      # IDENTICAL managerArgumentHandler 5
      --manager)
        shift
        manager=$(usageArgumentString "$usage" "$argument" "${1-}")
        packageManagerValid "$manager" || __failArgument "$usage" "Manager is invalid: $(consoleCode "$manager")" || return $?
        ;;
      *)
        if [ -z "$binary" ]; then
          binary=$(usageArgumentString "$usage" "binary" "$argument") || return $?
        else
          packages+=("$(usageArgumentString "$usage" "binary" "$argument")") || return $?
        fi
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __failEnvironment "$usage" "No package manager" || return $?
  whichExists "$manager" || __failEnvironment "$usage" "$manager does not exist" || return $?

  [ -n "$binary" ] || __failArgument "$usage" "Missing binary" || return $?
  [ 0 -lt "${#packages[@]}" ] || __failArgument "$usage" "Missing packages" || return $?
  if whichExists "$binary"; then
    return 0
  fi
  __environment packageInstall --force "${packages[@]}" || return $?
  if whichExists "$binary"; then
    return 0
  fi
  __failEnvironment "$usage" "$manager packages \"${packages[*]}\" did not add $binary to the PATH: ${PATH-}" || return $?
}
_packageWhich() {
  # IDENTICAL usageDocument 1
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
  local argument nArguments argumentIndex saved
  local binary="" packages=() manager="" foundPath

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      # IDENTICAL managerArgumentHandler 5
      --manager)
        shift
        manager=$(usageArgumentString "$usage" "$argument" "${1-}")
        packageManagerValid "$manager" || __failArgument "$usage" "Manager is invalid: $(consoleCode "$manager")" || return $?
        ;;

      *)
        if [ -z "$binary" ]; then
          binary=$(usageArgumentString "$usage" "binary" "$argument") || return $?
        else
          packages+=("$(usageArgumentString "$usage" "binary" "$argument")") || return $?
        fi
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __failEnvironment "$usage" "No package manager" || return $?
  whichExists "$manager" || __failEnvironment "$usage" "$manager does not exist" || return $?

  [ -n "$binary" ] || __failArgument "$usage" "Missing binary" || return $?
  [ 0 -lt "${#packages[@]}" ] || __failArgument "$usage" "Missing packages" || return $?
  if ! whichExists "$binary"; then
    return 0
  fi
  __usageEnvironment "$usage" packageUninstall --manager "$manager" "${packages[@]}" || return $?
  if foundPath="$(which "$binary")" && [ -n "$foundPath" ]; then
    __failEnvironment "$usage" "packageUninstall ($manager) \"${packages[*]}\" did not remove $(consoleCode "$foundPath") FROM the PATH: $(consoleValue "${PATH-}")" || return $?
  fi
}
_packageWhichUninstall() {
  # IDENTICAL usageDocument 1
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
#
# shellcheck disable=SC2120
packageInstall() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local quietLog
  local actualPackages package installed standardPackages=()
  local start forceFlag=false packages=() installFunction manager=""

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      # IDENTICAL managerArgumentHandler 5
      --manager)
        shift
        manager=$(usageArgumentString "$usage" "$argument" "${1-}")
        packageManagerValid "$manager" || __failArgument "$usage" "Manager is invalid: $(consoleCode "$manager")" || return $?
        ;;
      --force)
        forceFlag=true
        ;;
      *)
        if ! inArray "$argument" "${packages[@]+"${packages[@]}"}"; then
          packages+=("$argument")
        fi
        ;;
    esac
    shift || usageArgumentMissing "$usage" "$argument" || return $?
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __failEnvironment "$usage" "No package manager" || return $?
  whichExists "$manager" || __failEnvironment "$usage" "$manager does not exist" || return $?

  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  quietLog=$(__usageEnvironment "$usage" buildQuietLog "${FUNCNAME[0]}") || return $?
  installed="$(__usageEnvironment "$usage" mktemp)" || return $?
  __usageEnvironmentQuiet "$usage" "$quietLog" packageUpdate || return $?
  __usageEnvironment "$usage" packageInstalledList --manager "$manager" >"$installed" || return $?

  IFS=$'\n' read -d '' -r -a standardPackages < <(_packageStandardPackages "$manager")
  if "$forceFlag"; then
    actualPackages=("${packages[@]}")
  else
    actualPackages=()
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
      consoleSuccess "Already installed: ${packages[*]}"
    fi
    return 0
  fi
  statusMessage consoleInfo "Installing ${packages[*]+"${packages[*]}"} ... "
  installFunction="__${manager}Install"
  isFunction "$installFunction" || __failEnvironment "$usage" "$installFunction is not defined" || return $?
  __usageEnvironmentQuiet "$usage" "$quietLog" "$installFunction" "${actualPackages[@]}" || return $?
  reportTiming "$start" OK
}
_packageInstall() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Removes packages using the current package manager.
#
# Usage: {fn} [ package ... ]
# Example:     {fn} shellcheck
# Summary: Removes packages using package manager
# Argument: package - One or more packages to uninstall
packageUninstall() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local package installed standardPackages=()
  local start packages=() uninstallFunction quietLog manager=""

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      # IDENTICAL managerArgumentHandler 5
      --manager)
        shift
        manager=$(usageArgumentString "$usage" "$argument" "${1-}")
        packageManagerValid "$manager" || __failArgument "$usage" "Manager is invalid: $(consoleCode "$manager")" || return $?
        ;;
      *)
        packages+=("$argument")
        ;;
    esac
    shift || usageArgumentMissing "$usage" "$argument" || return $?
  done

  # IDENTICAL managerArgumentValidation 2
  [ -n "$manager" ] || manager=$(packageManagerDefault) || __failEnvironment "$usage" "No package manager" || return $?
  whichExists "$manager" || __failEnvironment "$usage" "$manager does not exist" || return $?

  [ 0 -lt "${#packages[@]}" ] || __failArgument "$usage" "Requires at least one package to uninstall" || return $?

  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  quietLog=$(__usageEnvironment "$usage" buildQuietLog "${usage#_}") || return $?
  IFS=$'\n' read -d '' -r -a standardPackages < <(_packageStandardPackages "$manager")
  for package in "${packages[@]}"; do
    if inArray "$package" "${standardPackages[@]}"; then
      __failEnvironment "$usage" "Unable to remove standard package $(consoleCode "$package")" || return $?
    fi
  done
  uninstallFunction="__${manager}Uninstall"
  isFunction "$uninstallFunction" || __failEnvironment "$usage" "$uninstallFunction is not defined" || return $?

  statusMessage consoleInfo "Uninstalling ${packages[*]} ... "
  __usageEnvironmentQuiet "$usage" "$quietLog" "$uninstallFunction" "${packages[@]}" || return $?
  statusMessage reportTiming "$start" "Uninstallation of $* completed in" || :
  clearLine
}
_packageUninstall() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_packageStandardPackages() {
  local manager="$1" packageFunction
  packageFunction="__${1}StandardPackages"
  isFunction "$packageFunction" || __failEnvironment "$usage" "$packageFunction is not a defined function" || return $?
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
packageManagerDefault() {
  if apkIsInstalled; then
    printf "%s\n" "apk"
  elif aptIsInstalled; then
    printf "%s\n" "apt"
  elif [ "$(uname -s)" = "Darwin" ]; then
    printf "%s\n" "brew"
  else
    _environment "Not able to detect package manager $(_packageDebugging)" || return $?
  fi
}

# List installed packages on this system using package manager
packageInstalledList() {
  __packageListFunction "_${FUNCNAME[0]}" "Installed" "$@"
}
_packageInstalledList() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List installed packages on this system using package manager
packageAvailableList() {
  __packageListFunction "_${FUNCNAME[0]}" "Available" --before packageUpdate "$@"
}
_packageAvailableList() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} [ value ]
# INTERNAL - has `packageUpdate` set the `restart` flag at some point?
# Argument: value - Set the restart flag to this value (blank to remove)
packageNeedRestartFlag() {
  local usage="_${FUNCNAME[0]}"
  local quietLog restartFlag

  restartFlag=$(__usageEnvironment "$usage" buildCacheDirectory ".needRestart") || return $?
  if [ $# -eq 0 ]; then
    if [ -f "$restartFlag" ]; then
      __usageEnvironment "$usage" cat "$restartFlag" || return $?
    else
      return 1
    fi
  else
    if [ "$1" = "" ]; then
      rm -f "$restartFlag" || :
    else
      printf "%s\n" "$@" >"$restartFlag" || __failEnvironment "$usage" "Unable to write $restartFlag" || return $?
    fi
  fi
}
_packageNeedRestartFlag() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
