#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: colors.sh text.sh
#
errorEnvironment=1

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
#
dotEnvConfigure() {
  if [ ! -f ./.env ]; then
    consoleError "Missing ./.env"
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
#
# Run a hook in the project located at ./bin/hooks/
#
# See (Hooks documentation)[docs/hooks.md] for available
#
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
# Run a hook but do not require it to exist
#
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
hasHook() {
  while [ $# -gt 0 ]; do
    if [ -x "$(whichHook "$1")" ]; then
      return 0
    fi
    shift
  done
  return 1
}

#
# Does a hook exist in the local project?
#
whichHook() {
  local binary=$1 paths=("./bin/hooks/" "./bin/build/hooks/") extensions=("" ".sh") p e
  for p in "${paths[@]}"; do
    for e in "${extensions[@]}"; do
      if [ -x "$p/$binary$e" ]; then
        echo "$p/$binary$e"
        return 0
      fi
      if [ -f "$p/$binary$e" ]; then
        consoleWarning "$p/$binary$e exists but is not executable and will be ignored"
      fi
    done
  done
}

#
# start=$(beginTiming)
# consoleInfo -n "Doing something really long ..."
# # that thing
# reportTiming "$start" Done
# non-`tools.sh`` replacement:
#
beginTiming() {
  echo "$(($(date +%s) + 0))"
}

#
# Outputs the timing in Magenta optionally prefixed by a message in green
#
# Usage: reportTiming "$startTime" outputText...
#
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

#
# Usage: buildFailed "$quietLog"
#
# Output the last parts of the quietLog to find the error
# returns non-zero so fails in `set -e` shells
#
buildFailed() {
  local quietLog=$1 bigLines=50 recentLines=3
  shift
  ___dumpLines $bigLines "$quietLog"
  echo
  consoleMagenta "BUILD FAILED"
  consoleMagenta "$(echoBar)"
  echo
  bigText Failed | prefixLines "$(consoleError)"
  echo
  ___dumpLines $recentLines "$quietLog"
  return 1
}

#
# vXXX.XXX.XXX
#
# for sort - -k 1.c,1 - the `c` is the 1-based character index, so 2 means skip the 1st character
#
# Odd you can't globally flip sort order with -r - that only works with non-keyed entries I assume
#
versionSort() {
  local r=
  if [ $# -gt 0 ]; then
    if [ "$1" = "-r" ]; then
      r=r
      shift
    else
      (
        exec 1>&2
        consoleError "Unknown argument: $1"
        echo
        consoleInfo "versionSort [ -r ] - sort versions"
      )
    fi
  fi
  sort -t . -k 1.2,1n$r -k 2,2n$r -k 3,3n$r
}

#
# Get the current IP address of the host
#
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

getApplicationDeployVersion() {
  local p=$1 value appChecksumFile=.deploy/APPLICATION_CHECKSUM

  if [ ! -d "$p" ]; then
    consoleError "$p is not a directory"
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
      echo "${!f-}"
    )
    if [ -n "$value" ]; then
      echo -n "$value"
      return 0
    fi
  done
  return 0
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

#   _   _           _
#  | | | |_ __   __| | ___
#  | | | | '_ \ / _` |/ _ \
#  | |_| | | | | (_| | (_) |
#   \___/|_| |_|\__,_|\___/
#
undoDeployApplication() {
  local deployHome versionName targetPackage previousChecksum

  deployHome=$1
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
#
# deployApplication deployHome deployVersion targetPackage applicationPath
#
# e.g.
#
# deployApplication /var/www/DEPLOY 10c2fab1 app.tar.gz /var/www/apps/cool-app
#
deployApplication() {
  local deployHome deployVersion applicationPath deployedApplicationPath
  local previousApplicationChecksum targetPackageFullPath me

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
      mkdir "$deployHome/$previousApplicationChecksum"
    fi
    if [ -d "$deployHome/$previousApplicationChecksum/app" ]; then
      rm -rf "$deployHome/$previousApplicationChecksum/app"
    fi
    cd "$deployHome"
    mv "$applicationPath" "$deployHome/$previousApplicationChecksum/app"
    mv "$deployedApplicationPath" "$applicationPath"
  fi
  cd "$applicationPath"
  runOptionalHook deploy-finish
  runOptionalHook maintenance off
  consoleSuccess "Completed"
}
