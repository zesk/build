#!/usr/bin/env bash
#
# Tools specifically for BitBucket pipelines
#
# Copyright &copy; 2025 Market Acumen, Inc.
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
# On this file, the value of `$(getFromPipelineYML MARIADB_ROOT_PASSWORD)` is `super-secret`; it uses `grep` and `sed` to extract the value.
#
# Usage: {fn} varName defaultValue
# Argument: varName - Name of the value to extract from `bitbucket-pipelines.yml`
# Argument: defaultValue - Value if not found in pipelines
# Example:     MARIADB_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD:-$(getFromPipelineYML MARIADB_ROOT_PASSWORD not-in-bitbucket-pipelines.yml)}
#
getFromPipelineYML() {
  local value

  value=$(grep "$1" bitbucket-pipelines.yml | awk '{ print $2 }')
  value=${value:-$2}

  printf "%s" "$value"
}

#
# fn: {base}
# Usage: {fn} [ envFile ... ] [ extraArgs ... ]
# Argument: envFile - One or more environment files which are suitable to load for docker; must be valid
# Argument: extraArgs - The first non-file argument to `{fn}` is passed directly through to `docker run` as arguments
# Exit Code: 1 - If already inside docker, or the environment file passed is not valid
# Exit Code: 0 - Success
# Exit Code: Any - `docker run` error code is returned if non-zero
#
# Run the default build container for build testing on BitBucket
#
# Updated: 2024-01-26
#
bitbucketContainer() {
  export BUILD_DOCKER_BITBUCKET_IMAGE BUILD_DOCKER_BITBUCKET_PATH
  if ! buildEnvironmentLoad BUILD_DOCKER_BITBUCKET_IMAGE BUILD_DOCKER_BITBUCKET_PATH; then
    return 1
  fi
  dockerLocalContainer --image "${BUILD_DOCKER_BITBUCKET_IMAGE}" --path "${BUILD_DOCKER_BITBUCKET_PATH}" "$@"
}
_bitbucketContainer() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Are we currently in the BitBucket pipeline?
# Usage: {fn}
# Exit Code: 0 - is BitBucket pipeline
# Exit Code: 1 - Not a BitBucket pipeline
#
isBitBucketPipeline() {
  export BUILD_DEBUG BITBUCKET_WORKSPACE CI
  if ! buildEnvironmentLoad BITBUCKET_WORKSPACE CI; then
    return 1
  fi
  [ -n "${BITBUCKET_WORKSPACE-}" ] && test "${CI-}"
}
