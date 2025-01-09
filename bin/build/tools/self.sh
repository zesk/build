#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Zesk Build tools
#
# Test: o test/tools/self-tests.sh
# Docs: o docs/_templates/tools/self.md

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
  local argument nArguments argumentIndex saved
  local exitCode=0
  local path="" applicationHome="" temp relTop home
  local installBinName="" source="" target url="" urlFunction="" postFunction="" showDiffFlag=false source verb localFlag=false

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
          # IDENTICAL argumentUnknown 1
          __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        fi
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
  done

  [ -n "$installBinName" ] || __failArgument "$usage" "--bin is required" || return $?
  [ -n "$source" ] || __failArgument "$usage" "--local-path is required" || return $?

  # Validate paths and force realPath
  # default application home is $(pwd)
  [ -n "$applicationHome" ] || applicationHome="$(__usageEnvironment "$usage" pwd)" || return $?
  # default installation path home is $(pwd)/bin
  [ -n "$path" ] || path="$applicationHome/bin"
  path=$(__usageEnvironment "$usage" realPath "$path") || return $?
  applicationHome="$(__usageEnvironment "$usage" realPath "$applicationHome")" || return $?

  # Custom target binary?
  if [ "${path%.sh}" != "$path" ]; then
    target="$path"
    path=$(__usageEnvironment "$usage" dirname "$path") || return $?
  elif [ -d "$path" ]; then
    target="$path/$installBinName"
  else
    __failEnvironment "$usage" "$path is not a directory" || return $?
  fi

  # Compute relTop
  relTop="${path#"$applicationHome"}"
  if [ "$relTop" = "$path" ]; then
    __failArgument "$usage" "Path ($path) ($(realPath "$path")) is not within applicationHome ($applicationHome)" || return $?
  fi
  relTop=$(directoryRelativePath "$relTop")

  # Get installation binary
  temp="$path/.downloaded.$$"
  if $localFlag; then
    home=$(__usageEnvironment "$usage" buildHome) || return $?
    [ -x "$source" ] || __failEnvironment "$usage" "$source is not executable" || return $?
    __usageEnvironment "$usage" cp "$source" "$temp" || return $?
  else
    if [ -z "$url" ]; then
      [ -n "$urlFunction" ] || __usageArgument "$usage" "Need --url or --url-function" || return $?
      url=$("$urlFunction" "$usage") || return $?
      [ -n "$url" ] || __failEnvironment "$urlFunction failed to generate a URL" || return $?
      urlValid "$url" || __failEnvironment "$urlFunction failed to generate a VALID URL: $url" || return $?
    fi
    if ! curl -s -o - "$url" >"$temp"; then
      __failEnvironment "$usage" "Unable to download $(decorate code "$url")" || _clean $? "$temp" || return $?
    fi
  fi
  if _installInstallBinaryCanCustomize "$temp"; then
    __usageEnvironment "$usage" _installInstallBinaryCustomize "$relTop" <"$temp" >"$temp.custom" || _clean $? "$temp" "$temp.custom" || return $?
    __usageEnvironment "$usage" mv -f "$temp.custom" "$temp" || _clean $? "$temp" "$temp.custom" || return $?
  fi
  if [ -n "$postFunction" ]; then
    __usageEnvironment "$usage" "$postFunction" <"$temp" >"$temp.custom" || _clean $? "$temp" "$temp.custom" || return $?
    __usageEnvironment "$usage" mv -f "$temp.custom" "$temp" || _clean $? "$temp" "$temp.custom" || return $?
  fi

  verb=Installed
  [ ! -f "$target" ] || verb=Updated
  # Show diffs
  ! $showDiffFlag || _installInstallBinaryDiffer "$usage" "$temp" "$target" || _clean $? "$temp" || return $?
  # Copy to target
  __usageEnvironment "$usage" cp "$temp" "$target" || _clean $? "$temp" || return $?
  rm -rf "$temp" || :
  # Clean up and make executable
  __usageEnvironment "$usage" chmod +x "$target" || exitCode=$?
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

  home=$(__usageEnvironment "$usage" buildHome) || return $?
  installInstallBinary "$@" --bin "$binName" --source "$home/bin/build/$binName" --url-function __installInstallBuildRemote --post __installInstallBinaryLegacy
}
_installInstallBuild() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Fetch the remote URL to get installer
__installInstallBuildRemote() {
  local usage="$1"
  export BUILD_INSTALL_URL

  __usageEnvironment "$usage" packageWhich curl curl || return $?
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_INSTALL_URL || return $?
  urlParse "${BUILD_INSTALL_URL-}" >/dev/null || __failEnvironment "$usage" "BUILD_INSTALL_URL ($BUILD_INSTALL_URL) is not a valid URL" || return $?

  printf "%s\n" "${BUILD_INSTALL_URL}"
}

# Helper for installInstallBuild
__installInstallBinaryLegacy() {
  local temp

  temp=$(__environment mktemp) || return $?
  cat >"$temp"
  if __installInstallBinaryIsLegacy <"$temp"; then
    __usageEnvironment "$usage" __installInstallBinaryCustomizeLegacy "$relTop" <"$temp" || _clean $? "$temp" || return $?
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
    diffLines="$(__usageEnvironment "$usage" _installInstallBinaryDifferFilter -c "$@")" || return $?
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
  home=$(__usageEnvironment "$usage" buildHome) || return $?
  {
    cat "$home/bin/build/tools/_sugar.sh" "$home/bin/build/tools/sugar.sh" | grep -e '^_.*() {' | cut -d '(' -f 1
    "$home/bin/build/tools.sh" declare -F | cut -d ' ' -f 3 | grep -v -e '^_'
  }
}
_buildFunctions() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Path to cache directory for build system.
#
# Defaults to `$HOME/.build` unless `$HOME` is not a directory.
#
# Appends any passed in arguments as path segments.
#
# Example:     logFile=$({fn} test.log)
# Usage: {fn} [ pathSegment ... ]
# Argument: pathSegment - One or more directory or file path, concatenated as path segments using `/`
#
buildCacheDirectory() {
  local usage="_${FUNCNAME[0]}"
  local cache suffix

  cache=$(__usageEnvironment "$usage" buildEnvironmentGet BUILD_CACHE) || return $?
  suffix="$(printf "%s/" "$@")"
  suffix="${suffix%/}"
  suffix="$(printf "%s/%s" "${cache%/}" "${suffix%/}")"
  printf "%s\n" "${suffix%/}"
}
_buildCacheDirectory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Environment: BUILD_HOME
# Prints the build home directory (usually same as the application root)
# Environment: BUILD_HOME
buildHome() {
  export BUILD_HOME
  if [ -z "${BUILD_HOME-}" ]; then
    # shellcheck source=/dev/null
    source "$(dirname "${BASH_SOURCE[0]}")/../env/BUILD_HOME.sh" || _environment "BUILD_HOME.sh failed" || return $?
    [ -n "${BUILD_HOME-}" ] || _environment "BUILD_HOME STILL blank" || return $?
  fi
  printf "%s\n" "${BUILD_HOME-}"
}

# Parent: buildHome
_buildEnvironmentPath() {
  local paths=() home

  export BUILD_ENVIRONMENT_PATH BUILD_HOME
  if [ -z "$BUILD_HOME" ]; then
    home=$(__environment buildHome) || return $?
  else
    home="$BUILD_HOME"
  fi
  printf "%s\n" "$home/bin/build/env" "$home/bin/env"
  IFS=":" read -r -a paths <<<"${BUILD_ENVIRONMENT_PATH-}" || :
  printf "%s\n" "${paths[@]+"${paths[@]}"}"
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
# Environment: BUILD_ENVIRONMENT_PATH - `:` separated list of paths to load env files
#
buildEnvironmentLoad() {
  local usage="_${FUNCNAME[0]}"
  local env paths=() path file="" found

  while [ $# -gt 0 ]; do
    env="$(usageArgumentEnvironmentVariable "$usage" "environmentVariable" "$1")"
    found=false
    IFS=$'\n' read -d '' -r -a paths < <(_buildEnvironmentPath) || :
    for path in "${paths[@]}"; do
      [ -d "$path" ] || continue
      file="$path/$env.sh"
      if [ -x "$file" ]; then
        export "${env?}" || __failEnvironment "$usage" "export $env failed" || return $?
        found=true
        set -a || :
        # shellcheck source=/dev/null
        source "$file" || __failEnvironment "$usage" source "$file" || return $?
        set +a || :
      fi
    done
    $found || __failEnvironment "$usage" "Missing $env" || return $?
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
  local run="bin/build/tools.sh"

  local saved=("$@") nArguments=$#
  local vv=() verboseFlag=false
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --verbose)
        vv+=("$argument")
        verboseFlag=true
        ;;
      *)
        break
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done
  local home
  if ! home=$(bashLibraryHome "$run" 2>/dev/null); then
    home=$(__usageEnvironment "$usage" buildHome) || return $?
    ! $verboseFlag || decorate info "Running $(decorate file "$home/$run")" "$(decorate each code "$@")"
    __usageEnvironment "$usage" "$home/$run" "$@" || return $?
  else
    __usageEnvironment "$usage" bashLibrary "${vv[@]+"${vv[@]}"}" "$run" "$@"
  fi
  return 0
}

_Build() {
  # IDENTICAL usageDocument 1
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
# Environment: BUILD_ENVIRONMENT_PATH - `:` separated list of paths to load env files
#
buildEnvironmentGet() {
  local usage="_${FUNCNAME[0]}"
  local env

  for env in "$@"; do
    __usageEnvironment "$usage" buildEnvironmentLoad "$env" || return $?
    printf "%s\n" "${!env-}"
  done
}
_buildEnvironmentGet() {
  # IDENTICAL usageDocument 1
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
  local argument nArguments argumentIndex saved
  local logFile flagMake=true

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
      --no-create)
        flagMake=false
        ;;
      *)
        logFile="$(__usageEnvironment "$usage" buildCacheDirectory "${1#_}.log")" || return $?
        ! "$flagMake" || __usageEnvironment "$usage" requireFileDirectory "$logFile" || return $?
        __usageEnvironment "$usage" printf -- "%s\n" "$logFile" || return $?
        return 0
        ;;
    esac
    shift || :
  done
  __failArgument "$usage" "No arguments" || return $?
}
_buildQuietLog() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Run a command and ensure the build tools context matches the current project
# Usage: {fn} arguments ...
# Argument: arguments ... - Required. Command to run in new context.
# Avoid infinite loops here, call down.
buildEnvironmentContext() {
  local usage="_${FUNCNAME[0]}"
  local start codeHome home
  start="$(pwd -P 2>/dev/null)" || __failEnvironment "$usage" "Failed to get pwd" || return $?
  codeHome=$(__usageEnvironment "$usage" buildHome) || return $?
  home=$(__usageEnvironment "$usage" gitFindHome "$start") || return $?
  if [ "$codeHome" != "$home" ]; then
    decorate warning "Build home is $(decorate code "$codeHome") - running locally at $(decorate code "$home")"
    [ -x "$home/bin/build/tools.sh" ] || __failEnvironment "Not executable $home/bin/build/tools.sh" || return $?
    __usageEnvironment "$usage" "$home/bin/build/tools.sh" "$@" || return $?
    return $?
  fi
  __environment "$@" || return $?
}
_buildEnvironmentContext() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
