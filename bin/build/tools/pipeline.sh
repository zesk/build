#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
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
  while [ $# -gt 0 ]; do
    if [ ! -x "$(whichHook "$1")" ]; then
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
  local binary=$1 paths=("./bin/hooks/" "./bin/build/hooks/") extensions=("" ".sh")
  local p e
  for p in "${paths[@]}"; do
    for e in "${extensions[@]}"; do
      if [ -x "$p/$binary$e" ]; then
        printf %s "$p/$binary$e"
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

_makeEnvironmentUsage() {
  usageDocument "./bin/build/tools/pipeline.sh" "makeEnvironment" "$@"
}

applicationEnvironment() {
  local hook

  export BUILD_TIMESTAMP
  export APPLICATION_BUILD_DATE
  export APPLICATION_VERSION
  export APPLICATION_CHECKSUM
  export APPLICATION_TAG

  BUILD_TIMESTAMP="$(date +%s)"
  APPLICATION_BUILD_DATE="$(date -u +"%Y-%m-%d %H:%M:%S")"

  if [ -z "${APPLICATION_VERSION-}" ]; then
    hook=version-current
    if ! APPLICATION_VERSION="$(runHook "$hook")"; then
      consoleError "$hook failed $?" 1>&2
      return "$errorEnvironment"
    fi
  fi
  if [ -z "${APPLICATION_CHECKSUM-}" ]; then
    hook=application-checksum
    if ! APPLICATION_CHECKSUM="$(runHook "$hook")"; then
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
  printf "%s " BUILD_TIMESTAMP APPLICATION_BUILD_DATE APPLICATION_VERSION APPLICATION_CHECKSUM APPLICATION_TAG
}

showEnvironment() {
  local start missing e requireEnvironment buildEnvironment tempEnv

  export BUILD_TIMESTAMP
  export APPLICATION_BUILD_DATE
  export APPLICATION_VERSION
  export APPLICATION_CHECKSUM
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
  read -r -a requireEnvironment < "$tempEnv" || :
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

  consoleInfo -n "Application #$APPLICATION_VERSION on $APPLICATION_BUILD_DATE ... "
  if buildDebugEnabled; then
    consoleMagenta -n "(checksum \"$APPLICATION_CHECKSUM\", tag \"$APPLICATION_TAG\", timestamp $BUILD_TIMESTAMP)"
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
  for e in "${buildEnvironment[@]}"; do
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
# fn: {base}
# Usage: {fn} [ requireEnv1 requireEnv2 requireEnv3 ... ] [ -- optionalEnv1 optionalEnv2 ] "
# Argument: requireEnv1 - Optional. One or more environment variables which should be non-blank and included in the `.env` file.
# Argument: optionalEnv1 - Optional. One or more environment variables which are included if blank or not
# Create environment file `.env` for build.
# Environment: APPLICATION_VERSION - reserved and set to `runHook version-current` if not set already
# Environment: APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL.
# Environment: APPLICATION_TAG - reserved and set to `runHook application-checksum`
# Environment: APPLICATION_CHECKSUM - reserved and set to `runHook application-tag`
#
makeEnvironment() {
  local missing e requireEnvironment

  read -r -a requireEnvironment < <(applicationEnvironment) || :

  if ! showEnvironment "$@" >/dev/null; then
    _makeEnvironmentUsage "$errorEnvironment" "Missing values"
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

getApplicationDeployVersion() {
  local p=$1 value appChecksumFile=.deploy/APPLICATION_CHECKSUM

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
  for f in APPLICATION_CHECKSUM APPLICATION_GIT_SHA; do
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
# Undo deplpying an application from a deployment repository
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

# Deploy an application from a deployment repository
#
# Usage: deployApplication deployHome deployVersion targetPackage applicationPath
#
# Argument: deployHome - The deplpoyment repository home
# Argument: deployVersion - The version to deploy
# Argument: targetPackage -
#
# Example: deployApplication /var/www/DEPLOY 10c2fab1 app.tar.gz /var/www/apps/cool-app
deployApplication() {
  local deployHome deployVersion applicationPath deployedApplicationPath
  local previousApplicationChecksum targetPackageFullPath me exitCode=0

  me="$(basename "$0")"
  set -e
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
    consoleError "$me: Missing target file $targetPackageFullPath" 1>&2
    return $errorEnvironment
  fi

  if [ ! -d "$applicationPath" ]; then
    consoleError "$me: No application path found: $applicationPath" 1>&2
    return $errorEnvironment
  fi

  if [ ! -d "$deployedApplicationPath" ]; then
    mkdir "$deployedApplicationPath"
    cd "$deployedApplicationPath"
    tar xzf "$targetPackageFullPath"
  fi

  deployVersion=$(getApplicationDeployVersion "$deployedApplicationPath")

  if [ "$deployVersion" != "$deployVersion" ]; then
    consoleError "Arg $deployVersion != Computed $deployVersion" 1>&2
    return 1
  fi

  if [ -d "$applicationPath/bin/build" ] && [ -d "$applicationPath/bin/hooks" ]; then
    cd "$applicationPath"
    runOptionalHook maintenance on
    cd "$deployedApplicationPath"
  fi

  if [ -n "$previousApplicationChecksum" ]; then
    if [ ! -f "$deployHome/$deployVersion.previous" ] && [ ! -f "$deployHome/$previousApplicationChecksum.next" ]; then
      # Linked list forward only
      echo "$previousApplicationChecksum" >"$deployHome/$deployVersion.previous"
      echo "$deployVersion" >"$deployHome/$previousApplicationChecksum.next"
    fi
  fi

  consoleInfo -n "Setting to version $deployVersion ... "

  cd "$deployedApplicationPath"
  runOptionalHook deploy-start "$applicationPath"
  if hasHook deploy-move; then
    runHook deploy-move "$applicationPath"
  else
    if [ ! -d "$deployHome/$previousApplicationChecksum" ]; then
      if ! mkdir -p "$deployHome/$previousApplicationChecksum"; then
        consoleError "Unable to create deploy home/previous checksum \"$deployHome/$previousApplicationChecksum\"" 1>&2
        return "$errorEnvironment"
      fi
    fi
    if [ -d "$deployHome/$previousApplicationChecksum/app" ]; then
      if ! rm -rf "$deployHome/$previousApplicationChecksum/app"; then
        consoleError "Unable to delete \"$deployHome/$previousApplicationChecksum/app\"" 1>&2
        return "$errorEnvironment"
      fi
    fi
    if ! cd "$deployHome"; then
      consoleError "Unable to cd to \"$deployHome\"" 1>&2
      return "$errorEnvironment"
    fi
    if ! mv "$applicationPath" "$deployHome/$previousApplicationChecksum/app"; then
      consoleError "Unable to move \"$applicationPath\" \"$deployHome/$previousApplicationChecksum/app\"" 1>&2
      return "$errorEnvironment"
    fi
    if ! mv "$deployedApplicationPath" "$applicationPath"; then
      consoleError "Unable to do FINAL mv \"$deployedApplicationPath\" \"$applicationPath\" attempting UNDO" 1>&2
      if ! mv "$deployHome/$previousApplicationChecksum/app" "$applicationPath"; then
        consoleError "Unable to UNDO FINAL mv \"$deployHome/$previousApplicationChecksum/app\" \"$applicationPath\", system is unstable" 1>&2
      fi
      return "$errorEnvironment"
    fi
  fi
  if ! cd "$applicationPath"; then
    consoleError "Unable to do cd \"$applicationPath\" can not run optional hooks - UNSTABLE" 1>&2
    return "$errorEnvironment"
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
