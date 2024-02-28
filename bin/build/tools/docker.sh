#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh text.sh
# bin: head grep
# Docs: contextOpen ./docs/_templates/tools/docker.md
# Test: contextOpen ./test/tools/docker-tests.sh

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
  local file index envLine result=0
  if [ $# -eq 0 ]; then
    _dockerEnvToBashPipe
  else
    for file in "$@"; do
      if [ ! -f "$file" ]; then
        _dockerEnvToBash "$errorArgument" "Not a file $file" || return $?
      fi
      if ! _dockerEnvToBashPipe <"$file"; then
        _dockerEnvToBash "$errorArgument" "Invalid file: $file" || return $?
      fi
    done
  fi
}
_dockerEnvToBashPipe() {
  local file index envLine result
  result=0
  index=0
  while IFS="" read -r envLine; do
    name="${envLine%%=*}"
    value="${envLine#*=}"
    if [ -n "$name" ] && [ "$name" != "$envLine" ]; then
      if [ -z "$(printf "%s" "$name" | sed 's/^[A-Za-z][0-9A-Za-z_]*$//g')" ]; then
        printf "%s=\"%s\"\n" "$name" "$(escapeDoubleQuotes "$value")"
      else
        consoleError "Invalid name at line $index: $name" 1>&2
        # shellcheck disable=SC2030
        result=$errorArgument
      fi
    else
      case "$envLine" in
        [#]* | "")
          # Comment line
          printf "%s\n" "$envLine"
          ;;
        *)
          consoleError "Invalid line $index: $envLine" 1>&2
          result=$errorArgument
          ;;
      esac
    fi
    index=$((index + 1))
  done
  return $result
}
_dockerEnvToBash() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Ensure an environment file is compatible with non-quoted docker environment files
# Usage: checkDockerEnvFile [ filename ... ]
# Argument: filename - Docker environment file to check for common issues
# Exit Code: 1 - if errors occur
# Exit Code: 0 - if file is valid
#
dockerEnvFromBash() {
  local file envLine
  for file in "$@"; do
    if [ ! -f "$file" ]; then
      consoleError "Not a file $file" 1>&2
      return $errorArgument
    fi
    if ! (
      env -i bash -c "set -a && source $file 2>/dev/null && env" | grep -E -v '^(PWD|_|SHLVL)='
    ); then
      consoleError "$file is not a valid bash file" 1>&2
      return $errorArgument
    fi
  done
}

#
# Run a build container using given docker image.
#
# Runs ARM64 by default.
#
# fn: {base}
# Usage: {fn} imageName imageApplicationPath [ envFile ... ] [ extraArgs ... ]
# Argument: --image imageName - Optional. String. Docker image name to run. Defaults to `BUILD_DOCKER_IMAGE`.
# Argument: --path imageApplicationPath - Path. Docker image path to map to current directory. Defaults to `BUILD_DOCKER_PATH`.
# Argument: --platform platform - Optional. String. Platform to run (arm vs cisc).
# Argument: envFile - Optional. File. One or more environment files which are suitable to load for docker; must be valid
# Argument: extraArgs - Optional. Mixed. The first non-file argument to `{fn}` is passed directly through to `docker run` as arguments
# Exit Code: 1 - If already inside docker, or the environment file passed is not valid
# Exit Code: 0 - Success
# Exit Code: Any - `docker run` error code is returned if non-zero
# Environment: BUILD_DOCKER_PLATFORM - Optional. Defaults to `linux/arm64`. Affects which image platform is used.
#
dockerLocalContainer() {
  local platform imageName imageApplicationPath
  local envFiles extraArgs
  local tempEnvs tempEnv exitCode envName
  local failedWhy

  for envName in BUILD_DOCKER_PLATFORM BUILD_DOCKER_IMAGE BUILD_DOCKER_PATH; do
    # shellcheck source=/dev/null
    if ! . "bin/build/env/$envName.sh"; then
      return $?
    fi
  done
  platform=${BUILD_DOCKER_PLATFORM}
  imageApplicationPath=${BUILD_DOCKER_PATH}
  imageName=${BUILD_DOCKER_IMAGE}

  exitCode=0
  envFiles=()
  extraArgs=()
  tempEnvs=()
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      _dockerLocalContainer "$errorArgument" "Blank argument"
      return $?
    fi
    case "$1" in
      --image)
        shift || :
        imageName="$1"
        ;;
      --path)
        shift || :
        imageApplicationPath="$1"
        ;;
      --env)
        shift || :
        if [ ! -f "$1" ]; then
          [ ${#tempEnvs[@]} -eq 0 ] || rm -f "${tempEnvs[@]}" || :
          _dockerLocalContainer "$errorArgument" "--env $1 is not a file"
          return $?
        fi
        if ! checkDockerEnvFile "$1" 2>/dev/null; then
          tempEnv=$(mktemp)
          tempEnvs+=("$tempEnv")
          if ! dockerEnvFromBash "$1" >"$tempEnv" 2>/dev/null; then
            {
              printf "%s %s\n" "$(consoleError "Invalid docker env file:")" "$(consoleMagenta "$1")$(consoleCode)"
              (checkDockerEnvFile "$1" 2>&1 || :) | prefixLines "$(consoleCode)     "
              printf %s "$(consoleReset)"
            } 1>&2
            rm -f "${tempEnvs[@]}" || :
            return 1
          else
            printf "%s: %s\n" "$(consoleWarning "Converted to docker-compatible env")" "$(consoleCode "$1")"
            envFiles+=("--env-file" "$tempEnv")
          fi
        else
          envFiles+=("--env-file" "$1")
        fi
        ;;
      --platform)
        shift || :
        platform="$1"
        ;;
      *)
        extraArgs+=("$1")
        ;;
    esac
    shift
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
    _dockerLocalContainer "$errorArgument" "$failedWhy"
    return $?
  fi
  if ! docker run "${envFiles[@]+"${envFiles[@]}"}" --platform "$platform" -v "$(pwd):$imageApplicationPath" -it "$imageName" "${extraArgs[@]+"${extraArgs[@]}"}"; then
    exitCode=$?
  fi
  [ ${#tempEnvs[@]} -eq 0 ] || rm -f "${tempEnvs[@]}" || :
  return $exitCode
}
_dockerLocalContainer() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
