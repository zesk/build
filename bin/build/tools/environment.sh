#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/environment.md
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
    printf "%s=%s\n" "$name" "()"
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
  grepSafe -e "^[A-Za-z][A-Z0-9_a-z]*="
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
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
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
    shift
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

# Safely load an environment from stdin (no code execution)
# Argument: --verbose - Flag. Optional. Output errors with variables.
# Argument: --debug - Flag. Optional. Debugging mode, for developers probably.
# Argument: --prefix - String. Optional. Prefix each environment variable defined with this string. e.g. `NAME` -> `DSN_NAME` for `--prefix DSN_`
# Argument: --context - String. Optional. Name of the context for debugging or error messages. (e.g. what is this doing for whom and why)
# Argument: --ignore environmentName - Optional. String. Environment value to ignore on load.
# Argument: --secure environmentName - Optional. String. If found, entire load fails.
# Argument: --secure-defaults - Flag. Optional. Add a list of environment variables considered security risks to the `--ignore` list.
# Argument: --execute arguments ... - Callable. Optional. All additional arguments are passed to callable after loading environment.
# Exit code: 2 - if file does not exist; outputs an error
# Exit code: 0 - if files are loaded successfully
environmentLoad() {
  local usage="_${FUNCNAME[0]}"

  local ff=() required=true ignoreList=() secureList=()
  local verboseMode=false debugMode=false hasOne=false execute=() variablePrefix=""

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
    --prefix)
      shift
      variablePrefix="$(usageArgumentEnvironmentVariable "$usage" "$argument" "${1-}")" || return $?
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
    --context)
      shift
      context="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
      ! $debugMode || printf -- "Context: %s\n" "$context"
      ;;
    --execute)
      shift
      binary=$(usageArgumentCallable "$usage" "$argument" "${1-}") || return $?
      shift
      execute=("$binary" "$@")
      break
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local name value environmentLine toExport=() line=1

  while read -r environmentLine; do
    ! $debugMode || printf "%s:%d: %s" "$context" "$line" "$(decorate code "$environmentLine")"
    name="${environmentLine%%=*}"
    # Skip comments
    if [ -z "$name" ] || [ "$name" != "${name###}" ]; then
      continue
    fi
    name="$variablePrefix$name"
    # Skip "bad" variables
    if ! environmentVariableNameValid "$name"; then
      ! $verboseMode || decorate warning "$(decorate code "$name") invalid name ($context:$line)"
      continue
    fi
    # Skip insecure variables
    [ "${#secureList[@]}" -eq 0 ] || ! inArray "$name" "${secureList[@]}" || __throwEnvironment "$usage" "${environmentFile} contains secure value $(decorate bold-red "$name") [$(decorate each --count code "${secureList[@]}")]" || return $?
    # Ignore stuff as a feature
    if [ "${#ignoreList[@]}" -gt 0 ] && inArray "$name" "${ignoreList[@]}"; then
      ! $debugMode || decorate warning "$(decorate code "$name") is ignored ($context:$line)"
      continue
    fi
    # Load and unquote value
    value="$(__unquote "${environmentLine#*=}")"
    # SECURITY CHECK
    toExport+=("$name=$value")
    ! $debugMode || printf "toExport: %s=%s\n" "$name" "$value"
    line=$((line + 1))
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
  [ ${#execute[@]} -eq 0 ] || __catchEnvironment "$usage" "${execute[@]}"
}
_environmentLoad() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Safely load an environment file (no code execution)
# Usage: {fn} [ --required | --optional ] [ --ignore name ] environmentFile ...
# Argument: environmentFile - Required. Environment file to load.
# Argument: --prefix - EnvironmentVariable|Blank. Optional. All subsequent environment variables are prefixed with this prefix.
# Argument: --require - Flag. Optional. All subsequent environment files on the command line will be required.
# Argument: --optional - Flag. Optional. All subsequent environment files on the command line will be optional. (If they do not exist, no errors.)
# Argument: --verbose - Flag. Optional. Output errors with variables in files.
# Argument: environmentFile - Required. Environment file to load. For `--optional` files the directory must exist.
# Argument: --ignore environmentName - Optional. String. Environment value to ignore on load.
# Argument: --secure environmentName - Optional. String. If found in a loaded file, entire file fails.
# Argument: --secure-defaults - Flag. Optional. Add a list of environment variables considered security risks to the `--ignore` list.
# Argument: --execute arguments ... - Callable. Optional. All additional arguments are passed to callable after loading environment files.
# Exit code: 2 - if file does not exist; outputs an error
# Exit code: 0 - if files are loaded successfully
environmentFileLoad() {
  local usage="_${FUNCNAME[0]}"

  local ff=() environmentFile required=true
  local verboseMode=false debugMode=false hasOne=false execute=() variablePrefix="" ee=() pp=()

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
    --verbose)
      verboseMode=true
      ee+=("$argument")
      ! $debugMode || printf -- "VERBOSE MODE on (Call: %s)\n" "$(decorate each code "${usage#_}" "${__saved[@]}")"
      ;;
    --debug)
      debugMode=true
      verboseMode=true
      ee+=("$argument")
      statusMessage decorate info "Debug mode enabled"
      ;;
    --secure-defaults)
      ee+=("$argument")
      ;;
    --ignore | --secure)
      shift
      ee+=("$argument" "${1-}")
      ;;
    --prefix)
      shift
      pp=("$argument" "${1-}")
      ;;
    --require)
      required=true
      ! $debugMode || printf -- "Current: %s\n" "$argument"
      ;;
    --optional)
      required=false
      ! $debugMode || printf -- "Current: %s\n" "$argument"
      ;;
    --execute)
      shift
      binary=$(usageArgumentCallable "$usage" "$argument" "${1-}") || return $?
      shift
      execute=("$binary" "$@")
      break
      ;;
    *)
      hasOne=true
      if $required; then
        ! $debugMode || printf -- "Loading required file: %s\n" "$argument"
        environmentFile="$(usageArgumentFile "$usage" "environmentFile" "$argument")" || return $?
        ff+=("$environmentFile") || return $?
      else
        ! $verboseMode || statusMessage decorate info "Loading optional file: $(decorate file "$argument")"
        environmentFile=$(usageArgumentFileDirectory "$usage" "environmentFile" "$argument") || return $?
        if [ -f "$environmentFile" ]; then
          ff+=("$environmentFile")
        else
          ! $debugMode || printf -- "Optional file does not exist: %s\n" "$environmentFile"
        fi
      fi
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  $hasOne || __throwArgument "$usage" "Requires at least one environmentFile" || return $?

  # If all files are optional, do nothing
  [ "${#ff[@]}" -gt 0 ] || return 0

  ! $debugMode || printf -- "Files to actually load: %d %s\n" "${#ff[@]}" "${ff[*]}"
  for environmentFile in "${ff[@]}"; do
    ! $debugMode || printf "%s lines:\n%s\n" "$(decorate code "$environmentFile")" "$(environmentLines <"$environmentFile")"
    __catchEnvironment "$usage" environmentLoad --context "$environmentFile" "${pp[@]+"${pp[@]}"}" "${ee[@]+"${ee[@]}"}" < <(environmentLines <"$environmentFile") || return $?
  done
  [ ${#execute[@]} -eq 0 ] || __catchEnvironment "$usage" "${execute[@]}"
}
_environmentFileLoad() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List environment variables related to security
environmentSecureVariables() {
  printf -- "%s\n" PATH LD_LIBRARY USER HOME HOSTNAME LANG PS1 PS2 PS3 CWD PWD SHELL SHLVL TERM TMPDIR VISUAL EDITOR
}

# List environment variables related to application deployments
environmentApplicationVariables() {
  printf -- "%s\n" BUILD_TIMESTAMP APPLICATION_BUILD_DATE APPLICATION_VERSION APPLICATION_ID APPLICATION_TAG
}

#
# Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values.
# Environment: BUILD_TIMESTAMP
# Environment: APPLICATION_BUILD_DATE
# Environment: APPLICATION_VERSION
# Environment: APPLICATION_ID
# Environment: APPLICATION_TAG
environmentApplicationLoad() {
  local usage="_${FUNCNAME[0]}"
  local hook home env
  local variables=()

  IFS=$'\n' read -d '' -r -a variables < <(environmentApplicationVariables) || :
  export "${variables[@]}"

  here=$(__catchEnvironment "$usage" buildHome) || return $?

  for env in "${variables[@]}"; do
    # shellcheck source=/dev/null
    source "$here/bin/build/env/$env.sh" || __throwEnvironment "$usage" "source $env.sh" || return $?
  done
  if [ -z "${APPLICATION_VERSION-}" ]; then
    hook=version-current
    APPLICATION_VERSION="$(__catchEnvironment "$usage" hookRun "$hook")" || return $?
  fi
  if [ -z "${APPLICATION_ID-}" ]; then
    hook=application-id
    APPLICATION_ID="$(__catchEnvironment "$usage" hookRun "$hook")" || return $?
  fi
  if [ -z "${APPLICATION_TAG-}" ]; then
    hook=application-tag
    APPLICATION_TAG="$(__catchEnvironment "$usage" hookRun "$hook")" || return $?
    if [ -z "${APPLICATION_TAG-}" ]; then
      APPLICATION_TAG=$APPLICATION_ID
    fi
  fi
  local variable
  for variable in "${variables[@]}" "$@"; do
    __catchEnvironment "$usage" environmentValueWrite "$variable" "${!variable-}" || return $?
  done
}
_environmentApplicationLoad() {
  ! false || environmentApplicationLoad --help
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Display and validate application variables.
# Exit Code: 1 - If any required application variables are blank, the function fails with an environment error
# Exit Code: 0 - All required application variables are non-blank
# Argument: environmentName - EnvironmentVariable. Optional. A required environment variable name
# Argument: -- - Separator. Optional. Separates requires from optional environment variables
# Argument: optionalEnvironmentName - EnvironmentVariable. Optional. An optional environment variable name.
environmentFileShow() {
  local usage="_${FUNCNAME[0]}"
  local name
  local width=40
  local variables=()

  IFS=$'\n' read -d '' -r -a variables < <(environmentApplicationVariables) || :
  for name in "${variables[@]+"${variables[@]}"}"; do
    environmentVariableNameValid "$name" || __catchArgument "$usage" "Invalid environment name $(decorate code "$name")" 1>&2
  done
  export "${variables[@]}"

  __catchEnvironment "$usage" muzzle environmentApplicationLoad || return $?

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
  local buildEnvironment=("$@")
  environmentVariableNameValid "$@" || __catchArgument "$usage" "Invalid variable name" || return $?

  printf -- "%s %s %s %s%s\n" "$(decorate info "Application")" "$(decorate magenta "$APPLICATION_VERSION")" "$(decorate info "on")" "$(decorate bold-red "$APPLICATION_BUILD_DATE")" "$(decorate info "...")"
  if buildDebugEnabled; then
    decorate pair "$width" Checksum "$APPLICATION_ID"
    decorate pair "$width" Tag "$APPLICATION_TAG"
    decorate pair "$width" Timestamp "$BUILD_TIMESTAMP"
  fi
  local name missing=()
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
  [ ${#missing[@]} -eq 0 ] || __throwEnvironment "$usage" "Missing environment $(decorate each code "${missing[@]}")" || return $?
}
_environmentFileShow() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} [ requiredEnvironment ... ] [ -- optionalEnvironment ...] "
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: requiredVariable ... - Optional. One or more environment variables which should be non-blank and included in the `.env` file.
# Argument: -- - Optional. Divider. Divides the requiredEnvironment values from the optionalEnvironment. Should appear once and only once.
# Argument: optionalVariable ... - Optional. One or more environment variables which are included if blank or not
#
# Create environment file `.env` for build.
#
# Note that this does NOT change or modify the current environment.
#
# Environment: APPLICATION_VERSION - reserved and set to `hookRun version-current` if not set already
# Environment: APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL.
# Environment: APPLICATION_TAG - reserved and set to `hookRun application-id`
# Environment: APPLICATION_ID - reserved and set to `hookRun application-tag`
environmentFileApplicationMake() {
  local usage="_${FUNCNAME[0]}"

  local required=() optional=() isOptional=false variableName="requiredVariable"

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
    --)
      if $isOptional; then
        __throwArgument "$usage" "Double -- found in argument list ($(decorate each quote "${__saved[@]}"))" || return $?
      fi
      isOptional=true
      variableName="optionalVariable"
      ;;
    *)
      local variable
      variable="$(usageArgumentEnvironmentVariable "$usage" "$variableName" "$1")" || return $?
      if $isOptional; then
        optional+=("$variable")
      else
        required+=("$variable")
      fi
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  set -- "${required[@]+"${required[@]}"}" # Copy to "$@"

  local loaded

  loaded="$(__catchEnvironment "$usage" environmentApplicationLoad "$@" && __catchEnvironment "$usage" environmentFileApplicationVerify "$@")" || return $?
  __catchEnvironment "$usage" printf -- "%s\n" "$loaded" || return $?

  local name
  for name in "$@" "${optional[@]+"${optional[@]}"}"; do
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

  IFS=$'\n' read -d '' -r -a requireEnvironment < <(environmentApplicationVariables) || :
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

# Adds an environment variable file to a project
environmentAddFile() {
  local usage="_${FUNCNAME[0]}"
  local name environmentNames=()

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
      name=$(usageArgumentEnvironmentVariable "$usage" "environmentVariable" "$1") || return $?
      environmentNames+=("$name")
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local home
  home=$(__catchEnvironment "$usage" buildHome) || return $?
  [ ${#environmentNames[@]} -gt 0 ] || __throwArgument "$usage" "Need at least one $(decorate code environmentVariable)" || return $?

  local year company

  year=$(__catchEnvironment "$usage" date +%Y) || return $?
  company=$(buildEnvironmentGet BUILD_COMPANY)
  for name in "${environmentNames[@]}"; do
    local path="$home/bin/env/$name.sh"
    if [ -f "$path" ] && ! fileIsEmpty "$path"; then
      if [ ! -x "$path" ]; then
        statusMessage --last decorate warning "Making $(decorate file "$path") executable ..."
        __catchEnvironment "$usage" chmod +x "$path" || return $?
      else
        statusMessage --last decorate info "Exists: $(decorate file "$path")"
      fi
    else
      __catchEnvironment "$usage" printf -- "%s\n" "#!/usr/bin/env bash" "# Copyright &copy; $year $company" "# Type: String" "# All about $name and how it is used" "export $name" "$name=\"\${$name-}\"" >"$path" || return $?
      __catchEnvironment "$usage" chmod +x "$path" || return $?
      statusMessage --last decorate success "Created $(decorate file "$path")"
    fi
  done
}
_environmentAddFile() {
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

# Output all exported environment variables, hiding secure ones and ones prefixed with underscore.
# Any values which contain a newline are also skipped.
#
# See: environmentSecureVariables
# Requires: __throwArgument decorate environmentSecureVariables grepSafe env removeFields
# Argument: --underscore - Flag. Include environment variables which begin with underscore `_`.
# Argument: --secure - Flag. Include environment variables which are in `environmentSecureVariables`
environmentOutput() {
  local usage="_${FUNCNAME[0]}"
  local skipSecure=true skipUnderscore=true

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
    --underscore)
      skipUnderscore=false
      ;;
    --secure)
      skipSecure=false
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local hideArgs=()
  if $skipSecure; then
    local hideSecure="^_" secureVar
    while read -r secureVar; do
      hideSecure="^$hideSecure\|^$(quoteGrepPattern "$secureVar")"
    done < <(environmentSecureVariables)
    hideArgs+=(-e "($hideSecure)=")
  fi
  if $skipUnderscore; then
    hideArgs+=(-e '^_')
  fi
  local filter=(cat)
  [ ${#hideArgs[@]} -eq 0 ] || filter=(grepSafe -z -v "${hideArgs[@]}")
  while IFS="=" read -r -d $'\0' name value; do
    if [ "${value#*$'\n'}" != "$value" ]; then
      # newline values are skipped
      continue
    fi
    environmentValueWrite "$name" "$value"
  done < <(env -0 | "${filter[@]}")
}
_environmentOutput() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Load an environment file and evaluate it using bash and output the changed environment variables after running
# Do not perform this operation on files which are untrusted.
# Argument: --underscore - Flag. Include environment variables which begin with underscore `_`.
# Argument: --secure - Flag. Include environment variables which are in `environmentSecureVariables`
# Argument: environmentFile - File. Required. Environment file to load, evaluate, and output in raw form (Bash-compatible).
# Security: source
environmentCompile() {
  local usage="_${FUNCNAME[0]}"

  local environmentFiles=() aa=()

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
    --underscore | --secure)
      if [ ${#aa[@]} -eq 0 ] || ! inArray "$argument" "${aa[@]}"; then
        aa+=("$argument")
      fi
      ;;
    *)
      environmentFiles+=("$(usageArgumentFile "$usage" "environmentFile" "$1")") || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  [ ${#environmentFiles[@]} -gt 0 ] || __throwArgument "$usage" "Need at least one environment file" || return $?

  local tempEnv
  tempEnv=$(fileTemporaryName "$usage") || return $?

  local clean=("$tempEnv" "$tempEnv.after")
  __catchEnvironment "$usage" environmentOutput "${aa[@]+"${aa[@]}"}" | sort >"$tempEnv" || _clean $? "${clean[@]}" || return $?
  (
    local environmentFile
    for environmentFile in "${environmentFiles[@]}"; do
      set -a
      # shellcheck source=/dev/null
      source "$environmentFile" >(outputTrigger source "$environmentFile") 2>&1 || _clean $? "${clean[@]}" || return $?
      set +a
    done
    __catchEnvironment "$usage" environmentOutput "${aa[@]+"${aa[@]}"}" | sort >"$tempEnv.after" || _clean $? "${clean[@]}" || return $?
  ) || _clean $? "${clean[@]}" || return $?
  diff -U0 "$tempEnv" "$tempEnv.after" | grepSafe '^+' | cut -c 2- | grepSafe -v '^+' || _clean $? "${clean[@]}" || return 0
  __catchEnvironment "$usage" rm -f "${clean[@]}" || return $?
}
_environmentCompile() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Clean *most* exported variables from the current context except a few important ones:
# - BUILD_HOME PATH LD_LIBRARY USER HOME PS1 PS2
# Calls unset on any variable in the global environment and exported.
# Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line
# Arguments: keepEnvironment - EnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore.
environmentClean() {
  local usage="_${FUNCNAME[0]}"
  local done=false variable keepers=(PATH LD_LIBRARY USER HOME PS1 PS2 BUILD_HOME "$@")
  while ! $done; do
    read -r variable || done=true
    [ -n "$variable" ] || continue
    if inArray "$variable" "${keepers[@]}"; then
      continue
    fi
    unset "${variable?}" || :
  done < <(declare -x | removeFields 2 | cut -f 1 -d =)
}
_environmentClean() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
