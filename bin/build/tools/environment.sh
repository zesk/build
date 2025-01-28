#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
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
  [ $# -ge 1 ] || __throwArgument "$usage" "value required" || return $?
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
  if [ $# -eq 0 ]; then
    printf "%s=%s\n" "$name" "''"
  else
    value=("$@")
    result="$(__environmentValueClean "$(declare -pa value)")" || return $?
    if [ "${result:0:1}" = "'" ]; then
      result="$(unquote \' "$result")"
      printf "%s=%s\n" "$name" "${result//"$replace"/$search}"
    else
      printf "%s=%s\n" "$name" "$result"
    fi
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

# Argument: stateFile - EnvironmentFile. Required. File to read a value from.
# Argument: name - EnvironmentVariable. Required. Variable to read.
# Argument: default - EmptyString. Optional. Default value of the environment variable if it does not exist.
# Exit Code: 1 - If value is not found and no default argument is supplied (2 arguments)
# Exit Code: 0 - If value
environmentValueRead() {
  local usage="_${FUNCNAME[0]}"
  local stateFile name default="${3---}" value
  stateFile=$(usageArgumentFile "$usage" "stateFile" "${1-}") || return $?
  name=$(usageArgumentEnvironmentVariable "$usage" "name" "${2-}") || return $?
  [ $# -le 3 ] || __throwArgument "$usage" "Extra arguments: $#" || return $?
  if ! value="$(grep -e "^$(quoteGrepPattern "$name")=" "$stateFile" | tail -n 1 | cut -c $((${#name} + 2))-)" || [ -z "$value" ]; then
    if [ $# -le 2 ]; then
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
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Convert an array value which was loaded already
# Usage: {fn} encodedValue
environmentValueConvertArray() {
  local usage="_${FUNCNAME[0]}"
  local value prefix='([0]="' suffix='")'

  value=$(__unquote "${1-}")
  [ "$value" != "()" ] || return 0 # Empty array
  if [ "${value#*=}" != "$value" ]; then
    [ "${value#"$prefix"}" != "$value" ] || __throwArgument "$usage" "Not an array value (prefix: \"${value:0:4}\")" || return $?
    [ "${value%"$suffix"}" != "$value" ] || __throwArgument "$usage" "Not an array value (suffix)" || return $?
    declare -a "value=$value"
  else
    local n=$((${#value} - 1))
    if [ "${value:0:1}${value:0:1}${value:$n:1}" = "()" ]; then
      IFS=" " read -r -d'' -a value <<<"${value:1:$((n - 1))}"
    fi
  fi
  printf -- "%s\n" "${value[@]+"${value[@]}"}"
}
_environmentValueConvertArray() {
  # _IDENTICAL_ usageDocument 1
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
  value=$(__catchEnvironment "$usage" environmentValueRead "$stateFile" "$name" "") || return $?
  environmentValueConvertArray "$value" || return $?
}
_environmentValueReadArray() {
  # _IDENTICAL_ usageDocument 1
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
# Usage: environmentFileLoad .env --optional .env.local where
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

  local aa=() where=""

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
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
    # _IDENTICAL_ argument-esac-shift 1
    shift || __throwArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
  done

  if [ -z "$where" ]; then
    where=$(__catchEnvironment "$usage" pwd) || return $?
  fi
  aa+=(--require "$where/.env" --optional "$where/.env.local" --require)
  __catchEnvironment "$usage" environmentFileLoad "${aa[@]}" "$@" || return $?
}
_dotEnvConfigure() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Safely load an environment file (no code execution)
# Usage: {fn} [ --required | --optional ] [ --ignore name ] environmentFile ...
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

  local ff=() environmentFile environmentLine name value required=true ignoreList=() secureList=() toExport=() line=1
  local verboseMode=false debugMode=false hasOne=false

  set -eou pipefail

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --verbose)
        verboseMode=true
        ! $debugMode || printf -- "VERBOSE MODE on (Call: %s)\n" "$(decorate each code "${usage#_}" "${__saved[@]}")"
        ;;
      --debug)
        debugMode=true
        verboseMode=true
        statusMessage decorate info "Debug mode enabled"
        ;;
      --secure)
        shift
        secureList+=("$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        ;;
      --secure-defaults)
        read -d "" -r -a secureList < <(environmentSecureVariables) || :
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
        hasOne=true
        if $required; then
          ! $debugMode || printf -- "Loading required file: %s\n" "$argument"
          ff+=("$(usageArgumentFile "$usage" "environmentFile" "$argument")") || return $?
        else
          ! $verboseMode || statusMessage decorate info "Loading optional file: $(decorate file "$argument")"
          environmentFile=$(usageArgumentFileDirectory "$usage" "environmentFile" "$argument") || return $?
          if [ -f "$environmentFile" ]; then
            ff+=("$environmentFile")
          fi
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift || __throwArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
  done
  $hasOne || __throwArgument "$usage" "Requires at least one environmentFile" || return $?
  ! $debugMode || printf "Files to actually load: %d %s\n" "${#ff[@]}" "${ff[@]}"
  for environmentFile in "${ff[@]}"; do
    ! $debugMode || printf "%s lines:\n%s\n" "$(decorate code "$environmentFile")" "$(environmentLines <"$environmentFile")"
    line=1
    while read -r environmentLine; do
      ! $debugMode || printf "%s:%d: %s " "$environmentFile" "$line" "$(decorate code "$environmentLine")"
      name="${environmentLine%%=*}"
      # Skip comments
      if [ -z "$name" ] || [ "$name" != "${name###}" ]; then
        continue
      fi
      # Skip "bad" variables
      if ! environmentVariableNameValid "$name"; then
        ! $verboseMode || decorate warning "$(decorate code "$name") invalid name ($environmentFile:$line)"
        continue
      fi
      # Skip insecure variables
      [ "${#secureList[@]}" -eq 0 ] || ! inArray "$name" "${secureList[@]}" || __throwEnvironment "$usage" "${environmentFile} contains secure value $(decorate bold-red "$name")" || return $?
      # Ignore stuff as a feature
      if [ "${#ignoreList[@]}" -gt 0 ] && inArray "$name" "${ignoreList[@]}"; then
        ! $debugMode || decorate warning "$(decorate code "$name") is ignored ($environmentFile:$line)"
        continue
      fi
      # Load and unquote value
      value="$(__unquote "${environmentLine#*=}")"
      # SECURITY CHECK
      toExport+=("$name=$value")
      ! $debugMode || printf "toExport: %s=%s\n" "$name" "$value"
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
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List environment variables related to security
environmentSecureVariables() {
  printf -- "%s\n" PATH LD_LIBRARY USER HOME HOSTNAME LANG PS1 PS2 CWD PWD SHELL SHLVL TERM TMPDIR VISUAL EDITOR
}

# List environment variables related to application deployments
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
    APPLICATION_VERSION="$(__environment hookRun "$hook")" || return $?
  fi
  if [ -z "${APPLICATION_ID-}" ]; then
    hook=application-id
    APPLICATION_ID="$(__environment hookRun "$hook")" || return $?
  fi
  if [ -z "${APPLICATION_TAG-}" ]; then
    hook=application-tag
    APPLICATION_TAG="$(__environment hookRun "$hook")" || return $?
    if [ -z "${APPLICATION_TAG-}" ]; then
      APPLICATION_TAG=$APPLICATION_ID
    fi
  fi
  printf -- "%s\n" "${variables[@]}"
}

# Display and validate application variables.
# Exit Code: 1 - If any required application variables are blank, the function fails with an environment error
# Exit Code: 0 - All required application variables are non-blank
# Argument: environmentName - EnvironmentVariable. Optional. A required environment variable name
# Argument: -- - Separator. Optional. Separates requires from optional environment variables
# Argument: optionalEnvironmentName - EnvironmentVariable. Optional. An optional environment variable name.
environmentFileShow() {
  local usage="_${FUNCNAME[0]}"
  local missing name buildEnvironment
  local width=40
  local variables=()

  IFS=$'\n' read -d '' -r -a variables < <(environmentApplicationLoad) || :
  for name in "${variables[@]+"${variables[@]}"}"; do
    environmentVariableNameValid "$name" || __catchArgument "$usage" "Invalid environment name $(decorate code "$name")" 1>&2
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
  environmentVariableNameValid "$@" || __catchArgument "$usage" "Invalid variable name" || return $?

  printf -- "%s %s %s %s%s\n" "$(decorate info "Application")" "$(decorate magenta "$APPLICATION_VERSION")" "$(decorate info "on")" "$(decorate bold-red "$APPLICATION_BUILD_DATE")" "$(decorate info "...")"
  if buildDebugEnabled; then
    decorate pair "$width" Checksum "$APPLICATION_ID"
    decorate pair "$width" Tag "$APPLICATION_TAG"
    decorate pair "$width" Timestamp "$BUILD_TIMESTAMP"
  fi
  missing=()
  for name in "${variables[@]}"; do
    if [ -z "${!name:-}" ]; then
      decorate pair "$width" "$name" "** No value **" 1>&2
      missing+=("$name")
    else
      decorate pair "$width" "$name" "${!name}"
    fi
  done
  for name in "${buildEnvironment[@]+"${buildEnvironment[@]}"}"; do
    if [ -z "${!name:-}" ]; then
      decorate pair "$width" "$name" "** Blank **"
    else
      decorate pair "$width" "$name" "${!name}"
    fi
  done
  [ ${#missing[@]} -eq 0 ] || __catchEnvironment "$usage" "Missing environment" "${missing[@]}" || return $?
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
# Environment: APPLICATION_VERSION - reserved and set to `hookRun version-current` if not set already
# Environment: APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL.
# Environment: APPLICATION_TAG - reserved and set to `hookRun application-id`
# Environment: APPLICATION_ID - reserved and set to `hookRun application-tag`
#
environmentFileApplicationMake() {
  local usage="_${FUNCNAME[0]}"
  local variables=()
  local variableNames name

  variableNames=$(fileTemporaryName "$usage") || return $?
  environmentApplicationLoad >"$variableNames" || __throwEnvironment "$usage" "environmentApplicationLoad" || return $?
  environmentFileApplicationVerify "$@" || __throwArgument "$usage" "Verify failed" || return $?
  IFS=$'\n' read -d '' -r -a variables <"$variableNames" || :
  __catchEnvironment "$usage" rm -rf "$variableNames" || return $?
  for name in "${variables[@]+"${variables[@]}"}" "$@"; do
    [ "$name" != "--" ] || continue
    __catchEnvironment "$usage" environmentValueWrite "$name" "${!name-}" || return $?
  done
}
_environmentFileApplicationMake() {
  # _IDENTICAL_ usageDocument 1
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
    environmentVariableNameValid "$name" || __throwEnvironment "$usage" "Invalid environment name found: $(decorate code "$name")" || return $?
    if [ -z "${!name:-}" ]; then
      missing+=("$name")
    fi
  done
  [ ${#missing[@]} -eq 0 ] || __throwEnvironment "$usage" "Missing environment values:" "${missing[@]}" || return $?
}
_environmentFileApplicationVerify() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL environmentVariables 10

# Output a list of environment variables and ignore function definitions
#
# both `set` and `env` output functions and this is an easy way to just output
# exported variables
#
# Requires: declare grep cut
environmentVariables() {
  declare -px | grep 'declare -x ' | cut -f 1 -d= | cut -f 3 -d' '
}
