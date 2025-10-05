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
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local os=linux chip
  case "$(uname -m)" in
  *arm*) chip=arm64 ;;
  *mips*) chip=mips64 ;;
  *x86* | *amd*) chip=amd64 ;;
  *) chip=default ;;
  esac
  printf -- "%s/%s" "$os" "$chip"
}
_dockerPlatformDefault() {
  true || dockerPlatformDefault --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Debugging, dumps the proc1file which is used to figure out if we
# are insideDocker or not; use this to confirm platform implementation
#
dumpDockerTestFile() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local proc1File=/proc/1/sched

  if [ -f "$proc1File" ]; then
    bigText $proc1File
    decorate magenta <"$proc1File"
  else
    decorate warning "Missing $proc1File"
  fi
}
_dumpDockerTestFile() {
  true || dumpDockerTestFile --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Are we inside a docker container right now?
#
# Return Code: 0 - Yes
# Return Code: 1 - No
#
# TODO: This changed 2023 ...
# Checked: 2025-07-09
# TODO: Write a test to check this date every oh, say, 3 months
insideDocker() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
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
_insideDocker() {
  true || insideDocker --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List the files which would be included in the docker image
dockerListContext() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf 'FROM scratch\nCOPY . /\n' | DOCKER_BUILDKIT=1 docker build -q -f- -o- . | tar t
}
_dockerListContext() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run a build container using given docker image.
#
# Runs ARM64 by default.
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: --image imageName - Optional. String. Docker image name to run. Defaults to `BUILD_DOCKER_IMAGE`.
# Argument: --path imageApplicationPath - Path. Docker image path to map to current directory. Defaults to `BUILD_DOCKER_PATH`.
# Argument: --platform platform - Optional. String. Platform to run (arm vs intel).
# Argument: --env-file envFile - Optional. File. One or more environment files which are suitable to load for docker; must be valid
# Argument: --env envVariable=envValue - Optional. File. One or more environment variables to set.
# Argument: extraArgs - Optional. Mixed. The first non-file argument to `{fn}` is passed directly through to `docker run` as arguments
# Return Code: 1 - If already inside docker, or the environment file passed is not valid
# Return Code: 0 - Success
# Return Code: Any - `docker run` error code is returned if non-zero
# Environment: BUILD_DOCKER_PLATFORM - Optional. Defaults to `linux/arm64`. Affects which image platform is used.
#
dockerLocalContainer() {
  local handler="_${FUNCNAME[0]}"
  local platform imageName imageApplicationPath
  local envFile envPair
  local tempEnv
  local failedWhy localPath=""

  export BUILD_DOCKER_PLATFORM BUILD_DOCKER_PATH BUILD_DOCKER_IMAGE

  returnCatch "$handler" buildEnvironmentLoad BUILD_DOCKER_PLATFORM BUILD_DOCKER_IMAGE BUILD_DOCKER_PATH || return $?

  platform=${BUILD_DOCKER_PLATFORM}
  imageApplicationPath=${BUILD_DOCKER_PATH}
  imageName=${BUILD_DOCKER_IMAGE}

  local exitCode=0 ee=() extraArgs=() tempEnvs=() verboseFlag=false envFiles=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || returnThrowArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --image) shift && imageName=$(usageArgumentString "$handler" "$argument" "${1-}") || return $? ;;
    --local) shift && localPath=$(usageArgumentDirectory "$handler" "$argument" "${1-}") || return $? ;;
    --verbose) verboseFlag=true ;;
    --path)
      shift
      imageApplicationPath=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      envFiles+=("-w" "$imageApplicationPath")
      ;;
    --env)
      shift
      envPair=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      if [ "${envPair#*=}" = "$envPair" ]; then
        decorate warning "$argument does not look like a variable: $(decorate error "$envPair")" 1>&2
      fi
      ee+=("$argument" "$envPair")
      ;;
    --env-file)
      shift
      envFile=$(usageArgumentFile "$handler" "envFile" "$1") || return $?
      tempEnv=$(fileTemporaryName "$handler") || return $?
      catchArgument "$handler" environmentFileToDocker "$envFile" >"$tempEnv" || return $?
      tempEnvs+=("$tempEnv")
      ee+=("$argument" "$tempEnv")
      ;;
    --platform) shift && platform=$(usageArgumentString "$handler" "$argument" "${1}") || return $? ;;
    *)
      extraArgs+=("$@")
      break
      ;;
    esac
    shift
  done
  [ -n "$platform" ] || platform=$(dockerPlatformDefault)

  if [ -z "$localPath" ]; then
    localPath=$(catchEnvironment "$handler" pwd) || return $?
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
    returnThrowEnvironment "$handler" "$failedWhy" || return $?
  fi
  local tt=()
  [ ! -t 0 ] || tt=(-it)
  if [ -z "$(dockerImages --filter "$imageName" 2>/dev/null || :)" ]; then
    ! $verboseFlag || statusMessage decorate info "Pulling $imageName ..."
    catchEnvironment "$handler" muzzle docker pull "$imageName" || return $?
  fi
  local start
  start=$(timingStart)
  ! $verboseFlag || statusMessage decorate info "Running $imageName on $platform ..."
  catchEnvironment "$handler" docker run "${ee[@]+"${ee[@]}"}" --platform "$platform" -v "$localPath:$imageApplicationPath" "${tt[@]+"${tt[@]}"}" --pull never "$imageName" "${extraArgs[@]+"${extraArgs[@]}"}" || exitCode=$?
  ! $verboseFlag || statusMessage timingReport "$start" "$imageName ($platform) completed in"
  [ ${#tempEnvs[@]} -eq 0 ] || rm -f "${tempEnvs[@]}" || :
  return $exitCode
}
_dockerLocalContainer() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List docker images which are currently pulled
# Argument: --filter reference - Optional. Filter list by reference provided.
dockerImages() {
  local handler="_${FUNCNAME[0]}"

  local filter=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || returnThrowArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --filter)
      shift
      [ 0 -eq "${#filter[@]}" ] || returnThrowArgument "$handler" "--filter passed twice: #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
      filter+=("--filter" "reference=$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      returnThrowArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  usageRequireBinary "$handler" docker || return $?

  # Do not use --format json as it is not backwards compatible
  docker images "${filter[@]+"${filter[@]}"}" | awk '{ print $1 ":" $2 }' | grep -v 'REPOSITORY:'
}
_dockerImages() {
  # __IDENTICAL__ usageDocument 1
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
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  [ $# -eq 1 ] || returnThrowArgument "$handler" "Requires a volume name" || return $?
  docker volume ls --format json | jq .Name | grep -q "$1"
}
_dockerVolumeExists() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Delete a docker volume
# Argument: name - String. Required. Volume name to delete.
dockerVolumeDelete() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  [ $# -eq 1 ] || returnThrowArgument "$handler" "Requires a volume name" || return $?
  docker volume ls --format json | jq .Name | grep -q "$1"
}
_dockerVolumeDelete() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__dockerVolumeDeleteInteractive() {
  local handler="$1" databaseVolume="$2" && shift 2

  local running=false suffix=""

  if dockerComposeIsRunning; then
    running=true
    suffix=" (container will also be shut down)"
  fi

  if dockerVolumeExists "$databaseVolume"; then
    if confirmYesNo --no --timeout 60 --info "Delete database volume $(decorate code "$databaseVolume")$suffix?"; then
      if $running; then
        statusMessage decorate info "Bringing down container ..."
        catchEnvironment "$handler" docker compose down --remove-orphans || return $?
      fi
      __dockerVolumeDelete "$handler" "$databaseVolume" || return $?
    fi
  fi
}

__dockerVolumeDelete() {
  local handler="$1" databaseVolume="$2" && shift 2

  catchEnvironment "$handler" docker volume rm "$databaseVolume" || return $?
}
