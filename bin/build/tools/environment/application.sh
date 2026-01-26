#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# List environment variables related to application deployments
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
environmentApplicationVariables() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf -- "%s\n" BUILD_TIMESTAMP APPLICATION_BUILD_DATE APPLICATION_VERSION APPLICATION_ID APPLICATION_TAG
}
_environmentApplicationVariables() {
  true || environmentApplicationVariables --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values.
# Environment: BUILD_TIMESTAMP
# Environment: APPLICATION_BUILD_DATE
# Environment: APPLICATION_VERSION
# Environment: APPLICATION_ID
# Environment: APPLICATION_TAG
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
environmentApplicationLoad() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local variables=()

  IFS=$'\n' read -d '' -r -a variables < <(environmentApplicationVariables) || :
  export "${variables[@]}"

  here=$(catchReturn "$handler" buildHome) || return $?

  local env && for env in "${variables[@]}"; do
    # shellcheck source=/dev/null
    source "$here/bin/build/env/$env.sh" || throwEnvironment "$handler" "source $env.sh" || return $?
  done
  local hook=""
  if [ -z "${APPLICATION_VERSION-}" ]; then
    hook="version-current"
    APPLICATION_VERSION="$(catchEnvironment "$handler" hookRun "$hook")" || return $?
  fi
  if [ -z "${APPLICATION_ID-}" ]; then
    hook="application-id"
    APPLICATION_ID="$(catchEnvironment "$handler" hookRun "$hook")" || return $?
  fi
  if [ -z "${APPLICATION_TAG-}" ]; then
    hook="application-tag"
    APPLICATION_TAG="$(catchEnvironment "$handler" hookRun "$hook")" || return $?
    if [ -z "${APPLICATION_TAG-}" ]; then
      APPLICATION_TAG=$APPLICATION_ID
    fi
  fi
  local variable
  for variable in "${variables[@]}" "$@"; do
    catchReturn "$handler" environmentValueWrite "$variable" "${!variable-}" || return $?
  done
}
_environmentApplicationLoad() {
  ! false || environmentApplicationLoad --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: requiredVariable ... - EnvironmentVariable. Optional. One or more environment variables which should be non-blank and included in the `.env` file.
# Argument: -- - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment. Should appear once and only once.
# Argument: optionalVariable ... - EnvironmentVariable. Optional. One or more environment variables which are included if blank or not
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
  local handler="_${FUNCNAME[0]}"

  local required=() optional=() isOptional=false variableName="requiredVariable"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --)
      if $isOptional; then
        throwArgument "$handler" "Double -- found in argument list ($(decorate each quote "${__saved[@]}"))" || return $?
      fi
      isOptional=true
      variableName="optionalVariable"
      ;;
    *)
      local variable
      variable="$(validate "$handler" EnvironmentVariable "$variableName" "$1")" || return $?
      if $isOptional; then
        optional+=("$variable")
      else
        required+=("$variable")
      fi
      ;;
    esac
    shift
  done

  set -- "${required[@]+"${required[@]}"}" # Copy to "$@"

  local loaded

  loaded="$(catchReturn "$handler" environmentApplicationLoad "$@" && catchReturn "$handler" environmentFileApplicationVerify "$@")" || return $?
  printf -- "%s\n" "$loaded"

  local name
  for name in "$@" "${optional[@]+"${optional[@]}"}"; do
    catchReturn "$handler" environmentValueWrite "$name" "${!name-}" || return $?
  done
}
_environmentFileApplicationMake() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Check application environment is populated correctly.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: requiredEnvironment ... - EnvironmentName. Optional. One or more environment variables which should be non-blank and included in the `.env` file.
# Argument: -- - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment
# Argument: optionalEnvironment ... - EnvironmentName. Optional. One or more environment variables which are included if blank or not
# Also verifies that `environmentApplicationVariables` and `environmentApplicationLoad` are defined.
environmentFileApplicationVerify() {
  local handler="_${FUNCNAME[0]}"
  local missing name requireEnvironment
  local requireEnvironment=() extras=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --)
      shift && break
      ;;
    *)
      extras+=("$1")
      ;;
    esac
    shift
  done

  IFS=$'\n' read -d '' -r -a requireEnvironment < <(environmentApplicationVariables) || :
  missing=()
  for name in "${requireEnvironment[@]}" "${extras[@]+"${extras[@]}"}"; do
    environmentVariableNameValid "$name" || throwEnvironment "$handler" "Invalid environment name found: $(decorate code "$name")" || return $?
    if [ -z "${!name:-}" ]; then
      missing+=("$name")
    fi
  done
  [ ${#missing[@]} -eq 0 ] || throwEnvironment "$handler" "Missing environment values:" "${missing[@]}" || return $?
}
_environmentFileApplicationVerify() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: where - Directory. Optional. Where to load the `.env` files.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
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
# Use with caution on trusted content only.
# Return Code: 1 - if `.env` does not exist; outputs an error
# Return Code: 0 - if files are loaded successfully
# DEPRECATED: 2024-07-20
# See: environmentFileLoad
dotEnvConfigure() {
  local handler="_${FUNCNAME[0]}"

  local aa=() where=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose | --debug)
      aa+=("$argument")
      ;;
    *)
      where=$(validate "$handler" Directory "where" "$1") || return $?
      ;;
    esac
    shift
  done

  if [ -z "$where" ]; then
    where=$(catchEnvironment "$handler" pwd) || return $?
  fi
  aa+=(--require "$where/.env" --optional "$where/.env.local" --require)
  catchReturn "$handler" environmentFileLoad "${aa[@]}" "$@" || return $?
}
_dotEnvConfigure() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
