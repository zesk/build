#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh text.sh
# bin: head grep
# Docs: contextOpen ./docs/_templates/tools/docker.md

# IDENTICAL errorArgument 1
errorArgument=2

###############################################################################
#
#....▗▖..........▗▖.............
#....▐▌..........▐▌.............
#..▟█▟▌.▟█▙..▟██▖▐▌▟▛..▟█▙..█▟█▌
#.▐▛.▜▌▐▛.▜▌▐▛..▘▐▙█..▐▙▄▟▌.█▘..
#.▐▌.▐▌▐▌.▐▌▐▌...▐▛█▖.▐▛▀▀▘.█...
#.▝█▄█▌▝█▄█▘▝█▄▄▌▐▌▝▙.▝█▄▄▌.█...
#..▝▀▝▘.▝▀▘..▝▀▀.▝▘.▀▘.▝▀▀..▀...
#...............................

#
# Debugging, dumps the proc1file which is used to figure out if we
# are insideDocker or not; use this to confirm platform implementation
#
dumpDockerTestFile() {
  local proc1File=/proc/1/sched

  if [ -f "$proc1File" ]; then
    bigText $proc1File
    prefixLines "$(consoleMagenta)" <"$proc1File"
  else
    consoleWarning "Missing $proc1File"
  fi
}

#
# Are we inside a docker container right now?
#
# Exit Code: 0 - Yes
# Exit Code: 1 - No
#
insideDocker() {
  if [ ! -f /proc/1/sched ]; then
    # Not inside
    return 1
  fi
  if head -n 1 /proc/1/sched | grep -q init; then
    # Not inside
    return 1
  fi
  # inside
  return 0
}

# Ensure an environment file is compatible with non-quoted docker environment files
# Usage: checkDockerEnvFile [ filename ... ]
# Argument: filename - Docker environment file to check for common issues
# Exit Code: 1 - if errors occur
# Exit Code: 0 - if file is valid
#
checkDockerEnvFile() {
  local f result=0
  for f in "$@"; do
    if grep -q -E '\$|="|='"'" "$f"; then
      grep -E '\$|="|='"'" "$f" 1>&2
      result=1
    fi
  done
  return "$result"
}

# Internal
# See: dockerLocalContainer
_dockerLocalContainerUsage() {
  usageDocument "bin/build/tools/docker.sh" dockerLocalContainer "$@"
}

#
# Run a build container using given docker image.
#
# Runs ARM64 by default.
#
# fn: {base}
# Usage: {fn} imageName imageApplicationPath [ envFile ... ] [ extraArgs ... ]
# Argument: imageName - Required. String. Docker image name to run.
# Argument: imageApplicationPath - Path. Docker image path to map to current directory.
# Argument: envFile - Optional. File. One or more environment files which are suitable to load for docker; must be valid
# Argument: extraArgs - Optional. Mixed. The first non-file argument to `{fn}` is passed directly through to `docker run` as arguments
# Exit Code: 1 - If already inside docker, or the environment file passed is not valid
# Exit Code: 0 - Success
# Exit Code: Any - `docker run` error code is returned if non-zero
# Environment: BUILD_DOCKER_PLATFORM - Optional. Defaults to `linux/arm64`. Affects which image platform is used.
#
dockerLocalContainer() {
  local imageName imageApplicationPath envFiles extraArgs platform

  platform=${BUILD_DOCKER_PLATFORM-linux/arm64}
  imageName=${1-}
  if ! shift; then
    _dockerLocalContainerUsage "$errorArgument" "Missing imageApplicationPath"
    return $?
  fi
  imageApplicationPath=${1-}
  shift || :
  if [ -z "$imageName" ]; then
    _dockerLocalContainerUsage "$errorArgument" "imageName is empty"
    return $?
  fi
  if [ -z "$imageApplicationPath" ]; then
    _dockerLocalContainerUsage "$errorArgument" "imageApplicationPath is empty"
    return $?
  fi
  if insideDocker; then
    consoleError "Already inside docker" 1>&2
    return 1
  fi
  envFiles=()
  extraArgs=()
  while [ $# -gt 0 ] && [ -f "$1" ]; do
    if ! checkDockerEnvFile "$1" 2>/dev/null; then
      consoleError "Invalid docker env file: $1$(consoleCode)" 1>&2
      (checkDockerEnvFile "$1" 2>&1 || :) | prefixLines "$(consoleCode)     " 1>&2
      printf %s "$(consoleReset)" 1>&2
      return 1
    fi
    envFiles+=("--env-file" "$1")
    shift
  done
  extraArgs+=("$@")
  docker run "${envFiles[@]+"${envFiles[@]}"}" --platform "$platform" -v "$(pwd):$imageApplicationPath" -it "$imageName" "${extraArgs[@]+"${extraArgs[@]}"}"
}
