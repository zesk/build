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
  local usage="_${FUNCNAME[0]}"
  local name="${1-}" value output

  shift || __failArgument "$usage" "name required" || return $?
  name=$(usageArgumentString "$usage" name "$name") || return $?
  [ $# -ge 1 ] || __failArgument "$usage" "value required" || return $?
  if [ $# -eq 1 ]; then
    value="${1-}"
    output="$(declare -p value)"
  else
    value=("$@")
    output="$(declare -pa value)"
  fi
  output="${output#declare*value=}"
  printf "%s=%s\n" "$name" "$output"
}
_environmentValueWrite() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Read one or more values values safely from a environment file
# Usage: {fn} stateFile
# Argument: stateFile - Required. File. File to access, must exist.
# Argument: name - Required. String. Name to read.
# Argument: default - Optional. String. Value to return if value not found.
environmentValueRead() {
  local usage="_${FUNCNAME[0]}"
  local stateFile="${1-}" name="${2-}" default="${3-}" value
  [ -f "$stateFile" ] || __failArgument "$usage" "stateFile \"$stateFile\" is not a file" || return $?
  [ -n "$name" ] || __failArgument "$usage" "stateFile \"$stateFile\" name is blank (default=$default)" || return $?
  [ $# -le 3 ] || __failArgument "$usage" "Extra arguments: $#" || return $?
  value="$(grep -e "^$(quoteGrepPattern "$name")=" "$stateFile" | tail -n 1 | cut -c $((${#name} + 2))-)"
  if [ -z "$value" ]; then
    if [ -z "$default" ]; then
      return 1
    fi
    printf "%s\n" "$default"
  else
    declare "$name=$default"
    # Wondering if this can run shell code - do not believe so
    value="${value#\"}"
    value="${value%\"}"
    declare "$name=$value"
    printf "%s\n" "${!name-}"
  fi
}
_environmentValueRead() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Read an array value from a state file
# Usage: {fn} stateFile
# Argument: stateFile - Required. File. File to access, must exist.
# Argument: name - Required. String. Name to read.
# Outputs array elements, one per line.
environmentValueReadArray() {
  local usage="_${FUNCNAME[0]}"
  local stateFile="${1-}" name="${2-}" value

  value=$(__usageEnvironment "$usage" environmentValueRead "$stateFile" "$name" "")
  declare -a "value=$value"
  printf "%s\n" "${value[@]+"${value[@]}"}"
}
_environmentValueReadArray() {
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
  local usage="_${FUNCNAME[0]}" files where dotEnv

  where=
  [ $# -eq 0 ] || where=$(usageArgumentDirectory "$usage" "where" "${1-}") || return $?
  [ -n "$where" ] || where=$(__usageEnvironment "$usage" pwd) || return $?
  dotEnv="$where/.env"
  [ -f "$dotEnv" ] || __failEnvironment "$usage" "Missing $dotEnv" || return $?
  files=("$dotEnv")
  [ ! -f "$dotEnv.local" ] || files+=("$dotEnv.local")
  environmentFileLoad "${files[@]}" || __failEnvironment "$usage" environmentFileLoad "${files[@]}" return $?
}
_dotEnvConfigure() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} environmentFile ...
# Argument: environmentFile - Required. Environment file to load.
#
# Exit code: 2 - if file does not exist; outputs an error
# Exit code: 0 - if files are loaded successfully
environmentFileLoad() {
  local usage="_${FUNCNAME[0]}" environmentFile environmentLine name value
  while [ $# -gt 0 ]; do
    environmentFile=$(usageArgumentFile "$usage" "environmentFile" "$1") || return $?
    while read -r environmentLine; do
      name="${environmentLine%%=*}"
      value="${environmentLine#*=}"
      value="${value#\"}"
      value="${value%\"}"
      # SECURITY CHECK
      export "$name"="$value"
    done < <(environmentLines <"$environmentFile")
    shift
  done
}
_environmentFileLoad() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

environmentApplicationVariables() {
  cat <<EOF
BUILD_TIMESTAMP
APPLICATION_BUILD_DATE
APPLICATION_VERSION
APPLICATION_ID
APPLICATION_TAG
EOF
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
  printf "%s\n" "${variables[@]}"
}

environmentFileShow() {
  local missing name buildEnvironment
  local width=40
  local variables=()

  IFS=$'\n' read -d '' -r -a variables < <(environmentApplicationLoad) || :
  export "${variables[@]}"

  # Will be exported to the environment file, only if defined
  while [ $# -gt 0 ]; do
    case $1 in
      --)
        shift
        break
        ;;
      *)
        variables+=("$1")
        ;;
    esac
    shift
  done
  buildEnvironment=("$@")

  printf "%s %s %s %s%s\n" "$(consoleInfo "Application")" "$(consoleMagenta "$APPLICATION_VERSION")" "$(consoleInfo "on")" "$(consoleBoldRed "$APPLICATION_BUILD_DATE")" "$(consoleInfo "...")"
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
    if [ -z "${!name:-}" ]; then
      consoleNameValue "$width" "$name" "** Blank **"
    else
      consoleNameValue "$width" "$name" "${!name}"
    fi
  done
  [ ${#missing[@]} -eq 0 ] || _environment "Missing environment" "${missing[@]}" || return $?
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
  local variableNames

  variableNames=$(__usageEnvironment "$usage" mktemp) || return $?
  environmentApplicationLoad >"$variableNames" || __failEnvironment "$usage" "environmentApplicationLoad" || return $?
  environmentFileApplicationVerify "$@" || __failArgument "$usage" "Verify failed" || return $?
  IFS=$'\n' read -d '' -r -a variables <"$variableNames"
  for name in "${variables[@]}" "$@"; do
    [ "$name" != "--" ] || continue
    environmentValueWrite "$name" "${!name-}"
  done
}
_environmentFileApplicationMake() {
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
    if [ -z "${!name:-}" ]; then
      missing+=("$name")
    fi
  done
  [ ${#missing[@]} -eq 0 ] || __failEnvironment "$usage" "Missing environment values:" "${missing[@]}" || return $?
}
_environmentFileApplicationVerify() {
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
