#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/environment.md
# Test: o ./test/tools/environment-tests.sh
#

#
# Write a value to a state file as NAME="value"
# Usage: name - Required. String. Name to write.
# Usage: value - Optional. EmptyString. Value to write.
# Usage: ... - Optional. EmptyString. Additional values, when supplied, write this value as an array.
environmentValueWrite() {
  local usage="_${FUNCNAME[0]}" name
  local value

  name=$(usageArgumentEnvironmentVariable "$usage" "name" "${1-}") || return $?
  shift
  [ $# -ge 1 ] || __failArgument "$usage" "value required" || return $?
  if [ $# -eq 1 ]; then
    value="${1-}"
    __environmentValueWrite "$name" "$(declare -p value)" || return $?
  else
    environmentValueWriteArray "$name" "$@"
  fi
}
_environmentValueWrite() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Write an array value as NAME=([0]="a" [1]="b" [2]="c")
# Supports empty arrays
# Bash outputs on different versions:
#
#     declare -a foo='([0]="a'\''s" [1]="b" [2]="c")'
#     declare -a foo=([0]="a's" [1]="b" [2]="c")
#
environmentValueWriteArray() {
  local usage="_${FUNCNAME[0]}"
  local name value result search="'" replace="'\''"

  name=$(usageArgumentEnvironmentVariable "$usage" "name" "${1-}") || return $?
  shift
  value=("$@")
  result="$(__environmentValueClean "$(declare -pa value)")" || return $?
  if [ "${result:0:1}" = "'" ]; then
    result="$(unquote \' "$result")"
    printf "%s=%s\n" "$name" "${result//"$replace"/$search}"
  else
    printf "%s=%s\n" "$name" "$result"
  fi
}
_environmentValueWriteArray() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Utility function to strip "declare value=" from a string
__environmentValueClean() {
  printf -- "%s\n" "${1#declare*value=}"
}

# Utility function to write a value
__environmentValueWrite() {
  printf "%s=%s\n" "$1" "$(__environmentValueClean "$2")" || return $?
}

#
# Read one or more values values safely from a environment file
# Usage: {fn} stateFile
# Argument: stateFile - Required. File. File to access, must exist.
# Argument: name - Required. String. Name to read.
# Argument: default - Optional. String. Value to return if value not found.
environmentValueRead() {
  local usage="_${FUNCNAME[0]}"
  local stateFile name default="${3-}" value
  stateFile=$(usageArgumentFile "$usage" "stateFile" "${1-}") || return $?
  name=$(usageArgumentEnvironmentVariable "$usage" "name" "${2-}") || return $?
  [ $# -le 3 ] || __failArgument "$usage" "Extra arguments: $#" || return $?
  value="$(grep -e "^$(quoteGrepPattern "$name")=" "$stateFile" | tail -n 1 | cut -c $((${#name} + 2))-)"
  if [ -z "$value" ]; then
    if [ -z "$default" ]; then
      return 1
    fi
    printf -- "%s\n" "$default"
  else
    declare "$name=$default"
    declare "$name=$(__unquote "$value")"
    printf -- "%s\n" "${!name-}"
  fi
}
_environmentValueRead() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Convert an array value which was loaded already
# Usage: {fn} encodedValue
environmentValueConvertArray() {
  local usage="_${FUNCNAME[0]}"
  local value prefix='([0]="' suffix='")'

  value=$(__unquote "${1-}")
  [ "${value#"$prefix"}" != "$value" ] || __failArgument "$usage" "Not an array value (prefix: \"${value:0:4}\")" || return $?
  [ "${value%"$suffix"}" != "$value" ] || __failArgument "$usage" "Not an array value (suffix)" || return $?
  declare -a "value=$value"
  printf -- "%s\n" "${value[@]+"${value[@]}"}"
}
_environmentValueConvertArray() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
#
# Usage: {fn} variableName ...
# variableName - String. Required. Exit status 0 if all variables names are valid ones.
# Validates an environment variable name
#
# - alpha
# - digit
# - underscore
#
# First letter MUST NOT be a digit
#
environmentVariableNameValid() {
  local name
  while [ $# -gt 0 ]; do
    [ -n "$1" ] || return 1
    case "$1" in
      *[!A-Za-z0-9_]*)
        return 1
        ;;
      *)
        case "${1:0:1}" in
          [A-Za-z_]) ;;
          *) return 1 ;;
        esac
        ;;
    esac
    shift
  done
}

#
# Read an array value from a state file
# Usage: {fn} stateFile
# Argument: stateFile - Required. File. File to access, must exist.
# Argument: name - Required. EnvironmentVariable. Name to read.
# Outputs array elements, one per line.
environmentValueReadArray() {
  local usage="_${FUNCNAME[0]}"
  local stateFile="${1-}" name value

  name=$(usageArgumentEnvironmentVariable "$usage" "name" "${2-}") || return $?
  value=$(__usageEnvironment "$usage" environmentValueRead "$stateFile" "$name" "") || return $?
  environmentValueConvertArray "$value" || return $?
}
_environmentValueReadArray() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} < "$stateFile"
# List names of environment values set in a bash state file
environmentNames() {
  environmentLines | cut -f 1 -d =
}

# Usage: {fn} < "$stateFile"
# List lines of environment values set in a bash state file
environmentLines() {
  grep -e "^[A-Za-z][A-Z0-9_a-z]*="
}

#
# Usage: dotEnvConfigure where
# Argument: where - Optional. Directory. Where to load the `.env` files.
#
# Loads `.env` which is the current project configuration file
# Also loads `.env.local` if it exists
# Generally speaking - these are NAME=value files and should be parsable by
# bash and other languages.
# See: toDockerEnv
# Summary: Load `.env` and optional `.env.local` into bash context
#
# Requires the file `.env` to exist and is loaded via bash `source` and all variables are `export`ed in the current shell context.
#
# If `.env.local` exists, it is also loaded in a similar manner.
#
# Environment: Loads `.env` and `.env.local`, use with caution on trusted content only
# Exit code: 1 - if `.env` does not exist; outputs an error
# Exit code: 0 - if files are loaded successfully
# DEPRECATED: 2024-07-20
# See: environmentFileLoad
dotEnvConfigure() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local aa=() where=""

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
      --verbose | --debug)
        aa+=("$argument")
        ;;
      *)
        where=$(usageArgumentDirectory "$usage" "where" "$1") || return $?
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  if [ -z "$where" ]; then
    where=$(__usageEnvironment "$usage" pwd) || return $?
  fi
  aa+=(--require "$where/.env" --optional "$where/.env.local" --require)
  __usageEnvironment "$usage" environmentFileLoad "${aa[@]}" "$@" || return $?
}
_dotEnvConfigure() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Safely load an environment file (no code execution)
# Usage: {fn} [ --required | --optional ] [ --ignore name ] environmentFile ...
# Argument: environmentFile - Required. Environment file to load.
# Argument: environmentFile - Required. Environment file to load.
# Argument: --require - Flag. Optional. All subsequent environment files on the command line will be required.
# Argument: --optional - Flag. Optional. All subsequent environment files on the command line will be optional. (If they do not exist, no errors.)
# Argument: --verbose - Flag. Optional. Output errors with variables in files.
# Argument: environmentFile - Required. Environment file to load. For `--optional` files the directory must exist.
# Argument: --ignore environmentName - Optional. String. Environment value to ignore on load.
# Argument: --secure environmentName - Optional. String. If found in a loaded file, entire file fails.
# Argument: --secure-defaults - Flag. Optional. Add a list of environment variables considered security risks to the `--ignore` list.
# Exit code: 2 - if file does not exist; outputs an error
# Exit code: 0 - if files are loaded successfully
environmentFileLoad() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved

  local ff=() environmentFile environmentLine name value required=true ignoreList=() secureList=() toExport=() line=1
  local verboseMode=false debugMode=false

  set -eou pipefail

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    ! $debugMode || printf -- "%d: %d %s\n" "$argumentIndex" ${#ff[@]} "$(consoleBoldRed "ARGS: $#" "$@")"
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --verbose)
        verboseMode=true
        ! $verboseMode || printf -- "VERBOSE MODE on (Arguments: %s)\n" "$(_command "${usage#_}" "${saved[@]}")"
        ;;
      --debug)
        debugMode=true
        verboseMode=true
        consoleInfo "Debug mode enabled"
        ;;
      --secure)
        shift
        secureList+=("$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        ;;
      --secure-defaults)
        read -d "" -r -a secureList < <(environmentSecureVariables)
        ;;
      --ignore)
        shift
        ignoreList+=("$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        ;;
      --require)
        required=true
        ! $debugMode || printf -- "Current: %s\n" "$argument"
        ;;
      --optional)
        required=false
        ! $debugMode || printf -- "Current: %s\n" "$argument"
        ;;
      *)
        if $required; then
          ! $debugMode || printf -- "Loading required file: %s\n" "$argument"
          ff+=("$(usageArgumentFile "$usage" "environmentFile" "$argument")") || return $?
        else
          ! $debugMode || printf -- "Loading optional file: %s\n" "$argument"
          environmentFile=$(usageArgumentFileDirectory "$usage" "environmentFile" "$argument") || return $?
          if [ -f "$environmentFile" ]; then
            ff+=("$environmentFile")
          fi
        fi
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done
  ! $debugMode || printf "Files to actually load: %d %s\n" "${#ff[@]}" "${ff[@]}"
  for environmentFile in "${ff[@]}"; do
    ! $debugMode || printf "%s lines:\n%s\n" "$(consoleCode "$environmentFile")" "$(environmentLines <"$environmentFile")"
    line=1
    while read -r environmentLine; do
      ! $verboseMode || printf "%s:%d: %s" "$environmentFile" "$line" "$(consoleCode "$environmentLine")"
      name="${environmentLine%%=*}"
      # Skip comments
      if [ -z "$name" ] || [ "$name" != "${name###}" ]; then
        continue
      fi
      # Skip "bad" variables
      if ! environmentVariableNameValid "$name"; then
        ! $verboseMode || consoleWarning "$(consoleCode "$name") invalid name ($environmentFile:$line)"
        continue
      fi
      # Skip insecure variables
      [ "${#secureList[@]}" -eq 0 ] || ! inArray "$name" "${secureList[@]}" || __failEnvironment "$usage" "${environmentFile} contains secure value $(consoleBoldRed "$name")" || return $?
      # Ignore stuff as a feature
      if [ "${#ignoreList[@]}" -gt 0 ] && inArray "$name" "${ignoreList[@]}"; then
        ! $verboseMode || consoleWarning "$(consoleCode "$name") is ignored ($environmentFile:$line)"
        continue
      fi
      # Load and unquote value
      value="$(__unquote "${environmentLine#*=}")"
      # SECURITY CHECK
      toExport+=("$name=$value")
      ! $verboseMode || printf "toExport: %s=%s\n" "$name" "$value"
      line=$((line + 1))
    done < <(environmentLines <"$environmentFile") || :
  done
  if [ "${#toExport[@]}" -gt 0 ]; then
    for value in "${toExport[@]}"; do
      name=${value%%=*}
      value=${value#*=}
      # NAME must pass validation above
      ! $debugMode || printf "EXPORTING: %s=%s\n" "$name" "$value"
      export "${name?}"="$value"
    done
  fi
}
_environmentFileLoad() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

environmentSecureVariables() {
  printf -- "%s\n" PATH LD_LIBRARY USER HOME HOSTNAME LANG PS1 PS2 CWD PWD SHELL SHLVL TERM TMPDIR VISUAL EDITOR
}
environmentApplicationVariables() {
  printf -- "%s\n" BUILD_TIMESTAMP APPLICATION_BUILD_DATE APPLICATION_VERSION APPLICATION_ID APPLICATION_TAG
}

#
# Loads application environment variables, set them to their default values if needed, and outputs the list of variables set.
# Environment: BUILD_TIMESTAMP
# Environment: APPLICATION_BUILD_DATE
# Environment: APPLICATION_VERSION
# Environment: APPLICATION_ID
# Environment: APPLICATION_TAG
environmentApplicationLoad() {
  local hook here env
  local variables=()

  IFS=$'\n' read -d '' -r -a variables < <(environmentApplicationVariables) || :
  export "${variables[@]}"

  here=$(dirname "${BASH_SOURCE[0]}") || _environment "dirname ${BASH_SOURCE[0]}" || return $?

  for env in "${variables[@]}"; do
    # shellcheck source=/dev/null
    source "$here/../env/$env.sh" || _environment "source $env.sh" || return $?
  done
  if [ -z "${APPLICATION_VERSION-}" ]; then
    hook=version-current
    APPLICATION_VERSION="$(__environment runHook "$hook")" || return $?
  fi
  if [ -z "${APPLICATION_ID-}" ]; then
    hook=application-id
    APPLICATION_ID="$(__environment runHook "$hook")" || return $?
  fi
  if [ -z "${APPLICATION_TAG-}" ]; then
    hook=application-tag
    APPLICATION_TAG="$(__environment runHook "$hook")" || return $?
    if [ -z "${APPLICATION_TAG-}" ]; then
      APPLICATION_TAG=$APPLICATION_ID
    fi
  fi
  printf -- "%s\n" "${variables[@]}"
}

environmentFileShow() {
  local usage="_${FUNCNAME[0]}"
  local missing name buildEnvironment
  local width=40
  local variables=() checked=()

  IFS=$'\n' read -d '' -r -a variables < <(environmentApplicationLoad) || :
  for name in "${variables[@]+"${variables[@]}"}"; do
    if environmentVariableNameValid "$name"; then
      checked+=("$name")
    else
      consoleWarning "Invalid environment value $(consoleCode "$name")" 1>&2
    fi
  done
  export "${variables[@]}"

  # Will be exported to the environment file, only if defined
  while [ $# -gt 0 ]; do
    case $1 in
      --)
        shift
        break
        ;;
      *)
        variables+=("$(usageArgumentEnvironmentVariable "$usage" "variableName" "$1")") || return $?
        ;;
    esac
    shift
  done
  buildEnvironment=("$@")

  printf -- "%s %s %s %s%s\n" "$(consoleInfo "Application")" "$(consoleMagenta "$APPLICATION_VERSION")" "$(consoleInfo "on")" "$(consoleBoldRed "$APPLICATION_BUILD_DATE")" "$(consoleInfo "...")"
  if buildDebugEnabled; then
    consoleNameValue "$width" Checksum "$APPLICATION_ID"
    consoleNameValue "$width" Tag "$APPLICATION_TAG"
    consoleNameValue "$width" Timestamp "$BUILD_TIMESTAMP"
  fi
  missing=()
  for name in "${variables[@]}"; do
    if [ -z "${!name:-}" ]; then
      consoleNameValue "$width" "$name" "** No value **" 1>&2
      missing+=("$name")
    else
      consoleNameValue "$width" "$name" "${!name}"
    fi
  done
  for name in "${buildEnvironment[@]+"${buildEnvironment[@]}"}"; do
    if environmentVariableNameValid "$name"; then
      if [ -z "${!name:-}" ]; then
        consoleNameValue "$width" "$name" "** Blank **"
      else
        consoleNameValue "$width" "$name" "${!name}"
      fi
    else
      consoleWarning "Invalid build environment value $(consoleCode "$name")" 1>&2
    fi
  done
  [ ${#missing[@]} -eq 0 ] || __usageEnvironment "$usage" "Missing environment" "${missing[@]}" || return $?
}
_environmentFileShow() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} [ requiredEnvironment ... ] [ -- optionalEnvironment ...] "
# Argument: requiredEnvironment ... - Optional. One or more environment variables which should be non-blank and included in the `.env` file.
# Argument: -- - Optional. Divider. Divides the requiredEnvironment values from the optionalEnvironment
# Argument: optionalEnvironment ... - Optional. One or more environment variables which are included if blank or not
#
# Create environment file `.env` for build.
#
# Environment: APPLICATION_VERSION - reserved and set to `runHook version-current` if not set already
# Environment: APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL.
# Environment: APPLICATION_TAG - reserved and set to `runHook application-id`
# Environment: APPLICATION_ID - reserved and set to `runHook application-tag`
#
environmentFileApplicationMake() {
  local usage="_${FUNCNAME[0]}"
  local variables=()
  local variableNames name

  variableNames=$(__usageEnvironment "$usage" mktemp) || return $?
  environmentApplicationLoad >"$variableNames" || __failEnvironment "$usage" "environmentApplicationLoad" || return $?
  environmentFileApplicationVerify "$@" || __failArgument "$usage" "Verify failed" || return $?
  IFS=$'\n' read -d '' -r -a variables <"$variableNames" || :
  __usageEnvironment "$usage" rm -rf "$variableNames" || return $?
  for name in "${variables[@]+"${variables[@]}"}" "$@"; do
    [ "$name" != "--" ] || continue
    __usageEnvironment "$usage" environmentValueWrite "$name" "${!name-}" || return $?
  done
}
_environmentFileApplicationMake() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Check application environment is populated correctly.
# Usage: {fn} [ requiredEnvironment ... ] [ -- optionalEnvironment ...] "
# Argument: requiredEnvironment ... - Optional. One or more environment variables which should be non-blank and included in the `.env` file.
# Argument: -- - Optional. Divider. Divides the requiredEnvironment values from the optionalEnvironment
# Argument: optionalEnvironment ... - Optional. One or more environment variables which are included if blank or not
# Also verifies that `environmentApplicationVariables` and `environmentApplicationLoad` are defined.
environmentFileApplicationVerify() {
  local usage="_${FUNCNAME[0]}"
  local missing name requireEnvironment
  local requireEnvironment=()

  IFS=$'\n' read -d '' -r -a requireEnvironment < <(environmentApplicationLoad) || :
  while [ $# -gt 0 ]; do
    case "$1" in --) shift && break ;; *) requireEnvironment+=("$1") ;; esac
    shift
  done
  missing=()
  for name in "${requireEnvironment[@]}"; do
    environmentVariableNameValid "$name" || __failEnvironment "$usage" "Invalid environment name found: $(consoleCode "$name")" || return $?
    if [ -z "${!name:-}" ]; then
      missing+=("$name")
    fi
  done
  [ ${#missing[@]} -eq 0 ] || __failEnvironment "$usage" "Missing environment values:" "${missing[@]}" || return $?
}
_environmentFileApplicationVerify() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL environmentVariables 12

#
# Output a list of environment variables and ignore function definitions
#
# both `set` and `env` output functions and this is an easy way to just output
# exported variables
#
# Usage: {fn}
#
environmentVariables() {
  declare -px | grep 'declare -x ' | cut -f 1 -d= | cut -f 3 -d' '
}
