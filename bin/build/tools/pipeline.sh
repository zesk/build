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
    return $errEnv
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
  local binary=$1 hook

  shift
  hook=$(whichHook "$binary")
  if [ -z "$hook" ]; then
    consoleWarning "No hook for $binary with arguments: $*"
    return $errEnv
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
  [ -n "$(whichHook "$1")" ]
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
