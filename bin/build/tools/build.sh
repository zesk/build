#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Zesk Build tools
#
# Test: o test/tools/self-tests.sh
# Docs: o docs/_templates/tools/build.md

#            _  __
#   ___  ___| |/ _|
#  / __|/ _ \ | |_
#  \__ \  __/ |  _|
#  |___/\___|_|_|
#

__selfLoader() {
  __buildFunctionLoader __installInstallBinary self "$@"
}

# Installs an installer the first time in a new project, and modifies it to work in the application path.
# Argument: --diff - Flag. Optional. Show differences between new and old files if changed.
# Argument: --url - URL. Optional. A remote URL to download the installation script.
# Argument: --url-function - Callable. Optional. Fetch the remote URL where the installation script is found.
# Argument: --source - File. Required. The local copy of the `--bin` file.
# Argument: --local - Flag. Optional. Use local copy `--bin` instead of downloaded version.
# Argument: --bin - String. Required. Name of the installer file.
# Argument: path - Directory. Optional. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.
# Argument: applicationHome - Directory. Optional. Path to the application home directory. Default is current directory.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
installInstallBinary() {
  __selfLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_installInstallBinary() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Installs `install-bin-build.sh` the first time in a new project, and modifies it to work in the application path.
# Argument: --help - Flag. Optional. This help.
# Argument: --diff - Flag. Optional. Show differences between new and old files if changed.
# Argument: --local - Flag. Optional. Use local copy of `install-bin-build.sh` instead of downloaded version.
# Argument: path - Directory. Optional. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.
# Argument: applicationHome - Directory. Optional. Path to the application home directory. Default is current directory.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
installInstallBuild() {
  local handler="_${FUNCNAME[0]}"
  local home
  local binName="install-bin-build.sh"

  home=$(catchReturn "$handler" buildHome) || return $?
  installInstallBinary --handler "$handler" "$@" --bin "$binName" --source "$home/bin/build/$binName" --url-function __installInstallBuildRemote --post __installInstallBinaryLegacy
}
_installInstallBuild() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List all functions which are currently deprecated in Zesk Build
# stdout: String
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
buildDeprecatedFunctions() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help --only "$handler" "$@" || return 0
  local home && home=$(catchReturn "$handler" buildHome) || return $?
  {
    catchReturn "$handler" bashListFunctions "$home/bin/build/tools/deprecated.sh" || return $?
    catchReturn "$handler" bashCommentFilter <"$home/bin/build/deprecated.txt" | catchReturn "$handler" cut -f 1 -d '|' | catchReturn "$handler" grepSafe -e '^[A-Za-z_][A-Za-z0-9_]*$' || return $?
  } | catchReturn "$handler" sort -u || return $?
}
_buildDeprecatedFunctions() {
  true || buildDeprecatedFunctions --help || return $?
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: --deprecated - Flag. Optional. Include all deprecated functions as well.
# Environment: BUILD_HOME
# Prints the list of functions defined in Zesk Build
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# shellcheck disable=SC2120
buildFunctions() {
  local handler="_${FUNCNAME[0]}" hideDeprecated=true
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
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --deprecated) hideDeprecated=false ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local postprocess=(cat)
  if $hideDeprecated; then
    local pattern=() fun && while read -r fun; do pattern+=("$fun"); done < <(buildDeprecatedFunctions)
    local grepPattern && grepPattern="$(catchReturn "$handler" listJoin "|" "${pattern[@]}")" || return $?
    [ "${#pattern[@]}" -eq 0 ] || postprocess=(grep -v -e "^\($(quoteGrepPattern "$grepPattern")\)$")
  fi
  local home && home=$(catchReturn "$handler" buildHome) || return $?
  env -i PATH="$PATH" "$home/bin/build/tools.sh" declare -F | cut -d ' ' -f 3 | grep -v -e '^_' | "${postprocess[@]}"
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
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
buildCacheDirectory() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local suffix
  suffix="$(printf "%s/" ".build" "$@")"
  catchReturn "$handler" buildEnvironmentGetDirectory --subdirectory "$suffix" XDG_CACHE_HOME || return $?
}
_buildCacheDirectory() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Environment: BUILD_HOME
# Prints the build home directory (usually same as the application root)
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# shellcheck disable=SC2120
buildHome() {
  local handler="_${FUNCNAME[0]}"
  export BUILD_HOME
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  if [ -z "${BUILD_HOME-}" ]; then
    local homeEnv="${BASH_SOURCE[0]%/*}/../env/BUILD_HOME.sh"
    if [ -f "$homeEnv" ]; then
      # shellcheck source=/dev/null
      source "${BASH_SOURCE[0]%/*}/../env/BUILD_HOME.sh" || throwEnvironment "$handler" "BUILD_HOME.sh failed" || return $?
      [ -n "${BUILD_HOME-}" ] || throwEnvironment "$handler" "BUILD_HOME STILL blank" || return $?
    else
      throwEnvironment "$handler" "Unable to locate $homeEnv from $(pwd)"$'\n'"$(decorate each code "${BASH_SOURCE[@]}")" || return $?
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
  local handler="$1" && shift
  local paths=() home

  export BUILD_ENVIRONMENT_DIRS BUILD_HOME
  home="${BUILD_HOME-}"
  if [ -z "$home" ]; then
    home=$(catchReturn "$handler" buildHome) || return $?
  fi
  # shellcheck source=/dev/null
  source "$home/bin/build/env/BUILD_ENVIRONMENT_DIRS.sh" || throwEnvironment "$handler" "BUILD_ENVIRONMENT_DIRS.sh fail" || return $?

  IFS=":" read -r -a paths <<<"${BUILD_ENVIRONMENT_DIRS-}" || :
  printf "%s\n" "${paths[@]+"${paths[@]}"}" "$home/bin/build/env"
}

# Output the list of environment variable names which can be loaded via `buildEnvironmentLoad` or `buildEnvironmentGet`
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Requires: convertValue _buildEnvironmentPath find sort read __help catchEnvironment
buildEnvironmentNames() {
  local handler="_${FUNCNAME[0]}"

  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"

  (
    IFS=$'\n' read -d '' -r -a paths < <(_buildEnvironmentPath "$handler") || :
    for path in "${paths[@]}"; do
      find "$path" -type f -name '*.sh' -exec basename {} \; | cut -d . -f 1
    done
  ) | catchEnvironment "$handler" sort -u || return $?
}
_buildEnvironmentNames() {
  true || buildEnvironmentNames --help || return $?
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Determine the environment file names for environment variables
#
# Argument: envName - String. Optional. Name of the environment value to find
# Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# Environment: BUILD_ENVIRONMENT_DIRS
buildEnvironmentFiles() {
  local handler="_${FUNCNAME[0]}" applicationHome="" foundOne=false

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
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --application) shift && applicationHome=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    *)
      local env paths=() path file=""
      [ -n "$applicationHome" ] || applicationHome=$(catchReturn "$handler" buildHome) || return $?
      env="$(validate "$handler" EnvironmentVariable "environmentVariable" "$argument")" || return $?
      IFS=$'\n' read -d '' -r -a paths < <(_buildEnvironmentPath "$handler") || :
      for path in "${paths[@]}"; do
        if ! pathIsAbsolute "$path"; then
          # All relative paths are relative to the application root, so correct
          path="$applicationHome/$path"
        fi
        [ -d "$path" ] || continue
        file="$path/$env.sh"
        if [ -x "$file" ]; then
          printf "%s\n" "$file"
          foundOne=true
        fi
      done
      ;;
    esac
    shift
  done
  $foundOne || return 1
}
_buildEnvironmentFiles() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__buildEnvironmentFileHeader() {
  local handler="$1" && shift

  local year company
  year=$(catchEnvironment "$handler" date +%Y) || return $?
  company=$(catchReturn "$handler" buildEnvironmentGet BUILD_COMPANY) || return $?
  local ll=(
    "#!/usr/bin/env bash"
    "# Copyright &copy; $year $company"
  )
  catchEnvironment "$handler" printf -- "%s\n" "${ll[@]+"${ll[@]}"}" || return $?
}

__buildEnvironmentDefaultFile() {
  local handler="$1" && shift
  local name="$1" && shift

  local app && app=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_CODE) || return $?
  local ll=(
    "# Category: Application"
    "# Application: $app"
    "# Type: String"
    "# A description of \"$name\" and how it is used"
    "export $name"
  )
  catchEnvironment "$handler" printf -- "%s\n" "${ll[@]+"${ll[@]}"}" || return $?
}

# Generate a file from a template or from scratch
__buildEnvironmentMakeFile() {
  local handler="$1" templateHome="$2" name="$3" value="$4"

  [ -n "$value" ] || value="\${$name-}"
  local template && template=$(buildEnvironmentFiles --application "$templateHome" "$name" 2>/dev/null | tail -n 1) || :

  __buildEnvironmentFileHeader "$handler" || return $?
  if [ -n "$template" ]; then
    catchReturn "$handler" grepSafe -v -e "^$name" -e "^#!" -e 'Copyright' "$template" || return $?
  else
    __buildEnvironmentDefaultFile "$handler" "$name" || return $?
  fi
  catchEnvironment "$handler" printf -- "%s\n" "$name=\"$value\"" || return $?
}

# Adds an environment variable file to a project
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: --force - Flag. Optional. Replace the existing file if it exists or create it if it does not.
# Argument: --quiet - Flag. Optional. No status messages.
# Argument: --verbose - Flag. Optional. Display status messages.
# Argument: --value value - String. Optional. Set the value to this fixed string in the file. Only valid when a single `environmentName` is used.
# Argument: environmentName ... - EnvironmentName. Required. One or more environment variable names to add to this project.
buildEnvironmentAdd() {
  local handler="_${FUNCNAME[0]}"
  local value="" environmentNames=() forceFlag=false verboseFlag=true
  local home=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --application) shift && home="$(validate "$handler" Directory "applicationHome" "${1-}")" || return $? ;;
    --force) forceFlag=true ;;
    --quiet) verboseFlag=false ;;
    --verbose) verboseFlag=true ;;
    --value) shift && value="${1-}" ;;
    *) environmentNames+=("$(validate "$handler" EnvironmentVariable "environmentVariable" "$argument")") || return $? ;;
    esac
    shift
  done

  [ ${#environmentNames[@]} -gt 0 ] || throwArgument "$handler" "Need at least one $(decorate code environmentVariable)" || return $?

  local templateHome && templateHome=$(catchReturn "$handler" buildHome) || return $?
  [ -n "$home" ] || home="$templateHome"

  local name && for name in "${environmentNames[@]}"; do
    local path="$home/bin/env/$name.sh"
    if [ -f "$path" ] && ! fileIsEmpty "$path" && ! $forceFlag; then
      if [ ! -x "$path" ]; then
        ! $verboseFlag || statusMessage --last decorate warning "Making existing $(decorate file "$path") executable ..."
        catchEnvironment "$handler" chmod +x "$path" || return $?
      else
        ! $verboseFlag || statusMessage --last decorate info "$(decorate file "$path") already exists, no changes made"
      fi
    else
      local verb="Created"
      [ ! -f "$path" ] || verb="Replaced"
      [ -n "$value" ] || value="\${$name-}"
      __buildEnvironmentMakeFile "$handler" "$templateHome" "$name" "$value" >"$path" || return $?
      catchEnvironment "$handler" chmod +x "$path" || return $?
      ! $verboseFlag || statusMessage --last decorate success "$verb $(decorate file "$path")"
    fi
  done
}
_buildEnvironmentAdd() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Load one or more environment settings from the environment file path.
#
# Argument: envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.
# Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.
# Argument: --all - Flag. Optional. Load all environment variables defined in BUILD_ENVIRONMENT_DIRS.
# Argument: --print - Flag. Print the environment file loaded first.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# If BOTH files exist, both are sourced, so application environments should anticipate values
# created by build's default.
#
# Modifies local environment. Not usually run within a subshell.
# Environment: BUILD_ENVIRONMENT_DIRS - `:` separated list of paths to load env files
#
buildEnvironmentLoad() {
  local handler="_${FUNCNAME[0]}" applicationHome="" printFlag=false tempFiles="" envNames=() allFlag=false

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
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --print) printFlag=true ;;
    --all) allFlag=true ;;
    --application) shift && applicationHome=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    *)
      envNames+=("$(validate "$handler" EnvironmentVariable "environmentVariable" "$1")") || return $?
      ;;
    esac
    shift
  done
  local envName
  if [ ${#envNames[@]} -eq 0 ]; then
    $allFlag || throwEnvironment "$handler" "No environment values specified" || return $?
    while read -r envName < <(buildEnvironmentNames); do envNames+=("$envName"); done
  elif "$allFlag"; then
    throwArgument "$handler" "--all is not compatible with environment values: ${envNames[*]}" || return $?
  fi
  [ -n "$applicationHome" ] || applicationHome=$(catchReturn "$handler" buildHome) || return $?

  [ -f "$tempFiles" ] || tempFiles=$(fileTemporaryName "$handler") || return $?

  for envName in "${envNames[@]}"; do
    if ! buildEnvironmentFiles --application "$applicationHome" "$envName" >"$tempFiles"; then
      throwEnvironment "$handler" "Failed to find any files for $envName" || returnClean $? "$tempFiles" || return $?
    fi
    export "${envName?}" || throwEnvironment "$handler" "export $envName failed" || returnClean $? "$tempFiles" || return $?
    # See testBashSetScopes - must undo this
    set -a # UNDO correct

    local firstFile="" eof=false
    # shellcheck disable=SC2094
    while ! $eof; do
      local f && read -r f || eof=true
      [ -n "$f" ] || continue
      # shellcheck source=/dev/null
      source "$f" || throwEnvironment "$handler" "Failed: source $f" || returnClean $? "$tempFiles" || returnUndo $? set +a || return $?
      [ -n "$firstFile" ] || firstFile="$f"
    done <"$tempFiles"

    set +a
    [ -n "$firstFile" ] || throwEnvironment "$handler" "No files loaded for $argument" || return $?
    ! $printFlag || catchEnvironment "$handler" printf -- "%s\n" "$firstFile" || returnClean $? "$tempFiles" || return $?
  done
  [ -z "$tempFiles" ] || catchEnvironment "$handler" rm -f "$tempFiles" || return $?
}
_buildEnvironmentLoad() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

unalias tools 2>/dev/null || :

# Run a Zesk Build command or load it
#
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: --start startDirectory - Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy.
# Argument: --verbose - Flag. Optional. Be verbose.
# Argument: ... - Callable. Optional. Run this command after loading in the current build context.
tools() {
  local handler="_${FUNCNAME[0]}"

  local toolsBin="bin/build/tools.sh" vv=() verboseFlag=false startDirectory=""

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
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --start)
      shift
      startDirectory=$(validate "$handler" Directory "$argument" "${1-}") || return $?
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

  [ -n "$startDirectory" ] || startDirectory=$(catchEnvironment "$handler" pwd) || return $?

  local home code=0
  if ! home=$(bashLibraryHome "$toolsBin" "$startDirectory" 2>/dev/null); then
    home=$(catchReturn "$handler" buildHome) || return $?
    ! $verboseFlag || statusMessage decorate info "Running $(decorate file "$home/$toolsBin")" "$(decorate each code -- "$@")"
    "$home/$toolsBin" "$@" || code=$?
  else
    bashLibrary "${vv[@]+"${vv[@]}"}" "$toolsBin" "$@" || code=$?
  fi
  ! $verboseFlag || statusMessage --last printf -- "%s %s" "$(decorate each code "$home/$toolsBin" "$@")" "$(decorate notice "Return code: $code")"
  return $code
}
_tools() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Load and print one or more environment settings
#
# Argument: envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.
# Argument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.
# If BOTH files exist, both are sourced, so application environments should anticipate values
# created by build's default.
#
# Modifies local environment. Not usually run within a subshell.
#
# Environment: $envName
# Environment: BUILD_ENVIRONMENT_DIRS - `:` separated list of paths to load env files
#
buildEnvironmentGet() {
  local handler="_${FUNCNAME[0]}" ll=()

  [ $# -gt 0 ] || throwArgument "$handler" "Requires at least one environment variable" || return $?
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
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --application) shift && ll+=("$argument" "${1-}") ;;
    *)
      catchReturn "$handler" buildEnvironmentLoad "${ll[@]+"${ll[@]}"}" "$argument" || return $?
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
# Argument: envName - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.
# Argument: --subdirectory subdirectory - String. Optional. Name of a subdirectory to return "beneath" the value of environment variable. Created if the flag is set.
# Argument: --mode fileMode - String. Optional. Enforce the mode for `mkdir --mode` and `chmod`. Use special mode `-` to mean no mode enforcement.
# Argument: --owner ownerName - String. Optional. Enforce the owner of the directory. Use special ownerName `-` to mean no owner enforcement.
# Argument: --no-create - Flag. Optional. Do not create the subdirectory if it does not exist.
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

  [ $# -gt 0 ] || throwArgument "$handler" "Requires at least one environment variable" || return $?
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
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --exists)
      existsFlag=true
      ;;
    --subdirectory)
      shift
      subdirectory=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --owner | --mode)
      shift
      rr+=("$argument" "$(validate "$handler" String "$argument" "${1-}")") || return $?
      createFlag=true
      ;;
    --no-create)
      createFlag=false
      ;;
    *)
      local path
      path=$(catchReturn "$handler" buildEnvironmentGet "$argument" 2>/dev/null) || return $?
      [ -z "$subdirectory" ] || subdirectory="${subdirectory#/}"
      subdirectory="${path%/}/$subdirectory"
      ! $createFlag || path=$(catchReturn "$handler" directoryRequire "${rr[@]+"${rr[@]}"}" "$subdirectory") || return $?
      ! $existsFlag || [ -d "$subdirectory" ] || throwEnvironment "$handler" "$argument -> $subdirectory does not exist" || return $?
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
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --no-create)
      flagMake=false
      ;;
    *)
      local logFile
      logFile="$(catchReturn "$handler" buildCacheDirectory)/${1#_}.log" || return $?
      ! "$flagMake" || logFile=$(catchReturn "$handler" fileDirectoryRequire "$logFile") || return $?
      printf -- "%s\n" "$logFile"
      return 0
      ;;
    esac
    shift || :
  done
  throwArgument "$handler" "No arguments" || return $?
}
_buildQuietLog() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run a command and ensure the build tools context matches the current project
# Argument: contextStart - Directory. Required. Context in which the command should run.
# Argument: command ... - Required. Command to run in new context.
# Avoid infinite loops here, call down.
buildEnvironmentContext() {
  local handler="_${FUNCNAME[0]}"

  [ $# -eq 0 ] || __help "$handler" "$@" || return 0

  local start
  start="$(validate "$handler" Directory "contextStart" "${1-}")" && shift || return $?

  local codeHome home binTools="bin/build/tools.sh"
  codeHome=$(catchReturn "$handler" buildHome) || return $?
  home=$(catchEnvironment "$handler" bashLibraryHome "$binTools" "$start") || return $?

  if [ "$codeHome" != "$home" ]; then
    decorate warning "Build home is $(decorate code "$codeHome") - running locally at $(decorate code "$home")"
    [ -x "$home/$binTools" ] || throwEnvironment "Not executable $home/$binTools" || return $?
    catchEnvironment "$handler" "$home/$binTools" "$@" || return $?
    return 0
  fi
  catchEnvironment "$handler" "$@" || return $?
}
_buildEnvironmentContext() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
