#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Zesk Build tools
#
# Test: o test/tools/self-tests.sh
# Docs: o docs/_templates/tools/build.md

# Installs an installer the first time in a new project, and modifies it to work in the application path.
# Argument: --help - Optional. Flag. This help.
# Argument: --diff - Optional. Flag. Show differences between new and old files if changed.
# Argument: --url - Optional. URL. A remote URL to download the installation script.
# Argument: --url-function - Optional. Callable. Fetch the remote URL where the installation script is found.
# Argument: --source - Required. File. The local copy of the `--bin` file.
# Argument: --local - Optional. Flag. Use local copy `--bin` instead of downloaded version.
# Argument: --bin - Required. String. Name of the installer file.
# Argument: path - Optional. Directory. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.
# Argument: applicationHome - Optional. Directory. Path to the application home directory. Default is current directory.
# Usage: {fn} [ --help ] [ --diff ] [ --local ] [ path [ applicationHome ] ]
installInstallBinary() {
  local usage="_${FUNCNAME[0]}"

  local exitCode=0
  local path="" applicationHome="" temp relTop home
  local installBinName="" source="" target url="" urlFunction="" postFunction="" showDiffFlag=false source verb localFlag=false

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
      --bin)
        shift
        installBinName=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      --url-function)
        shift
        urlFunction=$(usageArgumentCallable "$usage" "$argument" "${1-}") || return $?
        ;;
      --post)
        shift
        postFunction=$(usageArgumentCallable "$usage" "$argument" "${1-}") || return $?
        ;;
      --url)
        shift
        url=$(usageArgumentURL "$usage" "$argument" "${1-}") || return $?
        ;;
      --source)
        shift
        source=$(usageArgumentFile "$usage" "$argument" "${1-}") || return $?
        ;;
      --diff)
        showDiffFlag=true
        ;;
      --local)
        localFlag=true
        ;;
      *)
        if [ -z "$path" ]; then
          path=$(usageArgumentFileDirectory "$usage" "path" "$1") || return $?
        elif [ -z "$applicationHome" ]; then
          applicationHome=$(usageArgumentDirectory "$usage" "applicationHome" "$1") || return $?
        else
          # _IDENTICAL_ argumentUnknown 1
          __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$installBinName" ] || __throwArgument "$usage" "--bin is required" || return $?
  [ -n "$source" ] || __throwArgument "$usage" "--local-path is required" || return $?

  # Validate paths and force realPath
  # default application home is $(pwd)
  [ -n "$applicationHome" ] || applicationHome="$(__catchEnvironment "$usage" pwd)" || return $?
  # default installation path home is $(pwd)/bin
  [ -n "$path" ] || path="$applicationHome/bin"
  path=$(__catchEnvironment "$usage" realPath "$path") || return $?
  applicationHome="$(__catchEnvironment "$usage" realPath "$applicationHome")" || return $?

  # Custom target binary?
  if [ "${path%.sh}" != "$path" ]; then
    target="$path"
    path=$(__catchEnvironment "$usage" dirname "$path") || return $?
  elif [ -d "$path" ]; then
    target="$path/$installBinName"
  else
    __throwEnvironment "$usage" "$path is not a directory" || return $?
  fi

  # Compute relTop
  relTop="${path#"$applicationHome"}"
  if [ "$relTop" = "$path" ]; then
    __throwArgument "$usage" "Path ($path) ($(realPath "$path")) is not within applicationHome ($applicationHome)" || return $?
  fi
  relTop=$(directoryRelativePath "$relTop")

  # Get installation binary
  temp="$path/.downloaded.$$"
  if $localFlag; then
    home=$(__catchEnvironment "$usage" buildHome) || return $?
    [ -x "$source" ] || __throwEnvironment "$usage" "$source is not executable" || return $?
    __catchEnvironment "$usage" cp "$source" "$temp" || return $?
  else
    if [ -z "$url" ]; then
      [ -n "$urlFunction" ] || __catchArgument "$usage" "Need --url or --url-function" || return $?
      url=$("$urlFunction" "$usage") || return $?
      [ -n "$url" ] || __throwEnvironment "$urlFunction failed to generate a URL" || return $?
      urlValid "$url" || __throwEnvironment "$urlFunction failed to generate a VALID URL: $url" || return $?
    fi
    if ! curl -s -o - "$url" >"$temp"; then
      __throwEnvironment "$usage" "Unable to download $(decorate code "$url")" || _clean $? "$temp" || return $?
    fi
  fi
  if _installInstallBinaryCanCustomize "$temp"; then
    __catchEnvironment "$usage" _installInstallBinaryCustomize "$relTop" <"$temp" >"$temp.custom" || _clean $? "$temp" "$temp.custom" || return $?
    __catchEnvironment "$usage" mv -f "$temp.custom" "$temp" || _clean $? "$temp" "$temp.custom" || return $?
  fi
  if [ -n "$postFunction" ]; then
    __catchEnvironment "$usage" "$postFunction" <"$temp" >"$temp.custom" || _clean $? "$temp" "$temp.custom" || return $?
    __catchEnvironment "$usage" mv -f "$temp.custom" "$temp" || _clean $? "$temp" "$temp.custom" || return $?
  fi

  verb=Installed
  [ ! -f "$target" ] || verb=Updated
  # Show diffs
  ! $showDiffFlag || _installInstallBinaryDiffer "$usage" "$temp" "$target" || _clean $? "$temp" || return $?
  # Copy to target
  __catchEnvironment "$usage" cp "$temp" "$target" || _clean $? "$temp" || return $?
  rm -rf "$temp" || :
  # Clean up and make executable
  __catchEnvironment "$usage" chmod +x "$target" || exitCode=$?
  [ "$exitCode" -ne 0 ] && return "$exitCode"
  # Life is good
  statusMessage --last printf -- "%s %s (%s=\"%s\")" "$(decorate success "$verb")" "$(decorate code "$target")" "$(decorate label relTop)" "$(decorate value "$relTop")"
  return 0
}
_installInstallBinary() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_installInstallBinaryCanCustomize() {
  grep -q -e '^__installPackageConfiguration ' "$@"
}
_installInstallBinaryCustomize() {
  grep -v -e '^__installPackageConfiguration '
  printf "__installPackageConfiguration %s \"%s\"\n" "$1" '$@'
}

# Installs `install-bin-build.sh` the first time in a new project, and modifies it to work in the application path.
# Argument: --help - Optional. Flag. This help.
# Argument: --diff - Optional. Flag. Show differences between new and old files if changed.
# Argument: --local - Optional. Flag. Use local copy of `install-bin-build.sh` instead of downloaded version.
# Argument: path - Optional. Directory. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.
# Argument: applicationHome - Optional. Directory. Path to the application home directory. Default is current directory.
# Usage: {fn} [ --help ] [ --diff ] [ --local ] [ path [ applicationHome ] ]
installInstallBuild() {
  local usage="_${FUNCNAME[0]}"
  local home
  local binName="install-bin-build.sh"

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  installInstallBinary "$@" --bin "$binName" --source "$home/bin/build/$binName" --url-function __installInstallBuildRemote --post __installInstallBinaryLegacy
}
_installInstallBuild() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Fetch the remote URL to get installer
__installInstallBuildRemote() {
  local usage="$1"
  export BUILD_INSTALL_URL

  __catchEnvironment "$usage" packageWhich curl curl || return $?
  __catchEnvironment "$usage" buildEnvironmentLoad BUILD_INSTALL_URL || return $?
  urlParse "${BUILD_INSTALL_URL-}" >/dev/null || __throwEnvironment "$usage" "BUILD_INSTALL_URL ($BUILD_INSTALL_URL) is not a valid URL" || return $?

  printf "%s\n" "${BUILD_INSTALL_URL}"
}

# Helper for installInstallBuild
__installInstallBinaryLegacy() {
  local temp

  temp=$(__environment mktemp) || return $?
  cat >"$temp"
  if __installInstallBinaryIsLegacy <"$temp"; then
    __catchEnvironment "$usage" __installInstallBinaryCustomizeLegacy "$relTop" <"$temp" || _clean $? "$temp" || return $?
  else
    __environment cat "$temp" || return $?
  fi
  __environment rm "$temp" || return $?
}
__installInstallBinaryIsLegacy() {
  grep -q '^relTop=' >/dev/null
}
__installInstallBinaryCustomizeLegacy() {
  sed "s/^relTop=.*$/relTop=$(quoteSedReplacement "$1")/g"
}

# Usage: {fn} source target
# Show differences between installations
_installInstallBinaryDiffer() {
  local usage="$1" diffLines
  shift
  if [ -x "$target" ]; then
    diffLines="$(__catchEnvironment "$usage" _installInstallBinaryDifferFilter -c "$@")" || return $?
    [ "$diffLines" -gt 0 ] || return 0
    decorate magenta "--- Changes: $diffLines ---"
    _installInstallBinaryDifferFilter "$@" || :
    decorate magenta "--- End of changes ---"
  fi
}

# Usage: {fn} diff-arguments
# Argument: diff-arguments - Required. Arguments. Passed to diff.
_installInstallBinaryDifferFilter() {
  diff "$@" | grep -v -e '^__installPackageConfiguration ' | grep -c '[<>]'
}

# Usage: {fn}
# Environment: BUILD_HOME
# Prints the list of functions defined in Zesk Build
buildFunctions() {
  local usage="_${FUNCNAME[0]}"
  local home
  home=$(__catchEnvironment "$usage" buildHome) || return $?
  {
    cat "$home/bin/build/tools/_sugar.sh" "$home/bin/build/tools/sugar.sh" | grep -e '^_.*() {' | cut -d '(' -f 1
    "$home/bin/build/tools.sh" declare -F | cut -d ' ' -f 3 | grep -v -e '^_'
  }
}
_buildFunctions() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Path to cache directory for build system.
#
# Defaults to `$XDG_CACHE_HOME/.build` unless `$XDG_CACHE_HOME` is not a directory.
#
# Appends any passed in arguments as path segments.
#
# Example:     logFile=$({fn} test.log)
# Argument: pathSegment - One or more directory or file path, concatenated as path segments using `/`
# Environment: XDG_CACHE_HOME
buildCacheDirectory() {
  local usage="_${FUNCNAME[0]}"
  local cache suffix

  cache=$(__catchEnvironment "$usage" buildEnvironmentGet XDG_CACHE_HOME) || return $?
  suffix="$(printf "%s/" "$@")"
  suffix="${suffix%/}"
  suffix="$(printf "%s/%s" "${cache%/}" "${suffix%/}")"
  printf "%s\n" "${suffix%/}"
}
_buildCacheDirectory() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Environment: BUILD_HOME
# Prints the build home directory (usually same as the application root)
# Environment: BUILD_HOME
buildHome() {
  local usage="_${FUNCNAME[0]}"
  export BUILD_HOME
  [ $# -eq 0 ] || __help --only "$usage" "$@" || return 0
  if [ -z "${BUILD_HOME-}" ]; then
    # shellcheck source=/dev/null
    source "$(dirname "${BASH_SOURCE[0]}")/../env/BUILD_HOME.sh" || __throwEnvironment "$usage" "BUILD_HOME.sh failed" || return $?
    [ -n "${BUILD_HOME-}" ] || __throwEnvironment "$usage" "BUILD_HOME STILL blank" || return $?
  fi
  printf "%s\n" "${BUILD_HOME-}"
}
_buildHome() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Parent: buildHome
_buildEnvironmentPath() {
  local paths=() home

  export BUILD_ENVIRONMENT_DIRS BUILD_HOME
  if [ -z "$BUILD_HOME" ]; then
    home=$(__environment buildHome) || return $?
  else
    home="$BUILD_HOME"
  fi
  # shellcheck source=/dev/null
  source "$home/bin/build/env/BUILD_ENVIRONMENT_DIRS.sh" || _environment "BUILD_ENVIRONMENT_DIRS.sh fail" || return $?

  IFS=":" read -r -a paths <<<"${BUILD_ENVIRONMENT_DIRS-}" || :
  printf "%s\n" "${paths[@]+"${paths[@]}"}" "$home/bin/build/env"
}

#
# Load one or more environment settings from the environment file path.
#
# Usage: {fn} [ envName ... ]
# Argument: envName - Optional. String. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.
#
# If BOTH files exist, both are sourced, so application environments should anticipate values
# created by build's default.
#
# Modifies local environment. Not usually run within a subshell.
#
# Environment: $envName
# Environment: BUILD_ENVIRONMENT_DIRS - `:` separated list of paths to load env files
#
buildEnvironmentLoad() {
  local usage="_${FUNCNAME[0]}"

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
        local env found=false paths=() path file=""

        env="$(usageArgumentEnvironmentVariable "$usage" "environmentVariable" "$1")"
        IFS=$'\n' read -d '' -r -a paths < <(_buildEnvironmentPath) || :
        for path in "${paths[@]}"; do
          [ -d "$path" ] || continue
          file="$path/$env.sh"
          if [ -x "$file" ]; then
            export "${env?}" || __throwEnvironment "$usage" "export $env failed" || return $?
            found=true
            set -a || :
            # shellcheck source=/dev/null
            source "$file" || __throwEnvironment "$usage" source "$file" || return $?
            set +a || :
          fi
        done
        $found || __throwEnvironment "$usage" "Missing $env" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_buildEnvironmentLoad() {
  local exitCode
  exitCode="${1-}"
  shift || :
  printf "bin/build/env ERROR: %s\n" "$@" 1>&2
  # debuggingStack
  return "$exitCode"
}

# Run zesk/build command or load it
#
# Example:     Build buildEnvironmentGet APPLICATION_NAME
# Example:
# Example:
# Example:
Build() {
  local usage="_${FUNCNAME[0]}"

  local run="bin/build/tools.sh" vv=() verboseFlag=false startDirectory=""

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
      --start)
        shift
        startDirectory=$(usageArgumentDirectory "$usage" "$argument" "${1-}") || return $?
        ;;
      --verbose)
        vv+=("$argument")
        verboseFlag=true
        ;;
      *)
        break
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$startDirectory" ] || startDirectory=$(__catchEnvironment "$usage" pwd) || return $?

  local home code=0
  if home=$(bashLibraryHome "$run" "$startDirectory" 2>/dev/null); then
    home=$(__catchEnvironment "$usage" buildHome) || return $?
    ! $verboseFlag || statusMessage decorate info "Running $(decorate file "$home/$run")" "$(decorate each code "$@")"
    "$home/$run" "$@" || code=$?
  else
    bashLibrary "${vv[@]+"${vv[@]}"}" "$run" "$@" || code=$?
  fi
  ! $verboseFlag || statusMessage --last printf -- "%s %s" "$(decorate each code "$home/$run" "$@")" "$(decorate notice "Exit code: $code")"
  return $code
}
_Build() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Load and print one or more environment settings
#
# Usage: {fn} [ envName ... ]
# Argument: envName - Optional. String. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.
#
# If BOTH files exist, both are sourced, so application environments should anticipate values
# created by build's default.
#
# Modifies local environment. Not usually run within a subshell.
#
# Environment: $envName
# Environment: BUILD_ENVIRONMENT_DIRS - `:` separated list of paths to load env files
#
buildEnvironmentGet() {
  local usage="_${FUNCNAME[0]}"

  [ $# -gt 0 ] || __throwArgument "$usage" "Requires at least one environment variable" || return $?
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
        __catchEnvironment "$usage" buildEnvironmentLoad "$argument" || return $?
        printf "%s\n" "${!argument-}"
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_buildEnvironmentGet() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Load and print one or more environment settings which represents a directory which should be created.
#
# Usage: {fn} [ envName ... ]
# Argument: envName - Optional. String. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.
# Argument: --subdirectory subdirectory - Optional. String. Name of a subdirectory to return "beneath" the value of environment variable. Created if the flag is set.
#
# If BOTH files exist, both are sourced, so application environments should anticipate values
# created by build's default.
#
# Modifies local environment. Not usually run within a subshell.
#
# Environment: $envName
# Environment: BUILD_ENVIRONMENT_DIRS - `:` separated list of paths to load env files
#
buildEnvironmentGetDirectory() {
  local usage="_${FUNCNAME[0]}"

  local createFlag=true existsFlag=false subdirectory=""

  [ $# -gt 0 ] || __throwArgument "$usage" "Requires at least one environment variable" || return $?
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
      --exists)
        existsFlag=true
        ;;
      --subdirectory)
        shift
        subdirectory=$(usageArgumentString "$usage" "$argument" "${1-}")
        ;;
      --no-create)
        createFlag=false
        ;;
      *)
        local path
        path=$(__catchEnvironment "$usage" buildEnvironmentGet "$argument" 2>/dev/null) || return $?
        [ -z "$subdirectory" ] || subdirectory="${subdirectory#/}"
        subdirectory="${path%/}/$subdirectory"
        ! $createFlag || path=$(__catchEnvironment "$usage" requireDirectory "$subdirectory") || return $?
        ! $existsFlag || [ -d "$subdirectory" ] || __throwEnvironment "$usage" "$argument -> $subdirectory does not exist" || return $?
        printf "%s\n" "${subdirectory%/}"
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_buildEnvironmentGetDirectory() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Generate the path for a quiet log in the build cache directory, creating it if necessary.
# Usage: {fn} name
# Argument: name - String. Required. The log file name to create. Trims leading `_` if present.
# Argument: --no-create - Flag. Optional. Do not require creation of the directory where the log file will appear.
#
buildQuietLog() {
  local usage="_${FUNCNAME[0]}"

  local logFile flagMake=true

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
      --no-create)
        flagMake=false
        ;;
      *)
        logFile="$(__catchEnvironment "$usage" buildCacheDirectory "${1#_}.log")" || return $?
        ! "$flagMake" || __catchEnvironment "$usage" requireFileDirectory "$logFile" || return $?
        __catchEnvironment "$usage" printf -- "%s\n" "$logFile" || return $?
        return 0
        ;;
    esac
    shift || :
  done
  __throwArgument "$usage" "No arguments" || return $?
}
_buildQuietLog() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run a command and ensure the build tools context matches the current project
# Usage: {fn} arguments ...
# Argument: arguments ... - Required. Command to run in new context.
# Avoid infinite loops here, call down.
buildEnvironmentContext() {
  local usage="_${FUNCNAME[0]}"

  [ $# -eq 0 ] || __help "$usage" "$@" || return 0

  local start codeHome home
  start="$(pwd -P 2>/dev/null)" || __throwEnvironment "$usage" "Failed to get pwd" || return $?
  codeHome=$(__catchEnvironment "$usage" buildHome) || return $?
  home=$(__catchEnvironment "$usage" gitFindHome "$start") || return $?
  if [ "$codeHome" != "$home" ]; then
    decorate warning "Build home is $(decorate code "$codeHome") - running locally at $(decorate code "$home")"
    [ -x "$home/bin/build/tools.sh" ] || __throwEnvironment "Not executable $home/bin/build/tools.sh" || return $?
    __catchEnvironment "$usage" "$home/bin/build/tools.sh" "$@" || return $?
    return $?
  fi
  __environment "$@" || return $?
}
_buildEnvironmentContext() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
