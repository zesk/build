#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: colors.sh text.sh
#
errEnv=1

###############################################################################
#
# ░█▀█░▀█▀░█▀█░█▀▀░█░░░▀█▀░█▀█░█▀▀
# ░█▀▀░░█░░█▀▀░█▀▀░█░░░░█░░█░█░█▀▀
# ░▀░░░▀▀▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀
#
#------------------------------------------------------------------------------

#
# Usage: dotEnvConfig
#
# Loads "./.env" which is the current project configuration file
# Also loads "./.env.local" if it exists
# Generally speaking - these are NAME=value files and should be parsable by
# bash and other languages.
#
dotEnvConfig() {
  if [ ! -f ./.env ]; then
    usage $errEnv "Missing ./.env"
  fi

  set -a
  # shellcheck source=/dev/null
  . ./.env
  # shellcheck source=/dev/null
  [ -f ./.env.local ] && . ./.env.local
  set +a
}

#
# Run a hook in the project located at ./bin/hooks/
#
# See (Hooks documentation)[docs/hooks.md] for available
#
runHook() {
  local binary=$1

  shift
  if [ -x "./bin/hooks/$binary" ]; then
    "./bin/hooks/$binary" "$@"
  elif [ -x "./bin/hooks/$binary.sh" ]; then
    "./bin/hooks/$binary.sh" "$@"
  else
    consoleWarning "No hook for $binary with arguments: $*"
  fi
}

#
# Does a hook exist in the local project?
#
hasHook() {
  local binary=$1
  [ -x "./bin/hooks/$binary" ] || [ -x "./bin/hooks/$binary.sh" ]
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
# Simple get value of a variable from the bitbucket-pipelines.yml file
#
# Usage: getFromPipelineYML MARIADB_ROOT_PASSWORD
#
# Assumes cwd is application/project root
#
getFromPipelineYML() {
  local value

  value=$(grep "$1" bitbucket-pipelines.yml | awk '{ print $2 }')
  value=${value:=$2}

  echo -n "$value"
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
#            ▜█▛▘
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