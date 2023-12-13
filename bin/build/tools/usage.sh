#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: colors.sh
# Docs: contextOpen ./docs/_templates/tools/usage.md

# IDENTICAL errorArgument 1
errorArgument=2

###############################################################################
#
# ▐▌ ▐▌▗▟██▖ ▟██▖ ▟█▟▌ ▟█▙
# ▐▌ ▐▌▐▙▄▖▘ ▘▄▟▌▐▛ ▜▌▐▙▄▟▌
# ▐▌ ▐▌ ▀▀█▖▗█▀▜▌▐▌ ▐▌▐▛▀▀▘
# ▐▙▄█▌▐▄▄▟▌▐▙▄█▌▝█▄█▌▝█▄▄▌
#  ▀▀▝▘ ▀▀▀  ▀▀▝▘ ▞▀▐▌ ▝▀▀
#              ▜█▛▘
#------------------------------------------------------------------------------
#
# Usage syntax is generally:
#
# Argument:
# - "-t" flag
# - "--flag" boolean on
# - "--flag args" with parameter
# - "--name=value" with equals for settings
#
# Description:
# - Required/Optional.
# - Data type: string, integer, date, etc.
# - Format: If any
# - Description
#
_usageOptionsSample() {
  echo "--download file|Required. String. File to download"
  echo "--target path|Optional. Integer. Place to download to."
}

#
# Overwrite this if your `usageOptions` uses a delimiter which is not a space
#
export usageDelimiter=${usageDelimiter-" "}

#
# Usage: usageWrapper [ exitCode [ message ... ] ]
#
# Description: Base case for usage, write your usage function as follows:
#
#  export usageDelimiter="|"
#  usageOptions() {
#      cat <<EOF
#  --help|This help
#  EOF
#  }
#  usage() {
#       usageMain "$me" "$@"
#  }
#
# Internal function to call `usage` depending on what's currently defined in the bash shell.
#
# - IFF `usage` is a function - pass through all arguments
# - IFF `usageOptions` is a function, use export `usageDelimiter` and `usageOptions` to generate default `usage`
# - IFF neither is defined, outputs a simple usage without options
#
usageWrapper() {
  if [ "$(type -t usage)" = "function" ]; then
    usage "$@"
  else
    usageMain "$@"
  fi
}

#
# Usage: usageMain binName [ exitCode [ message ... ] ]
#
# Description:
#
#       usageOptions() {
#            cat <<EOF
#       --help${usageDelimiter}This help
#       EOF
#       }
#       usageDescription() {
#            cat <<EOF
#       What I like to do when I run.
#       EOF
#       }
#       usage() {
#          usageMain "$me" "$@"
#       }
#
# - IFF `usageOptions` is a function, use export `usageDelimiter` and `usageOptions` to generate default `usage`
# - IFF neither is defined, outputs a simple usage without options.
#
usageMain() {
  local binName="${1-me}" exitCode="${2-0}" delimiter usageString

  usageString="$(consoleBoldRed Usage)"
  shift
  shift

  desc="No description"
  if [ "$(type -t usageDescription)" ]; then
    desc="$(usageDescription)"
  fi
  if [ "$(type -t usageOptions)" = "function" ]; then
    usageTemplate "$binName" "$(usageOptions)" "${usageDelimiter-' '}" "$desc" "$exitCode" "$*"
  else
    usageTemplate "$binName" "" "" "$desc" "$exitCode" "$*"
  fi
  return "$exitCode"
}

#
# Usage: usageTemplate binName options delimiter description exitCode message
#
# Output usage messages to console
#
# Should look into a actual file template, probably
#
usageTemplate() {
  local usageString binName options delimiter description exitCode

  binName="$1"
  shift || return "$errorArgument"
  options="$(printf "%s\n" "$1")"
  shift || return "$errorArgument"
  delimiter="$1"
  shift || return "$errorArgument"
  description="$1"
  shift || return "$errorArgument"
  exitCode="${1-0}"
  usageString="$(consoleBoldRed Usage)"
  shift || :

  exec 1>&2
  if [ ${#@} -gt 0 ]; then
    consoleError "$@"
    echo
  fi
  description=${description:-"No description"}
  nSpaces=$(printf %s "$options" | maximumFieldLength 1 "$delimiter")

  if [ -n "$delimiter" ] && [ -n "$options" ]; then
    printf "%s: %s%s\n\n%s\n\n%s\n\n" \
      "$usageString" \
      "$(consoleInfo -n "$binName")" \
      "$(printf %s "$options" | usageArguments "$delimiter")" \
      "$(printf %s "$options" | usageGenerator "$((nSpaces + 2))" "$delimiter" | prefixLines "    ")" \
      "$(consoleReset)$description"
  else
    printf "%s: %s\n\n%s\n\n" \
      "$usageString" \
      "$(consoleInfo "$binName")" \
      "$(consoleReset)$description"
    echo
  fi

  return "$exitCode"
}

#
# usageArguments delimiter
#
usageArguments() {
  local separatorChar="${1-" "}" requiredPrefix optionalPrefix argument lineTokens argDescription lastLine

  optionalPrefix=${2-"$(consoleBlue)"}
  requiredPrefix=${3-"$(consoleRed)"}

  lineTokens=()
  lastLine=
  while true; do
    if ! IFS="$separatorChar" read -r -a lineTokens; then
      lastLine=1
    fi
    if [ ${#lineTokens[@]} -gt 0 ]; then
      argument="${lineTokens[0]}"
      unset "lineTokens[0]"
      lineTokens=("${lineTokens[@]}")
      argDescription="${lineTokens[*]}"
      if [ "${argDescription%*equire*}" != "$argDescription" ]; then
        echo -n " $requiredPrefix$argument"
      else
        echo -n " $optionalPrefix""[ $argument ]"
      fi
    fi
    if test $lastLine; then
      break
    fi
  done
}

# Formats name value pairs separated by separatorChar (default " ") and uses
# $nSpaces width for first field
#
# usageGenerator nSpaces separatorChar labelPrefix valuePrefix < formatFile
#
# use with maximumFieldLength 1 to generate widths
#
usageGenerator() {
  local nSpaces=$((${1-30} + 0)) separatorChar=${2-" "} labelPrefix valuePrefix labelOptionalPrefix labelRequiredPrefix capsLine lastLine=

  labelOptionalPrefix=${3-"$(consoleBlue)"}
  labelRequiredPrefix=${4-"$(consoleRed)"}
  # shellcheck disable=SC2119
  valuePrefix=${5-"$(consoleValue)"}

  while true; do
    if ! IFS= read -r line; then
      lastLine=1
    fi
    capsLine="$(lowercase "$line")"
    if [ "${capsLine##*required}" != "$capsLine" ]; then
      labelPrefix=$labelRequiredPrefix
    else
      labelPrefix=$labelOptionalPrefix
    fi
    printf "%s\n" "$line" | awk "-F$separatorChar" "{ print \"$labelPrefix\" sprintf(\"%-\" $nSpaces \"s\", \$1) \"$valuePrefix\" substr(\$0, index(\$0, \"$separatorChar\") + 1) }"
    if test $lastLine; then
      break
    fi
  done

}

#
# Usage: usageEnvironment [ env0 ... ]
# Description: Requires environment variables to be set and non-blank
# Exit Codes: 1 - If any env0 variables bre not set or bre empty.
# Arguments: env0 string One or more environment variables which should be set and non-empty
#
usageEnvironment() {
  local e
  for e in "$@"; do
    if [ -z "${!e-}" ]; then
      usageWrapper 1 "Required $e not set"
      return 1
    fi
  done
}

#
# Usage: usageWhich [ binary0 ... ]
# Exit Codes: 1 - If any binary0 are not available within the current path
# Description: Requires the binaries to be found via `which`
# fails if not
#
usageWhich() {
  local b
  for b in "$@"; do
    if [ -z "$(which "$b")" ]; then
      usageWrapper 1 "$b is not available in path, not found: $PATH"
    fi
  done
}
