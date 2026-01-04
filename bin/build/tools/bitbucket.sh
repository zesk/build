#!/usr/bin/env bash
#
# Tools specifically for BitBucket pipelines
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Depends: -
# bin: grep awk
#

# Fetch a value from the pipelines YAML file
#
# Assumes current working directory is project root.
#
# Simple get value of a variable from the `bitbucket-pipelines.yml` file. It's important to note that
# this does not parse the YML. This is useful if
# you have a database container as part of your build configuration which requires a root password
# required in other scripts; this means you do not have to replicate the value which can lead to errors.
#
# An example `bitbucket-pipelines.yml` file may have a header which looks like this:
#
#     definitions:
#     caches:
#         apt-lists: /var/lib/apt/lists
#         apt-cache: /var/cache/apt
#     services:
#         mariadb:
#         memory: 1024
#         image: mariadb:latest
#         variables:
#             MARIADB_ROOT_PASSWORD: super-secret
#
# On this file, the value of `$(bitbucketGetVariable MARIADB_ROOT_PASSWORD)` is `super-secret`; it uses `grep` and `sed` to extract the value.
#
# handler: {fn} varName defaultValue
# Argument: varName - Name of the value to extract from `bitbucket-pipelines.yml`
# Argument: defaultValue - Value if not found in pipelines
# Example:     MARIADB_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD:-$(bitbucketGetVariable MARIADB_ROOT_PASSWORD not-in-bitbucket-pipelines.yml)}
#
bitbucketGetVariable() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local value yml home

  home=$(catchReturn "$handler" buildHome) || return $?
  yml="$home/bitbucket-pipelines.yml"

  [ -f "$yml" ] || throwEnvironment "$handler" "Missing $yml" || return $?
  value=$(grep "$1" "$yml" | awk '{ print $2 }')
  value=${value:-$2}

  printf "%s" "$value"
}
_bitbucketGetVariable() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# handler: {fn} [ envFile ... ] [ extraArgs ... ]
# Argument: envFile - One or more environment files which are suitable to load for docker; must be valid
# Argument: extraArgs - The first non-file argument to `{fn}` is passed directly through to `docker run` as arguments
# Return Code: 1 - If already inside docker, or the environment file passed is not valid
# Return Code: 0 - Success
# Return Code: Any - `docker run` error code is returned if non-zero
#
# Run the default build container for build testing on BitBucket
#
# Updated: 2024-01-26
#
bitbucketContainer() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  export BUILD_DOCKER_BITBUCKET_IMAGE BUILD_DOCKER_BITBUCKET_PATH
  if ! buildEnvironmentLoad BUILD_DOCKER_BITBUCKET_IMAGE BUILD_DOCKER_BITBUCKET_PATH; then
    return 1
  fi
  dockerLocalContainer --handler "$handler" --image "${BUILD_DOCKER_BITBUCKET_IMAGE-}" --path "${BUILD_DOCKER_BITBUCKET_PATH-}" "$@"
}
_bitbucketContainer() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Are we currently in the BitBucket pipeline?
# Return Code: 0 - is BitBucket pipeline
# Return Code: 1 - Not a BitBucket pipeline
#
isBitBucketPipeline() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  export BUILD_DEBUG BITBUCKET_WORKSPACE CI
  if ! buildEnvironmentLoad BITBUCKET_WORKSPACE CI; then
    return 1
  fi
  [ -n "${BITBUCKET_WORKSPACE-}" ] && test "${CI-}"
}
_isBitBucketPipeline() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Compute the URL to create a new PR
# Argument: organization - String. Organization name.
# Argument: repository - String. Repository name.
bitbucketPRNewURL() {
  local handler="_${FUNCNAME[0]}"
  local org="" name="" eventSource="bash" source=""

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
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --event-source) shift && eventSource=$(usageArgumentString "$handler" "$argument" "${1-}") || return $? ;;
    --source) shift && source=$(usageArgumentString "$handler" "$argument" "${1-}") || return $? ;;
    *)
      if [ -z "$org" ]; then
        org=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      elif [ -z "$name" ]; then
        name=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done
  [ -n "$org" ] || throwArgument "$handler" "Organization is required" || return $?
  [ -n "$name" ] || throwArgument "$handler" "Repository is required" || return $?
  [ -n "$source" ] || source=$(catchEnvironment "$handler" gitCurrentBranch) || return $?
  printf -- "https://bitbucket.org/%s/%s/pull-requests/new?source=%s&event_source=%s" "$org" "$name" "$source" "$eventSource"
}
_bitbucketPRNewURL() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
