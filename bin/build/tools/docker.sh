#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh text.sh
# bin: head grep
# Docs: contextOpen ./docs/_templates/tools/docker.md
# Test: contextOpen ./test/tools/docker-tests.sh

# IDENTICAL errorEnvironment 1
errorEnvironment=1

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
# Returns a temporary file which should be deleted.
# Usage: {fn} filename [ ... ]
# Argument: filename - Required. File. One or more files to convert.
#
anyEnvToDockerEnv() {
  local f temp
  for f in "$@"; do
    if ! temp=$(mktemp); then
      "_${FUNCNAME[0]}" "$errorEnvironment" "mktemp failed" || return $?
    fi
    if ! checkDockerEnvFile "$f" 2>/dev/null; then
      if ! dockerEnvFromBashEnv "$f" >"$temp"; then
        rm -rf "$temp" || :
        "_${FUNCNAME[0]}" "$errorEnvironment" "dockerEnvToBash $f" || return $?
      fi
    else
      if ! cp "$f" "$temp"; then
        rm -rf "$temp" || :
        "_${FUNCNAME[0]}" "$errorEnvironment" "cp $f $temp" || return $?
      fi
    fi
    printf "%s\n" "$temp"
  done
}
_anyEnvToDockerEnv() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Takes any environment file and makes it bash-compatible
#
# Returns a temporary file which should be deleted.
# Usage: {fn} filename [ ... ]
# Argument: filename - Required. File. One or more files to convert.
#
anyEnvToBashEnv() {
  local f temp
  for f in "$@"; do
    if ! temp=$(mktemp); then
      "_${FUNCNAME[0]}" "$errorEnvironment" "mktemp failed" || return $?
    fi
    if checkDockerEnvFile "$f" 2>/dev/null; then
      if ! dockerEnvToBash "$f" >"$temp"; then
        rm -rf "$temp" || :
        "_${FUNCNAME[0]}" "$errorEnvironment" "dockerEnvToBash $f" || return $?
      fi
    else
      if ! cp "$f" "$temp"; then
        rm -rf "$temp" || :
        "_${FUNCNAME[0]}" "$errorEnvironment" "cp $f $temp" || return $?
      fi
    fi
    printf "%s\n" "$temp"
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
  local file index envLine result=0
  if [ $# -eq 0 ]; then
    _dockerEnvToBashPipe
  else
    for file in "$@"; do
      if [ ! -f "$file" ]; then
        "_${FUNCNAME[0]}" "$errorArgument" "Not a file $file" || return $?
      fi
      if ! _dockerEnvToBashPipe <"$file"; then
        "_${FUNCNAME[0]}" "$errorArgument" "Invalid file: $file" || return $?
      fi
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

# Ensure an environment file is compatible with non-quoted docker environment files
# Usage: checkDockerEnvFile [ filename ... ]
# Argument: filename - Docker environment file to check for common issues
# Exit Code: 1 - if errors occur
# Exit Code: 0 - if file is valid
#
dockerEnvFromBashEnv() {
  local file envLine
  for file in "$@"; do
    if [ ! -f "$file" ]; then
      "_${FUNCNAME[0]}" $errorArgument "Not a file $file" || return $?
    fi
    if ! (
      env -i bash -c "set -a && source $file 2>/dev/null && env" | grep -E -v '^(PWD|_|SHLVL)='
    ); then
      "_${FUNCNAME[0]}" $errorArgument "$file is not a valid bash file" || return $?
    fi
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
  local fail arg platform imageName imageApplicationPath
  local envFiles extraArgs
  local tempEnvs tempEnv exitCode
  local failedWhy

  fail="_${FUNCNAME[0]}"
  if ! buildEnvironmentLoad BUILD_DOCKER_PLATFORM BUILD_DOCKER_IMAGE BUILD_DOCKER_PATH; then
    _deployToRemote "$errorEnvironment" "HOME BUILD_DEBUG environment failed" || return $?
  fi

  platform=${BUILD_DOCKER_PLATFORM}
  imageApplicationPath=${BUILD_DOCKER_PATH}
  imageName=${BUILD_DOCKER_IMAGE}

  exitCode=0
  envFiles=()
  extraArgs=()
  tempEnvs=()
  while [ $# -gt 0 ]; do
    arg="$1"
    if [ -z "$arg" ]; then
      "$fail" "$errorArgument" "Blank argument"
      return $?
    fi
    case "$arg" in
      --help)
        "$fail" 0
        return 0
        ;;
      --image)
        shift || "$fail" "$errorArgument" "Missing $arg" || return $?
        imageName="$1"
        ;;
      --path)
        shift || "$fail" "$errorArgument" "Missing $arg" || return $?
        imageApplicationPath="$1"
        ;;
      --env)
        shift || "$fail" "$errorArgument" "Missing $arg" || return $?
        if ! envFile=$(usageArgumentFile "$fail" "envFile" "$1"); then
          return $errorArgument
        fi
        if ! tempEnv=$(anyEnvToDockerEnv "$envFile"); then
          "$fail" "$errorArgument" "$arg $envFile unable to convert" || return $?
        fi
        tempEnvs+=("$tempEnv")
        envFiles+=("--env-file" "$tempEnv")
        ;;
      --platform)
        shift || "$fail" "$errorArgument" "Missing $arg" || return $?
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
    "$fail" "$errorArgument" "$failedWhy"
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
