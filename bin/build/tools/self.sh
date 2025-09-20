#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Zesk Build tools
#
# Test: o test/tools/self-tests.sh
# Docs: o docs/_templates/tools/build.md

__selfLoader() {
  __functionLoader __installInstallBinary self "$@"
}

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
  __selfLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_installInstallBinary() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Installs `install-bin-build.sh` the first time in a new project, and modifies it to work in the application path.
# Argument: --help - Optional. Flag. This help.
# Argument: --diff - Optional. Flag. Show differences between new and old files if changed.
# Argument: --local - Optional. Flag. Use local copy of `install-bin-build.sh` instead of downloaded version.
# Argument: path - Optional. Directory. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.
# Argument: applicationHome - Optional. Directory. Path to the application home directory. Default is current directory.
# Usage: {fn} [ --help ] [ --diff ] [ --local ] [ path [ applicationHome ] ]
installInstallBuild() {
  local handler="_${FUNCNAME[0]}"
  local home
  local binName="install-bin-build.sh"

  home=$(__catch "$handler" buildHome) || return $?
  installInstallBinary --handler "$handler" "$@" --bin "$binName" --source "$home/bin/build/$binName" --url-function __installInstallBuildRemote --post __installInstallBinaryLegacy
}
_installInstallBuild() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Environment: BUILD_HOME
# Prints the list of functions defined in Zesk Build
buildFunctions() {
  local handler="_${FUNCNAME[0]}"
  local home
  home=$(__catch "$handler" buildHome) || return $?
  {
    cat "$home/bin/build/tools/_sugar.sh" "$home/bin/build/tools/sugar.sh" | grep -e '^_.*() {' | cut -d '(' -f 1 | grep -v '^___'
    "$home/bin/build/tools.sh" declare -F | cut -d ' ' -f 3 | grep -v -e '^_'
  }
}
_buildFunctions() {
  # __IDENTICAL__ usageDocument 1
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
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local suffix
  suffix="$(printf "%s/" ".build" "$@")"
  __catch "$handler" buildEnvironmentGetDirectory --subdirectory "$suffix" XDG_CACHE_HOME || return $?
}
_buildCacheDirectory() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Environment: BUILD_HOME
# Prints the build home directory (usually same as the application root)
# Environment: BUILD_HOME
buildHome() {
  local handler="_${FUNCNAME[0]}"
  export BUILD_HOME
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  if [ -z "${BUILD_HOME-}" ]; then
    local homeEnv="${BASH_SOURCE[0]%/*}/../env/BUILD_HOME.sh"
    if [ -f "$homeEnv" ]; then
      # shellcheck source=/dev/null
      source "${BASH_SOURCE[0]%/*}/../env/BUILD_HOME.sh" || __throwEnvironment "$handler" "BUILD_HOME.sh failed" || return $?
      [ -n "${BUILD_HOME-}" ] || __throwEnvironment "$handler" "BUILD_HOME STILL blank" || return $?
    else
      __throwEnvironment "$handler" "Unable to locate $homeEnv from $(pwd)"$'\n'"$(decorate each code "${BASH_SOURCE[@]}")" || return $?
    fi
  fi
  printf "%s\n" "${BUILD_HOME%/}"
}
_buildHome() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Parent: buildHome
_buildEnvironmentPath() {
  local paths=() home

  export BUILD_ENVIRONMENT_DIRS BUILD_HOME
  home="${BUILD_HOME-}"
  if [ -z "$home" ]; then
    home=$(__environment buildHome) || return $?
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
# Argument: --print - Flag. Print the environment file loaded last.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Environment: $envName
# Environment: BUILD_ENVIRONMENT_DIRS - `:` separated list of paths to load env files
#
buildEnvironmentLoad() {
  local handler="_${FUNCNAME[0]}"

  home=$(__catch "$handler" buildHome) || return $?
  printFlag=false
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --print)
      printFlag=true
      ;;
    *)
      local env found="" paths=() path file=""

      env="$(usageArgumentEnvironmentVariable "$handler" "environmentVariable" "$1")" || return $?
      IFS=$'\n' read -d '' -r -a paths < <(_buildEnvironmentPath) || :
      for path in "${paths[@]}"; do
        if ! isAbsolutePath "$path"; then
          # All relative paths are relative to the application root, so correct
          path="$home/$path"
        fi
        [ -d "$path" ] || continue
        # Maybe warn here or something as if absolute and missing should not be in the list
        file="$path/$env.sh"
        if [ -x "$file" ]; then
          export "${env?}" || __throwEnvironment "$handler" "export $env failed" || return $?
          found="$file"
          set -a || :
          # shellcheck source=/dev/null
          source "$file" || __throwEnvironment "$handler" source "$file" || return $?
          set +a || :
        fi
      done
      [ -n "$found" ] || __throwEnvironment "$handler" "Missing $env in $(decorate each --index --count code "${paths[@]}")" || return $?
      ! $printFlag || printf -- "%s\n" "$found"
      ;;
    esac
    shift
  done
}
_buildEnvironmentLoad() {
  # __IDENTICAL__ usageDocumentSimple 1
  usageDocumentSimple "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run zesk/build command or load it
#
# Argument: --help
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --start startDirectory - Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy.
# Argument: --verbose - Flag. Optional. Be verbose.
# Argument: ... - Executable. Optional. Run this command after loading in the current build context.
Build() {
  local handler="_${FUNCNAME[0]}"

  local run="bin/build/tools.sh" vv=() verboseFlag=false startDirectory=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --start)
      shift
      startDirectory=$(usageArgumentDirectory "$handler" "$argument" "${1-}") || return $?
      ;;
    --verbose)
      vv+=("$argument")
      verboseFlag=true
      ;;
    *)
      break
      ;;
    esac
    shift
  done

  [ -n "$startDirectory" ] || startDirectory=$(__catchEnvironment "$handler" pwd) || return $?

  local home code=0
  if ! home=$(bashLibraryHome "$run" "$startDirectory" 2>/dev/null); then
    home=$(__catch "$handler" buildHome) || return $?
    ! $verboseFlag || statusMessage decorate info "Running $(decorate file "$home/$run")" "$(decorate each code "$@")"
    "$home/$run" "$@" || code=$?
  else
    bashLibrary "${vv[@]+"${vv[@]}"}" "$run" "$@" || code=$?
  fi
  ! $verboseFlag || statusMessage --last printf -- "%s %s" "$(decorate each code "$home/$run" "$@")" "$(decorate notice "Exit code: $code")"
  return $code
}
_Build() {
  # __IDENTICAL__ usageDocument 1
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
  local handler="_${FUNCNAME[0]}"

  [ $# -gt 0 ] || __throwArgument "$handler" "Requires at least one environment variable" || return $?
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    *)
      __catch "$handler" buildEnvironmentLoad "$argument" || return $?
      printf "%s\n" "${!argument-}"
      ;;
    esac
    shift
  done
}
_buildEnvironmentGet() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Load and print one or more environment settings which represents a directory which should be created.
#
# Usage: {fn} [ envName ... ]
# Argument: envName - Optional. String. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.
# Argument: --subdirectory subdirectory - Optional. String. Name of a subdirectory to return "beneath" the value of environment variable. Created if the flag is set.
# Argument: --mode fileMode - String. Optional. Enforce the mode for `mkdir --mode` and `chmod`. Use special mode `-` to mean no mode enforcement.
# Argument: --owner ownerName - String. Optional. Enforce the owner of the directory. Use special ownerName `-` to mean no owner enforcement.
# If BOTH files exist, both are sourced, so application environments should anticipate values
# created by build's default.
#
# Modifies local environment. Not usually run within a subshell.
#
# Environment: $envName
# Environment: BUILD_ENVIRONMENT_DIRS - `:` separated list of paths to load env files
#
buildEnvironmentGetDirectory() {
  local handler="_${FUNCNAME[0]}"

  local createFlag=true existsFlag=false subdirectory="" rr=()

  [ $# -gt 0 ] || __throwArgument "$handler" "Requires at least one environment variable" || return $?
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --exists)
      existsFlag=true
      ;;
    --subdirectory)
      shift
      subdirectory=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --owner | --mode)
      shift
      rr+=("$argument" "$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      createFlag=true
      ;;
    --no-create)
      createFlag=false
      ;;
    *)
      local path
      path=$(__catch "$handler" buildEnvironmentGet "$argument" 2>/dev/null) || return $?
      [ -z "$subdirectory" ] || subdirectory="${subdirectory#/}"
      subdirectory="${path%/}/$subdirectory"
      ! $createFlag || path=$(__catch "$handler" directoryRequire "${rr[@]+"${rr[@]}"}" "$subdirectory") || return $?
      ! $existsFlag || [ -d "$subdirectory" ] || __throwEnvironment "$handler" "$argument -> $subdirectory does not exist" || return $?
      printf "%s\n" "${subdirectory%/}"
      ;;
    esac
    shift
  done
}
_buildEnvironmentGetDirectory() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Generate the path for a quiet log in the build cache directory, creating it if necessary.
# Usage: {fn} name
# Argument: name - String. Required. The log file name to create. Trims leading `_` if present.
# Argument: --no-create - Flag. Optional. Do not require creation of the directory where the log file will appear.
#
buildQuietLog() {
  local handler="_${FUNCNAME[0]}"

  local flagMake=true

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --no-create)
      flagMake=false
      ;;
    *)
      local logFile
      logFile="$(__catch "$handler" buildCacheDirectory)/${1#_}.log" || return $?
      ! "$flagMake" || logFile=$(__catch "$handler" fileDirectoryRequire "$logFile") || return $?
      printf -- "%s\n" "$logFile"
      return 0
      ;;
    esac
    shift || :
  done
  __throwArgument "$handler" "No arguments" || return $?
}
_buildQuietLog() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run a command and ensure the build tools context matches the current project
# Usage: {fn} arguments ...
# Argument: arguments ... - Required. Command to run in new context.
# Avoid infinite loops here, call down.
buildEnvironmentContext() {
  local handler="_${FUNCNAME[0]}"

  [ $# -eq 0 ] || __help "$handler" "$@" || return 0

  local start codeHome home
  start="$(pwd -P 2>/dev/null)" || __throwEnvironment "$handler" "Failed to get pwd" || return $?
  codeHome=$(__catch "$handler" buildHome) || return $?
  home=$(__catchEnvironment "$handler" gitFindHome "$start") || return $?
  if [ "$codeHome" != "$home" ]; then
    decorate warning "Build home is $(decorate code "$codeHome") - running locally at $(decorate code "$home")"
    [ -x "$home/bin/build/tools.sh" ] || __throwEnvironment "Not executable $home/bin/build/tools.sh" || return $?
    __catchEnvironment "$handler" "$home/bin/build/tools.sh" "$@" || return $?
    return $?
  fi
  __environment "$@" || return $?
}
_buildEnvironmentContext() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
