#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# bin: head grep
# Docs: contextOpen ./docs/_templates/tools/docker.md
# Test: contextOpen ./test/tools/docker-tests.sh

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
    wrapLines "$(consoleMagenta)" "$(consoleReset)" <"$proc1File"
  else
    consoleWarning "Missing $proc1File"
  fi
}

# Are we inside a docker container right now?
#
# Exit Code: 0 - Yes
# Exit Code: 1 - No
#
# TODO: This changed 2023 ...
#
insideDocker() {
  if [ ! -f /proc/1/cmdline ]; then
    # Not inside
    return 1
  fi
  if grep -q init /proc/1/cmdline; then
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
  local f result=0 pattern

  pattern='\$|="|='"'"
  for f in "$@"; do
    if grep -q -E "$pattern" "$f"; then
      grep -E "$pattern" "$f" 1>&2
      result=1
    fi
  done
  return "$result"
}

#
# Takes any environment file and makes it docker-compatible
#
# Outputs the compatible env to stdout
# Usage: {fn} envFile [ ... ]
# Argument: envFile - Required. File. One or more files to convert.
#
anyEnvToDockerEnv() {
  local usage="_${FUNCNAME[0]}"
  local f
  while [ $# -gt 0 ]; do
    f=$(usageArgumentFile "$usage" envFile "$1")
    if ! checkDockerEnvFile "$f" 2>/dev/null; then
      if ! dockerEnvFromBashEnv "$f"; then
        __failEnvironment "$usage" "dockerEnvFromBashEnv $f" || return $?
      fi
    else
      __usageEnvironment "$usage" cat "$f" || return $?
    fi
    shift
  done
}
_anyEnvToDockerEnv() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Takes any environment file and makes it bash-compatible
#
# Outputs the compatible env to stdout
#
# Usage: {fn} filename [ ... ]
# Argument: filename - Required. File. One or more files to convert.
#
anyEnvToBashEnv() {
  local usage="_${FUNCNAME[0]}"
  local f
  for f in "$@"; do
    if checkDockerEnvFile "$f" 2>/dev/null; then
      __usageEnvironment "$usage" dockerEnvToBash "$f"
    else
      __usageEnvironment "$usage" cat "$f" || return $?
    fi
  done
}
_anyEnvToBashEnv() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Ensure an environment file is compatible with non-quoted docker environment files
# May take a list of files to convert or stdin piped in
#
# Outputs bash-compatible entries to stdout
# Any output to stdout is considered valid output
# Any output to stderr is errors in the file but is written to be compatible with a bash
#
# Usage: {fn} [ filename ... ]
# Argument: filename - Docker environment file to check for common issues
# Exit Code: 1 - if errors occur
# Exit Code: 0 - if file is valid
#
dockerEnvToBash() {
  local usage="_${FUNCNAME[0]}"
  local file index envLine result=0
  if [ $# -eq 0 ]; then
    _dockerEnvToBashPipe
  else
    for file in "$@"; do
      [ -f "$file" ] || __failArgument "$usage" "Not a file $file" || return $?
      _dockerEnvToBashPipe <"$file" || __failArgument "$usage" "Invalid file: $file" || return $?
    done
  fi
}
_dockerEnvToBash() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Utility for dockerEnvToBash to handle both pipes and files
#
_dockerEnvToBashPipe() {
  local file index envLine result name value
  result=0
  index=0
  while IFS="" read -r envLine; do
    name="${envLine%%=*}"
    value="${envLine#*=}"
    if [ -n "$name" ] && [ "$name" != "$envLine" ]; then
      if [ -z "$(printf "%s" "$name" | sed 's/^[A-Za-z][0-9A-Za-z_]*$//g')" ]; then
        printf "%s=\"%s\"\n" "$name" "$(escapeDoubleQuotes "$value")"
      else
        _argument "Invalid name at line $index: $name" || result=$?
      fi
    else
      case "$envLine" in
        [#]* | "")
          # Comment line
          printf "%s\n" "$envLine"
          ;;
        *)
          _argument "Invalid line $index: $envLine" || result=$?
          ;;
      esac
    fi
    index=$((index + 1))
  done
  return $result
}

# Ensure an environment file is compatible with non-quoted docker environment files
# Usage: checkDockerEnvFile [ filename ... ]
# Argument: filename - Docker environment file to check for common issues
# Exit Code: 1 - if errors occur
# Exit Code: 0 - if file is valid
#
dockerEnvFromBashEnv() {
  local usage="_${FUNCNAME[0]}"
  local file envLine
  for file in "$@"; do
    [ -f "$file" ] || __failArgument "$usage" "Not a file $file" || return $?
    (
      env -i bash -c "set -a && source $file 2>/dev/null && env" | grep -E -v '^(PWD|_|SHLVL)='
    ) || __failArgument "$usage" "$file is not a valid bash file" || return $?
  done
}
_dockerEnvFromBashEnv() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Run a build container using given docker image.
#
# Runs ARM64 by default.
#
# fn: {base}
# Usage: {fn} imageName imageApplicationPath [ envFile ... ] [ extraArgs ... ]
# Argument: --help - Optional. Flag. This help.
# Argument: --image imageName - Optional. String. Docker image name to run. Defaults to `BUILD_DOCKER_IMAGE`.
# Argument: --path imageApplicationPath - Path. Docker image path to map to current directory. Defaults to `BUILD_DOCKER_PATH`.
# Argument: --platform platform - Optional. String. Platform to run (arm vs intel).
# Argument: envFile - Optional. File. One or more environment files which are suitable to load for docker; must be valid
# Argument: extraArgs - Optional. Mixed. The first non-file argument to `{fn}` is passed directly through to `docker run` as arguments
# Exit Code: 1 - If already inside docker, or the environment file passed is not valid
# Exit Code: 0 - Success
# Exit Code: Any - `docker run` error code is returned if non-zero
# Environment: BUILD_DOCKER_PLATFORM - Optional. Defaults to `linux/arm64`. Affects which image platform is used.
#
dockerLocalContainer() {
  local usage="_${FUNCNAME[0]}"
  local platform imageName imageApplicationPath
  local envFiles extraArgs
  local tempEnvs tempEnv exitCode
  local failedWhy

  export BUILD_DOCKER_PLATFORM BUILD_DOCKER_PATH BUILD_DOCKER_IMAGE

  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_DOCKER_PLATFORM BUILD_DOCKER_IMAGE BUILD_DOCKER_PATH || return $?

  platform=${BUILD_DOCKER_PLATFORM}
  imageApplicationPath=${BUILD_DOCKER_PATH}
  imageName=${BUILD_DOCKER_IMAGE}

  exitCode=0
  envFiles=()
  extraArgs=()
  tempEnvs=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --image)
        shift || __failArgument "$usage" "missing $(consoleLabel "$argument") argument" || return $?
        imageName="$1"
        ;;
      --path)
        shift || __failArgument "$usage" "missing $(consoleLabel "$argument") argument" || return $?
        imageApplicationPath="$1"
        ;;
      --env)
        shift || __failArgument "$usage" "missing $(consoleLabel "$argument") argument" || return $?
        envFile=$(usageArgumentFile "$usage" "envFile" "$1") || return $?
        tempEnv=$(__usageEnvironment "$usage" mktemp) || return $?
        __usageArgument "$usage" anyEnvToDockerEnv "$envFile" >"$tempEnv" || return $?
        tempEnvs+=("$tempEnv")
        envFiles+=("--env-file" "$tempEnv")
        ;;
      --platform)
        shift || __failArgument "$usage" "missing $(consoleLabel "$argument") argument" || return $?
        platform="$1"
        ;;
      *)
        extraArgs+=("$1")
        ;;
    esac
    shift || :
  done
  failedWhy=
  if [ -z "$imageName" ]; then
    failedWhy="imageName is empty"
  elif [ -z "$imageApplicationPath" ]; then
    failedWhy="imageApplicationPath is empty"
  elif insideDocker; then
    failedWhy="Already inside docker"
  fi
  if [ -n "$failedWhy" ]; then
    [ ${#tempEnvs[@]} -eq 0 ] || rm -f "${tempEnvs[@]}" || :
    __failEnvironment "$usage" "$failedWhy" || return $?
  fi
  __usageEnvironment "$usage" docker run "${envFiles[@]+"${envFiles[@]}"}" --platform "$platform" -v "$(pwd):$imageApplicationPath" -it "$imageName" "${extraArgs[@]+"${extraArgs[@]}"}" || exitCode=$?
  [ ${#tempEnvs[@]} -eq 0 ] || rm -f "${tempEnvs[@]}" || :
  return $exitCode
}
_dockerLocalContainer() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
