#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# bin: head grep
# Docs: contextOpen ./documentation/source/tools/docker.md
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

# Fetch the default platform for docker
# Outputs one of: `linux/arm64`, `linux/mips64`, `linux/amd64`
dockerPlatformDefault() {
  local os=linux chip
  case "$(uname -m)" in
  *arm*) chip=arm64 ;;
  *mips*) chip=mips64 ;;
  *x86* | *amd*) chip=amd64 ;;
  *) chip=default ;;
  esac
  printf -- "%s/%s" "$os" "$chip"
}

#
# Debugging, dumps the proc1file which is used to figure out if we
# are insideDocker or not; use this to confirm platform implementation
#
dumpDockerTestFile() {
  local proc1File=/proc/1/sched

  if [ -f "$proc1File" ]; then
    bigText $proc1File
    decorate magenta <"$proc1File"
  else
    decorate warning "Missing $proc1File"
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
# Takes any environment file and makes it compatible with BASH or Docker
#
# Outputs the compatible env to stdout
#
# Usage: {fn} filename [ ... ]
# Argument: handler - Function. Required. Error handler.
# Argument: passConvertFunction - Function. Required. Conversion function when `filename` is a Docker environment file.
# Argument: failConvertFunction - Function. Required. Conversion function when `filename` is a NOT a Docker environment file.
# Argument: filename - Optional. File. One or more files to convert.
# stdin: environment file
# stdout: bash-compatible environment statements
__anyEnvToFunctionEnv() {
  local usage="$1" passConvertFunction="$2" failConvertFunction="$3" && shift 3

  if [ $# -gt 0 ]; then
    local file
    for file in "$@"; do
      if checkDockerEnvFile "$file" 2>/dev/null; then
        # printf -- "%s\n" "checkDockerEnvFile=true" "converter=$passConvertFunction"
        __catchEnvironment "$usage" "$passConvertFunction" <"$file" || return $?
      else
        # printf -- "%s\n" "checkDockerEnvFile=\"false\"" "converter=\"$failConvertFunction\""
        __catchEnvironment "$usage" "$failConvertFunction" <"$file" || return $?
      fi
    done
  else
    local temp
    temp=$(fileTemporaryName "$usage") || return $?
    __catchEnvironment "$usage" muzzle tee "$temp" || return $?
    __catchEnvironment "$usage" __anyEnvToFunctionEnv "$usage" "$passConvertFunction" "$failConvertFunction" "$temp" || _clean $? "$temp" || return $?
    __catchEnvironment "$usage" rm "$temp" || return $?
    return 0
  fi
}

#
# Takes any environment file and makes it docker-compatible
#
# Outputs the compatible env to stdout
# Usage: {fn} envFile [ ... ]
# Argument: envFile - Required. File. One or more files to convert.
#
anyEnvToDockerEnv() {
  __anyEnvToFunctionEnv "_${FUNCNAME[0]}" bashCommentFilter dockerEnvFromBashEnv "$@" || return $?
}
_anyEnvToDockerEnv() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Takes any environment file and makes it bash-compatible
#
# Outputs the compatible env to stdout
#
# Usage: {fn} filename [ ... ]
# Argument: filename - Optional. File. One or more files to convert.
# stdin: environment file
# stdout: bash-compatible environment statements
anyEnvToBashEnv() {
  __anyEnvToFunctionEnv "_${FUNCNAME[0]}" dockerEnvToBash cat "$@" || return $?
}
_anyEnvToBashEnv() {
  # _IDENTICAL_ usageDocument 1
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
      [ -f "$file" ] || __throwArgument "$usage" "Not a file $file" || return $?
      _dockerEnvToBashPipe <"$file" || __throwArgument "$usage" "Invalid file: $file" || return $?
    done
  fi
}
_dockerEnvToBash() {
  # _IDENTICAL_ usageDocument 1
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
    case "$envLine" in
    [[:space:]]*[#]* | [#]* | "")
      # Comment line
      printf -- "%s\n" "$envLine"
      ;;
    *)
      name="${envLine%%=*}"
      value="${envLine#*=}"
      if [ -n "$name" ] && [ "$name" != "$envLine" ]; then
        if [ -z "$(printf -- "%s" "$name" | sed 's/^[A-Za-z][0-9A-Za-z_]*$//g')" ]; then
          printf -- "%s=\"%s\"\n" "$name" "$(escapeDoubleQuotes "$value")"
        else
          _argument "Invalid name at line $index: $name" || result=$?
        fi
      else
        _argument "Invalid line $index: $envLine" || result=$?
      fi
      ;;
    esac
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
  local file envLine tempFile clean=()

  tempFile=$(fileTemporaryName "$usage") || return $?
  clean=("$tempFile")
  if [ $# -eq 0 ]; then
    __catchEnvironment "$usage" muzzle tee "$tempFile.bash" || _clean $? "${clean[@]}" || return $?
    clean+=("$tempFile.bash")
    set -- "$tempFile.bash"
  fi
  for file in "$@"; do
    [ -f "$file" ] || __throwArgument "$usage" "Not a file $file" || _clean $? "${clean[@]}" || return $?
    env -i bash -c "set -eoua pipefail; source \"$file\"; declare -px; declare -pa" >"$tempFile" 2>&1 | outputTrigger --name "$file" || __throwArgument "$usage" "$file is not a valid bash file" || _clean $? "${clean[@]}" || return $?
  done
  while IFS='' read -r envLine; do
    local name=${envLine%%=*} value=${envLine#*=}
    printf -- "%s=%s\n" "$name" "$(unquote "\"" "$value")"
  done < <(removeFields 2 <"$tempFile" | grep -E -v '^(UID|OLDPWD|PWD|_|SHLVL|FUNCNAME|PIPESTATUS|DIRSTACK|GROUPS)\b|^(BASH_)' || :)
  __catchEnvironment "$usage" rm -rf "$tempFile" || return $?
}
_dockerEnvFromBashEnv() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

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
# Argument: --env-file envFile - Optional. File. One or more environment files which are suitable to load for docker; must be valid
# Argument: --env envVariable=envValue - Optional. File. One or more environment variables to set.
# Argument: extraArgs - Optional. Mixed. The first non-file argument to `{fn}` is passed directly through to `docker run` as arguments
# Exit Code: 1 - If already inside docker, or the environment file passed is not valid
# Exit Code: 0 - Success
# Exit Code: Any - `docker run` error code is returned if non-zero
# Environment: BUILD_DOCKER_PLATFORM - Optional. Defaults to `linux/arm64`. Affects which image platform is used.
#
dockerLocalContainer() {
  local usage="_${FUNCNAME[0]}"
  local platform imageName imageApplicationPath
  local envFile envPair
  local tempEnv
  local failedWhy localPath=""

  export BUILD_DOCKER_PLATFORM BUILD_DOCKER_PATH BUILD_DOCKER_IMAGE

  __catchEnvironment "$usage" buildEnvironmentLoad BUILD_DOCKER_PLATFORM BUILD_DOCKER_IMAGE BUILD_DOCKER_PATH || return $?

  platform=${BUILD_DOCKER_PLATFORM}
  imageApplicationPath=${BUILD_DOCKER_PATH}
  imageName=${BUILD_DOCKER_IMAGE}

  local exitCode=0 ee=() extraArgs=() tempEnvs=()

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
    --image)
      shift
      imageName=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      ;;
    --local)
      shift
      localPath=$(usageArgumentDirectory "$usage" "$argument" "${1-}") || return $?
      ;;
    --path)
      shift
      imageApplicationPath=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      envFiles+=("-w" "$imageApplicationPath")
      ;;
    --env)
      shift
      envPair=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      if [ "${envPair#*=}" = "$envPair" ]; then
        decorate warning "$argument does not look like a variable: $(decorate error "$envPair")" 1>&2
      fi
      ee+=("$argument" "$envPair")
      ;;
    --env-file)
      shift
      envFile=$(usageArgumentFile "$usage" "envFile" "$1") || return $?
      tempEnv=$(fileTemporaryName "$usage") || return $?
      __catchArgument "$usage" anyEnvToDockerEnv "$envFile" >"$tempEnv" || return $?
      tempEnvs+=("$tempEnv")
      ee+=("$argument" "$tempEnv")
      ;;
    --platform)
      shift
      platform=$(usageArgumentString "$usage" "$argument" "$1") || return $?
      ;;
    *)
      extraArgs+=("$1")
      ;;
    esac
    shift
  done
  [ -n "$platform" ] || platform=$(dockerPlatformDefault)

  if [ -z "$localPath" ]; then
    localPath=$(__catchEnvironment "$usage" pwd) || return $?
  fi
  failedWhy=
  if [ -z "$imageName" ]; then
    failedWhy="imageName is empty"
  elif [ -z "$imageApplicationPath" ]; then
    failedWhy="imageApplicationPath is empty"
  elif ! whichExists docker; then
    failedWhy="docker does not exist in path"
  fi
  if [ -n "$failedWhy" ]; then
    [ ${#tempEnvs[@]} -eq 0 ] || rm -f "${tempEnvs[@]}" || :
    __throwEnvironment "$usage" "$failedWhy" || return $?
  fi
  local tt=()
  [ ! -t 0 ] || tt=(-it)
  if [ -z "$(dockerImages --filter "$imageName")" ]; then
    __catchEnvironment "$usage" muzzle docker pull "$imageName" || return $?
  fi
  __catchEnvironment "$usage" docker run "${ee[@]+"${ee[@]}"}" --platform "$platform" -v "$localPath:$imageApplicationPath" "${tt[@]+"${tt[@]}"}" --pull never "$imageName" "${extraArgs[@]+"${extraArgs[@]}"}" || exitCode=$?
  [ ${#tempEnvs[@]} -eq 0 ] || rm -f "${tempEnvs[@]}" || :
  return $exitCode
}
_dockerLocalContainer() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List docker images which are currently pulled
# Argument: --filter reference - Optional. Filter list by reference provided.
dockerImages() {
  local usage="_${FUNCNAME[0]}"

  local filter=()

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
    --filter)
      shift
      [ 0 -eq "${#filter[@]}" ] || __throwArgument "$usage" "--filter passed twice: #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
      filter+=("--filter" "reference=$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  usageRequireBinary "$usage" docker || return $?

  # Do not use --format json as it is not backwards compatible
  docker images "${filter[@]+"${filter[@]}"}" | awk '{ print $1 ":" $2 }' | grep -v 'REPOSITORY:'
}
_dockerImages() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Old versions of docker or hosted:
#
# Usage:  docker images [OPTIONS] [REPOSITORY[:TAG]]
#
# List images
#
# Options:
#   -a, --all             Show all images (default hides intermediate images)
#       --digests         Show digests
#   -f, --filter filter   Filter output based on conditions provided
#       --format string   Pretty-print images using a Go template
#       --no-trunc        Don't truncate output
#   -q, --quiet           Only show image IDs

# Docker version 27.3.1, build ce12230
# Usage:  docker images [OPTIONS] [REPOSITORY[:TAG]]
#
# List images
#
# Aliases:
#   docker image ls, docker image list, docker images
#
# Options:
#   -a, --all             Show all images (default hides intermediate images)
#       --digests         Show digests
#   -f, --filter filter   Filter output based on conditions provided
#       --format string   Format output using a custom template:
#                         'table':            Print output in table format with column headers (default)
#                         'table TEMPLATE':   Print output in table format using the given Go template
#                         'json':             Print in JSON format
#                         'TEMPLATE':         Print output using the given Go template.
#                         Refer to https://docs.docker.com/go/formatting/ for more information about formatting
#                         output with templates
#       --no-trunc        Don't truncate output
#   -q, --quiet           Only show image IDs
#       --tree            List multi-platform images as a tree (EXPERIMENTAL)
#

## --------------------------------------------------------------------------------------------------------------------------------------------

# Does a docker volume exist with name?
# Argument: name - String. Required.
dockerVolumeExists() {
  local usage="_${FUNCNAME[0]}"
  __help "$usage" "$@" || return 0
  [ $# -eq 1 ] || __throwArgument "$usage" "Requires a volume name" || return $?
  docker volume ls --format json | jq .Name | grep -q "$1"
}
_dockerVolumeExists() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Does a docker volume exist with name?
# Argument: name - String. Required.
dockerVolumeDelete() {
  local usage="_${FUNCNAME[0]}"
  __help "$usage" "$@" || return 0
  [ $# -eq 1 ] || __throwArgument "$usage" "Requires a volume name" || return $?
  docker volume ls --format json | jq .Name | grep -q "$1"
}

__dockerVolumeDeleteInteractive() {
  local usage="$1" databaseVolume="$2" && shift 2

  local running=false suffix=""

  if dockerComposeIsRunning; then
    running=true
    suffix=" (container will also be shut down)"
  fi

  if dockerVolumeExists "$databaseVolume"; then
    if confirmYesNo --no --timeout 60 --info "Delete database volume $(decorate code "$databaseVolume")$suffix?"; then
      if $running; then
        statusMessage decorate info "Bringing down container ..."
        __catchEnvironment "$usage" docker compose down --remove-orphans || return $?
      fi
      __dockerVolumeDelete "$usage" "$databaseVolume" || return $?
    fi
  fi
}

__dockerVolumeDelete() {
  local usage="$1" databaseVolume="$2" && shift 2

  __catchEnvironment "$usage" docker volume rm "$databaseVolume" || return $?
}
