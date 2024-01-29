#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh text.sh
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

###############################################################################
#
# ░█▀█░▀█▀░█▀█░█▀▀░█░░░▀█▀░█▀█░█▀▀
# ░█▀▀░░█░░█▀▀░█▀▀░█░░░░█░░█░█░█▀▀
# ░▀░░░▀▀▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
#
#------------------------------------------------------------------------------

#
# Usage: dotEnvConfigure
#
# Loads "./.env" which is the current project configuration file
# Also loads "./.env.local" if it exists
# Generally speaking - these are NAME=value files and should be parsable by
# bash and other languages.
# See: toDockerEnv
# Summary: Load `.env` and optional `.env.local` into bash context
#
# Requires the file `.env` to exist and is loaded via bash `source` and all variables are `export`ed in the current shell context.
#
# If `.env.local` exists, it is also loaded in a similar manner.
#
# The previous version of this function was `dotEnvConfig` and is now deprecated, and outputs a warning.
# Environment: Loads `./.env` and `./.env.local`, use with caution.
# Exit code: 1 - if `.env` does not exist; outputs an error
# Exit code: 0 - if files are loaded successfully
dotEnvConfigure() {
  if [ ! -f ./.env ]; then
    consoleError "Missing ./.env" 1>&2
    return $errorEnvironment
  fi

  set -a
  # shellcheck source=/dev/null
  . ./.env
  # shellcheck source=/dev/null
  [ -f ./.env.local ] && . ./.env.local
  set +a
}

dotEnvConfig() {
  consoleWarning "dotEnvConfig is DEPRECATED - use dotEnvConfigure instead" 1>&2
  dotEnvConfigure "$@"
}

# Run a hook in the project located at `./bin/hooks/`
#
# See (Hooks documentation)[../hooks/index.md] for available hooks.
#
# Summary: Run a project hook
# Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at `./bin/hooks/` and are named `hookName` with a `.sh` extension added.
# So the hook for `version-current` would be a file at:
#
#     bin/hooks/version-current.sh
#
# Sample hooks (scripts) can be found in the build source code at `./bin/hooks/`.
#
# Default hooks (scripts) can be found in `bin/build/hooks/`
#
# Usage: runHook hookName [ arguments ... ]
# Exit code: Any - The hook exit code is returned if it is run
# Exit code: 1 - is returned if the hook is not found
# Example:     version="$(runHook version-current)"
# Test: testHookSystem
runHook() {
  local binary=$1 hook

  shift
  hook=$(whichHook "$binary")
  if [ -z "$hook" ]; then
    consoleWarning "No hook for $binary with arguments: $*"
    return $errorEnvironment
  fi
  "$hook" "$@"
}

#
# See `runHook`, the behavior is identical except exit code zero is returned if the hook is not found..
#
# See (Hooks documentation)[../hooks/index.md] for available hooks.
#
# Summary: Run a hook if it exists otherwise succeed
# Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at `./bin/hooks/` and are named `hookName` with a `.sh` extension added.
# So the hook for `version-current` would be a file at:
#
#     bin/hooks/version-current.sh
#
# Sample hooks (scripts) can be found in the build source code at `./bin/hooks/`.
#
# Default hooks (scripts) can be found in `bin/build/hooks/`
#
# Usage: runOptionalHook hookName [ arguments ... ]
# Exit code: Any - The hook exit code is returned if it is run
# Exit code: 0 - is returned if the hook is not found
# Example:     if ! runOptionalHook test-cleanup >>"$quietLog"; then
# Example:         buildFailed "$quietLog"
# Example:     fi
# Test: testHookSystem
runOptionalHook() {
  local binary=$1 hook

  shift
  if ! hasHook "$binary"; then
    if buildDebugEnabled; then
      consoleWarning "No hook $binary in this project"
    fi
    return 0
  fi
  if buildDebugEnabled; then
    consoleSuccess "Running hook $binary $*"
  fi
  "$(whichHook "$binary")" "$@"
}

#
# Does a hook exist in the local project?
#
# Check if one or more hook exists. All hooks must exist to succeed.
# Summary: Determine if a hook exists
# Usage: hasHook [ hookName ... ]
# Argument: hookName - one or more hook names which must exist
# Exit Code: 0 - If all hooks exist
# Test: testHookSystem
hasHook() {
  local binary
  while [ $# -gt 0 ]; do
    if ! binary=$(whichHook "$1") || [ ! -x "$binary" ]; then
      return 1
    fi
    shift
  done
  return 0
}

#
# Summary: Find the path to a hook binary file
#
# Does a hook exist in the local project?
#
# Find the path to a hook. The search path is:
#
# - `./bin/hooks/`
# - `./bin/build/hooks/`
#
# If a file named `hookName` with the extension `.sh` is found which is executable, it is output.
# Usage: whichHook hookName
# Arguments: hookName - Hook to locate
#
# Test: testHookSystem
whichHook() {
  local binary=$1 paths=("./bin/hooks" "./bin/build/hooks") extensions=("" ".sh")
  local p e
  for p in "${paths[@]}"; do
    for e in "${extensions[@]}"; do
      if [ -x "${p%%/}/$binary$e" ]; then
        printf %s "${p%%/}/$binary$e"
        return 0
      fi
      if [ -f "$p/$binary$e" ]; then
        consoleWarning "$p/$binary$e exists but is not executable and will be ignored" 1>&2
      fi
    done
  done
  return 1
}

#
# start=$(beginTiming)
# consoleInfo -n "Doing something really long ..."
# # that thing
# reportTiming "$start" Done
# non-`tools.sh`` replacement:
#

#
# Summary: Start a timer for a section of the build
#
# Outputs the offset in seconds from January 1, 1970.
#
# Usage: beginTiming
# Example:     init=$(beginTiming)
# Example:     ...
# Example:     reportTiming "$init" "Completed in"
#
beginTiming() {
  echo "$(($(date +%s) + 0))"
}

# Outputs the timing in Magenta optionally prefixed by a message in green
#
# Usage: reportTiming "$startTime" outputText...
# Summary: Output the time elapsed
# Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message.
# Usage: reportTiming startOffset [ message ... ]
# Argument: startOffset - Unix timestamp seconds of start timestamp
# Argument: message - Any additional arguments are output before the elapsed value computed
# Exit code: 0 - Exits with exit code zero
# Example:    init=$(beginTiming)
# Example:    ...
# Example:    reportTiming "$init" "Deploy completed in"
reportTiming() {
  local start delta
  start=$1
  shift
  if [ -n "$*" ]; then
    consoleGreen -n "$* "
  fi
  delta=$(($(date +%s) - start))
  consoleBoldMagenta "$delta $(plural $delta second seconds)"
}

#
# Utility for buildFailed
#
___dumpLines() {
  local nLines=$1 quietLog=$2
  consoleError "$(echoBar)"
  echo "$(consoleInfo "$(consoleBold "$quietLog")")$(consoleBlack ": Last $nLines lines ...")"
  consoleError "$(echoBar)"
  tail -n "$nLines" "$quietLog" | prefixLines "$(consoleYellow)"
}

# Summary: Output debugging information when the build fails
#
# Outputs debugging information after build fails:
#
# - last 50 lines in build log
# - Failed message
# - last 3 lines in build log
#
# Usage: buildFailed logFile
# Argument: logFile - the most recent log from the current script
#
# Example:     quietLog="$(buildQuietLog "$me")"
# Example:     if ! ./bin/deploy.sh >>"$quietLog"; then
# Example:         consoleError "Deploy failed"
# Example:         buildFailed "$quietLog"
# Example:     fi
# Exit Code: 1 - Always fails
buildFailed() {
  local quietLog=$1 bigLines=50 recentLines=3
  shift
  printf "\n"
  ___dumpLines $bigLines "$quietLog"
  echo
  consoleMagenta "BUILD FAILED"
  consoleMagenta "$(echoBar)"
  echo
  bigText Failed | prefixLines "$(consoleError)"
  echo
  ___dumpLines $recentLines "$quietLog"
  return "$errorEnvironment"
}

# Summary: Sort versions in the format v0.0.0
#
# Sorts semantic versions prefixed with a `v` character; intended to be used as a pipe.
#
# vXXX.XXX.XXX
#
# for sort - -k 1.c,1 - the `c` is the 1-based character index, so 2 means skip the 1st character
#
# Odd you can't globally flip sort order with -r - that only works with non-keyed entries I assume
#
# Usage: versionSort [ -r ]
# Argument: -r - Reverse the sort order (optional)
# Example:    git tag | grep -e '^v[0-9.]*$' | versionSort
#
versionSort() {
  local r=
  if [ $# -gt 0 ]; then
    if [ "$1" = "-r" ]; then
      r=r
      shift
    else
      consoleError "Unknown argument: $1" 1>&2
      return "$errorArgument"
    fi
  fi
  sort -t . -k 1.2,1n$r -k 2,2n$r -k 3,3n$r
}

#
# Get the current IP address of the host
# Exit Code: 1 - Returns
ipLookup() {
  # Courtesy of Market Ruler, LLC thanks
  local default="https://www.conversionruler.com/showip/?json"
  if ! whichApt curl curl; then
    return 1
  fi
  curl -s "${IP_URL:-$default}"
}

#
# Usage: bigText [ --bigger ] Text to output
#
# smblock (regular)
#
# ▌  ▗   ▀▛▘     ▐
# ▛▀▖▄ ▞▀▌▌▞▀▖▚▗▘▜▀
# ▌ ▌▐ ▚▄▌▌▛▀ ▗▚ ▐ ▖
# ▀▀ ▀▘▗▄▘▘▝▀▘▘ ▘ ▀
#
# smmono12 (--bigger)
#
# ▗▖     █       ▗▄▄▄▖
# ▐▌     ▀       ▝▀█▀▘           ▐▌
# ▐▙█▙  ██   ▟█▟▌  █   ▟█▙ ▝█ █▘▐███
# ▐▛ ▜▌  █  ▐▛ ▜▌  █  ▐▙▄▟▌ ▐█▌  ▐▌
# ▐▌ ▐▌  █  ▐▌ ▐▌  █  ▐▛▀▀▘ ▗█▖  ▐▌
# ▐█▄█▘▗▄█▄▖▝█▄█▌  █  ▝█▄▄▌ ▟▀▙  ▐▙▄
# ▝▘▀▘ ▝▀▀▀▘ ▞▀▐▌  ▀   ▝▀▀ ▝▀ ▀▘  ▀▀
#         ▜█▛▘
#
bigText() {
  local font=smblock
  whichApt toilet toilet
  if [ "$1" = "--bigger" ]; then
    font=smmono12
    shift
  fi
  toilet -f $font "$@"
}

applicationEnvironment() {
  local hook

  # shellcheck source=/dev/null
  . "$(dirname "${BASH_SOURCE[0]}")/../env/BUILD_TIMESTAMP.sh"
  # shellcheck source=/dev/null
  . "$(dirname "${BASH_SOURCE[0]}")/../env/APPLICATION_BUILD_DATE.sh"
  # shellcheck source=/dev/null
  . "$(dirname "${BASH_SOURCE[0]}")/../env/APPLICATION_VERSION.sh"
  # shellcheck source=/dev/null
  . "$(dirname "${BASH_SOURCE[0]}")/../env/APPLICATION_ID.sh"
  # shellcheck source=/dev/null
  . "$(dirname "${BASH_SOURCE[0]}")/../env/APPLICATION_TAG.sh"

  if [ -z "${APPLICATION_VERSION-}" ]; then
    hook=version-current
    if ! APPLICATION_VERSION="$(runHook "$hook")"; then
      consoleError "$hook failed $?" 1>&2
      return "$errorEnvironment"
    fi
  fi
  if [ -z "${APPLICATION_ID-}" ]; then
    hook=application-id
    if ! APPLICATION_ID="$(runHook "$hook")"; then
      consoleError "$hook failed $?" 1>&2
      return "$errorEnvironment"
    fi
  fi
  if [ -z "${APPLICATION_TAG-}" ]; then
    hook=application-tag
    if ! APPLICATION_TAG="$(runHook "$hook")"; then
      consoleError "$hook failed $?" 1>&2
      return "$errorEnvironment"
    fi
  fi
  printf "%s " BUILD_TIMESTAMP APPLICATION_BUILD_DATE APPLICATION_VERSION APPLICATION_ID APPLICATION_TAG
}

showEnvironment() {
  local start missing e requireEnvironment buildEnvironment tempEnv

  export BUILD_TIMESTAMP
  export APPLICATION_BUILD_DATE
  export APPLICATION_VERSION
  export APPLICATION_ID
  export APPLICATION_TAG

  #
  # e.g.
  #
  # Email: SMTP_URL MAIL_SUPPORT MAIL_FROM TESTING_EMAIL TESTING_EMAIL_IMAP
  # Database: DSN
  # Amazon: AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
  #
  # Must be defined and non-empty to run this script

  tempEnv=$(mktemp)
  if ! applicationEnvironment >"$tempEnv"; then
    rm "$tempEnv" || :
    return "$errorEnvironment"
  fi
  read -r -a requireEnvironment <"$tempEnv" || :
  rm "$tempEnv" || :
  # Will be exported to the environment file, only if defined
  while [ $# -gt 0 ]; do
    case $1 in
      --)
        shift
        break
        ;;
      *)
        requireEnvironment+=("$1")
        ;;
    esac
    shift
  done
  buildEnvironment=("$@")

  printf "%s %s %s %s%s\n" "$(consoleInfo "Application")" "$(consoleMagenta "$APPLICATION_VERSION")" "$(consoleInfo "on")" "$(consoleBoldRed "$APPLICATION_BUILD_DATE")" "$(consoleInfo "...")"
  if buildDebugEnabled; then
    consoleNameValue 40 Checksum "$APPLICATION_ID"
    consoleNameValue 40 Tag "$APPLICATION_TAG"
    consoleNameValue 40 Timestamp "$BUILD_TIMESTAMP"
  fi
  missing=()
  for e in "${requireEnvironment[@]}"; do
    if [ -z "${!e:-}" ]; then
      printf "%s %s\n" "$(consoleLabel "$(alignRight 30 "$e")"):" "$(consoleError "** No value **")" 1>&2
      missing+=("$e")
    else
      echo "$(consoleLabel "$(alignRight 30 "$e")"):" "$(consoleValue "${!e}")"
    fi
  done
  for e in "${buildEnvironment[@]+"${buildEnvironment[@]}"}"; do
    if [ -z "${!e:-}" ]; then
      printf "%s %s\n" "$(consoleLabel "$(alignRight 30 "$e")"):" "$(consoleSuccess "** Blank **")" 1>&2
    else
      echo "$(consoleLabel "$(alignRight 30 "$e")"):" "$(consoleValue "${!e}")"
    fi
  done
  if [ ${#missing[@]} -gt 0 ]; then
    return "$errorEnvironment"
  fi
}

#
# Usage: {fn} [ requireEnv1 requireEnv2 requireEnv3 ... ] [ -- optionalEnv1 optionalEnv2 ] "
# Argument: requireEnv1 - Optional. One or more environment variables which should be non-blank and included in the `.env` file.
# Argument: optionalEnv1 - Optional. One or more environment variables which are included if blank or not
# Create environment file `.env` for build.
# Environment: APPLICATION_VERSION - reserved and set to `runHook version-current` if not set already
# Environment: APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL.
# Environment: APPLICATION_TAG - reserved and set to `runHook application-id`
# Environment: APPLICATION_ID - reserved and set to `runHook application-tag`
#
makeEnvironment() {
  local missing e requireEnvironment

  read -r -a requireEnvironment < <(applicationEnvironment) || :

  if ! showEnvironment "$@" >/dev/null; then
    _makeEnvironment "$errorEnvironment" "Missing values"
    showEnvironment 1>&2
    return "$errorEnvironment"
  fi

  while [ $# -gt 0 ]; do
    case $1 in
      --)
        shift
        break
        ;;
      *)
        requireEnvironment+=("$1")
        ;;
    esac
    shift
  done

  #==========================================================================================
  #
  # Generate an .env artifact
  #
  for e in "${requireEnvironment[@]}" "$@"; do
    if [ -n "${!e}" ]; then
      echo "$e=\"${!e//\"/\\\"}\""
    fi
  done
}
_makeEnvironment() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}


getApplicationDeployVersion() {
  local p=$1 value appChecksumFile=.deploy/APPLICATION_ID

  if [ ! -d "$p" ]; then
    consoleError "$p is not a directory" 1>&2
    return 1
  fi
  if [ -f "$p/$appChecksumFile" ]; then
    cat "$p/$appChecksumFile"
    return 0
  fi
  if [ ! -f "$p/.env" ]; then
    return 0
  fi
  for f in APPLICATION_ID APPLICATION_GIT_SHA; do
    # shellcheck source=/dev/null
    value=$(
      source "$p/.env"
      printf %s "${!f-}"
    )
    if [ -n "$value" ]; then
      printf %s "$value"
      return 0
    fi
  done
  return 1
}

#
# deployHasVersion deployHome versionName
#
deployHasVersion() {
  local deployHome versionName targetPackage
  deployHome=$1
  shift
  versionName=$1
  shift
  targetPackage=${1:-app.tar.gz}
  shift || :

  if [ ! -d "$deployHome" ]; then
    consoleError "No deployment home found: $deployHome" 1>&2
    return $errorEnvironment
  fi
  if [ ! -d "$deployHome/$versionName" ]; then
    return 1
  fi
  [ -f "$deployHome/$versionName/$targetPackage" ]
}

#
# deployPreviousVersion deployHome versionName
#
deployPreviousVersion() {
  local deployHome versionName targetPackage
  deployHome=$1
  shift
  versionName=$1

  if [ ! -d "$deployHome" ]; then
    consoleError "No $deployHome" 1>&2
    return 1
  fi
  if [ -f "$deployHome/$versionName.previous" ]; then
    cat "$deployHome/$versionName.previous"
  fi
}

#
# deployNextVersion deployHome versionName
#
deployNextVersion() {
  local deployHome versionName targetPackage
  deployHome=$1
  shift
  versionName=$1

  if [ ! -d "$deployHome" ]; then
    consoleError "No $deployHome" 1>&2
    return 1
  fi
  if [ -f "$deployHome/$versionName.next" ]; then
    cat "$deployHome/$versionName.next"
  else
    return 1
  fi
}

#      _   _           _
#     | | | |_ __   __| | ___
#     | | | | '_ \ / _` |/ _ \
#     | |_| | | | | (_| | (_) |
#      \___/|_| |_|\__,_|\___/
#
# Undo deploying an application from a deployment repository
#
# Usage: undoDeployApplication deployHome deployVersion targetPackage applicationPath
#
undoDeployApplication() {
  local deployHome versionName targetPackage previousChecksum

  deployHome=$1p
  shift
  versionName=$1
  shift
  targetPackage=$1
  shift
  applicationPath=$1
  shift

  if ! deployPreviousVersion "$deployHome" "$versionName" >/dev/null 1>&2; then
    consoleError "Unable to get previous checksum for $versionName"
    return $errorEnvironment
  fi
  previousChecksum=$(deployPreviousVersion "$deployHome" "$versionName")
  consoleInfo -n "Reverting installation $versionName -> $previousChecksum ... "

  deployApplication "$deployHome" "$previousChecksum" "$targetPackage" "$applicationPath"

  if ! runOptionalHook deploy-undo "$deployHome" "$versionName"; then
    consoleError "deploy-undo hook failed, continuing anyway"
  fi
  return 0

}

_unwindDeploy() {
  local deployedApplicationPath=$1

  shift
  consoleError "$*" 1>&2
  rm -rf "$deployedApplicationPath" || :
  return "$errorEnvironment"

}

#
# Deploy an application from a deployment repository
#
# Usage: deployApplication deployHome deployVersion targetPackage applicationPath
#
# Argument: deployHome - The deployment repository home
# Argument: deployVersion - The version to deploy
# Argument: targetPackage -
#
# Example: deployApplication /var/www/DEPLOY 10c2fab1 app.tar.gz /var/www/apps/cool-app
deployApplication() {
  local deployHome deployVersion applicationPath deployedApplicationPath
  local previousApplicationPath previousApplicationChecksum targetPackageFullPath exitCode=0

  deployHome=$1
  shift

  deployVersion=$1
  shift

  targetPackage=$1
  shift

  applicationPath=$1
  shift

  deployedApplicationPath="$deployHome/$deployVersion/app"

  previousApplicationChecksum=$(getApplicationDeployVersion "$applicationPath")
  if [ -n "$previousApplicationChecksum" ]; then
    previousApplicationChecksum=$(date '+%F_%H-%M')
  fi
  targetPackageFullPath="$deployHome/$deployVersion/$targetPackage"

  if [ ! -f "$targetPackageFullPath" ]; then
    consoleError "deployApplication: Missing target file $targetPackageFullPath" 1>&2
    return $errorEnvironment
  fi

  if [ ! -d "$applicationPath" ]; then
    consoleError "deployApplication: No application path found: $applicationPath" 1>&2
    return $errorEnvironment
  fi

  if [ ! -d "$deployedApplicationPath" ]; then
    mkdir "$deployedApplicationPath"
    if cd "$deployedApplicationPath"; then
      if ! tar xzf "$targetPackageFullPath"; then
        return $?
      fi
    else
      _unwindDeploy "$deployedApplicationPath" "cd $deployedApplicationPath failed"
      return $?
    fi
  fi

  deployVersion=$(getApplicationDeployVersion "$deployedApplicationPath")

  if [ "$deployVersion" != "$deployVersion" ]; then
    _unwindDeploy "$deployedApplicationPath" "Arg $deployVersion != Computed $deployVersion"
    return $?
  fi

  if [ -d "$applicationPath/bin/build" ] && [ -d "$applicationPath/bin/hooks" ]; then
    if cd "$applicationPath"; then
      if ! runOptionalHook maintenance on; then
        _unwindDeploy "$deployedApplicationPath" "Turning maintenance on in $applicationPath failed"
        return $?
      fi
      if ! cd "$deployedApplicationPath"; then
        _unwindDeploy "$deployedApplicationPath" "cd $deployedApplicationPath failed"
        return $?
      fi
    else
      _unwindDeploy "$deployedApplicationPath" "cd $applicationPath failed"
      return $?
    fi
  fi

  if [ -n "$previousApplicationChecksum" ]; then
    if [ ! -f "$deployHome/$deployVersion.previous" ] && [ ! -f "$deployHome/$previousApplicationChecksum.next" ]; then
      # Linked list forward only
      echo "$previousApplicationChecksum" >"$deployHome/$deployVersion.previous"
      echo "$deployVersion" >"$deployHome/$previousApplicationChecksum.next"
    fi
  fi

  consoleInfo -n "Setting to version $deployVersion ... "
  if ! cd "$deployedApplicationPath"; then
    _unwindDeploy "$deployedApplicationPath" "cd $deployedApplicationPath failed"
    return $?
  fi
  if ! runOptionalHook deploy-start "$applicationPath"; then
    _unwindDeploy "$deployedApplicationPath" "runOptionalHook deploy-start failed"
    return $?
  fi
  if hasHook deploy-move; then
    runHook deploy-move "$applicationPath"
  else
    if [ ! -d "$deployHome/$previousApplicationChecksum" ]; then
      if ! mkdir -p "$deployHome/$previousApplicationChecksum"; then
        _unwindDeploy "$deployedApplicationPath" "Unable to create deploy home/previous checksum \"$deployHome/$previousApplicationChecksum\""
        return $?
      fi
    fi
    previousApplicationPath="$deployHome/$previousApplicationChecksum/app/"
    if [ -d "$previousApplicationPath" ]; then
      if ! rm -rf "$previousApplicationPath"; then
        _unwindDeploy "$deployedApplicationPath" "Unable to delete \"$previousApplicationPath\""
        return $?
      fi
    fi
    if ! cd "$deployHome"; then
      _unwindDeploy "$deployedApplicationPath" "Unable to cd to \"$deployHome\""
      return $?
    fi
    # COPY is safest
    if ! cp -R "${applicationPath%%/}" "$previousApplicationPath"; then
      _unwindDeploy "$deployedApplicationPath" "Unable to copy \"$applicationPath\" \"$previousApplicationPath\"" 1>&2
      return "$errorEnvironment"
    fi
    if ! mv "$applicationPath" "$applicationPath.$$"; then
      _unwindDeploy "$deployedApplicationPath" "Unable to move $applicationPath to $applicationPath.$$"
      return $?
    fi
    if mv "$deployedApplicationPath" "$applicationPath"; then
      if ! rm -rf "$applicationPath.$$"; then
        consoleError "ERROR: Deleting $applicationPath.$$ resulted in exit code $?" 1>&2
      fi
    else
      consoleError "Unable to do FINAL mv \"$deployedApplicationPath\" \"$applicationPath\" attempting UNDO" 1>&2
      if ! mv "$applicationPath.$$" "$applicationPath"; then
        _unwindDeploy "$deployedApplicationPath" "Unable to UNDO FINAL mv \"$applicationPath.$$\" \"$applicationPath\", system is BROKEN"
      fi
      return "$errorEnvironment"
    fi
  fi
  if ! cd "$applicationPath"; then
    consoleError "$deployedApplicationPath" "Unable to do cd \"$applicationPath\" can not run optional hooks - UNSTABLE" 1>&2
    exitCode=$errorEnvironment
  fi
  if ! runOptionalHook deploy-finish; then
    consoleError "Deploy finish failed" 1>&2
    exitCode=$errorEnvironment
  fi
  if ! runOptionalHook maintenance off; then
    consoleError "maintenance off failed" 1>&2
    exitCode=$errorEnvironment
  fi
  consoleSuccess "Completed"
  return "$exitCode"
}

_remoteDeployFinishUsage() {
  usageDocument "bin/build/tools/pipeline.sh" remoteDeployFinish "$@"
  return $?
}

# This is run on the remote system after deployment; environment files are correct.
# It is run inside the deployment home directory in the new application folder.
#
# Current working directory on deploy is `deployHome/applicationId/app`.
# Current working directory on cleanup is `applicationHome/`
# Current working directory on undo is `applicationHome/`
#
# applicationId - Required. String. Should match APPLICATION_ID in .env
# deployPath - Required. String. Path where the deployments database is on remote system.
# applicationPath - Required. String. Path on the remote system where the application is live.
# --undo - Revert changes just made
# --cleanup - Cleanup after success
# --debug - Enable debugging. Defaults to `BUILD_DEBUG`
#
remoteDeployFinish() {
  local targetPackage undoFlag cleanupFlag applicationId applicationPath debuggingFlag start width

  if ! usageRequireBinary _remoteDeployFinishUsage git; then
    return $?
  fi

  if ! dotEnvConfigure; then
    consoleError "remoteDeployFinish: Unable to dotEnvConfigure" 1>&2
    return $?
  fi

  targetPackage=${BUILD_TARGET:-app.tar.gz}

  undoFlag=
  cleanupFlag=
  applicationId=
  applicationPath=
  debuggingFlag=
  while [ $# -gt 0 ]; do
    case $1 in
      --debug)
        debuggingFlag=1
        ;;
      --cleanup)
        cleanupFlag=1
        ;;
      --undo)
        undoFlag=1
        ;;
      *)
        if [ -z "$applicationId" ]; then
          applicationId=$1
        elif [ -z "$deployHome" ]; then
          deployHome=$1
        elif [ -z "$applicationPath" ]; then
          applicationPath=$1
          if [ ! -d "$applicationPath" ]; then
            if ! mkdir -p "$applicationPath"; then
              usage "$errorEnvironment" "Can not create $applicationPath"
            else
              consoleWarning "Created $applicationPath"
            fi
          fi
        else
          usage "$errorArgument" "Unknown parameter $1"
        fi
        ;;
    esac
    shift
  done

  if test "${BUILD_DEBUG-}"; then
    debuggingFlag=1
  fi
  if test "$debuggingFlag"; then
    consoleWarning "Debugging is enabled"
    set -x
  fi

  #   ____             _
  #  |  _ \  ___ _ __ | | ___  _   _
  #  | | | |/ _ \ '_ \| |/ _ \| | | |
  #  | |_| |  __/ |_) | | (_) | |_| |
  #  |____/ \___| .__/|_|\___/ \__, |
  #          |_|            |___/
  if test $undoFlag && test $cleanupFlag; then
    _remoteDeployFinishUsage "$errorArgument" "--cleanup and --undo are mutually exclusive"
  fi

  start=$(beginTiming)
  width=50
  consoleNameValue $width "Host:" "$(uname -n)"
  consoleNameValue $width "Deployment Path:" "$deployHome"
  consoleNameValue $width "Application path:" "$applicationPath"
  consoleNameValue $width "Application checksum:" "$applicationId"

  if test $cleanupFlag; then
    if ! cd "$applicationPath"; then
      consoleError "Unable to change directory to $applicationPath, exiting" 1>&2
      return $errorEnvironment
    fi
    consoleInfo -n "Cleaning up ..."
    if hasHook deploy-cleanup; then
      if ! runHook deploy-cleanup; then
        consoleError "Cleanup failed"
        return $errorEnvironment
      fi
    else
      printf "No %s hook in %s\n" "$(consoleInfo "deploy-cleanup")" "$(consoleCode "$applicationPath")"
    fi
  elif test $undoFlag; then
    undoDeployApplication "$deployHome" "$applicationId" "$targetPackage" "$applicationPath"
  else
    if [ -z "$applicationId" ]; then
      _remoteDeployFinishUsage "$errorArgument" "No argument applicationId passed"
    fi
    deployApplication "$deployHome" "$applicationId" "$targetPackage" "$applicationPath"
  fi
  reportTiming "$start" "Remote deployment finished in"
}
