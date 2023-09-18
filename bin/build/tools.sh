#!/usr/bin/env bash
#
# Shell colors
#
# Usage: source ./bin/build/tools.sh
#
# Depends: -
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
errEnv=1

#
# Quote sed strings for shell use
#
quoteSedPattern() {
  echo -n "$1" | sed 's/\([\/.*+?]\)/\\\1/g'
}

consoleReset() {
  echo -en '\033[0m' # Reset
}

__consoleEscape() {
  local start=$1 end=$2 nl=1
  shift
  shift
  if [ -z "$*" ]; then
    echo -ne "$start"
  else
    if [ "$1" = "-n" ]; then
      nl=
      shift
    fi
    echo -ne "$start"
    echo -n "$@"
    echo -ne "$end"
    if test "$nl"; then
      echo
    fi
  fi
}

allColorTest() {
  local i j n

  i=0
  while [ $i -lt 11 ]; do
    j=0
    while [ $j -lt 10 ]; do
      n=$((10 * i + j))
      if [ $n -gt 108 ]; then
        break
      fi
      printf "\033[%dm %3d\033[m" $n $n
      j=$((j + 1))
    done
    echo
    i=$((i + 1))
  done
}

colorTest() {
  local i colors=(consoleRed consoleGreen consoleCyan consoleBlue consoleOrange
    consoleMagenta consoleBlack consoleWhite consoleBoldMagenta consoleUnderline
    consoleBold consoleRedBold consoleCode consoleWarning consoleSuccess
    consoleDecoration consoleError consoleLabel consoleValue)
  for i in "${colors[@]}"; do
    $i "$i: The quick brown fox jumped over the lazy dog."
  done
}

#
# Color-based
#
consoleRed() {
  __consoleEscape '\033[31m' '\033[0m' "$@"
}
consoleGreen() {
  __consoleEscape '\033[92m' '\033[0m' "$@"
}
consoleCyan() {
  __consoleEscape '\033[36m' '\033[0m' "$@"
}
consoleBlue() {
  __consoleEscape '\033[94m' '\033[0m' "$@"
}
consoleBlackBackground() {
  __consoleEscape '\033[48;5;0m' '\033[0m' "$@"
}
consoleYellow() {
  __consoleEscape '\033[48;5;16;38;5;11m' '\033[0m' "$@"
}
consoleOrange() {
  # see https://i.stack.imgur.com/KTSQa.png
  __consoleEscape '\033[38;5;214m' '\033[0m' "$@"
}
# shellcheck disable=SC2120
consoleMagenta() {
  __consoleEscape '\033[35m' '\033[0m' "$@"
}
consoleBlack() {
  __consoleEscape '\033[30m' '\033[0m' "$@"
}
consoleWhite() {
  __consoleEscape '\033[48;5;0;37m' '\033[0m' "$@"
}
consoleBoldMagenta() {
  __consoleEscape '\033[1m\033[35m' '\033[0m' "$@"
}
#
# Styles
#
consoleUnderline() {
  __consoleEscape '\033[4m' '\033[24m' "$@"
}
consoleBold() {
  __consoleEscape '\033[1m' '\033[21m' "$@"
}
consoleRedBold() {
  __consoleEscape '\033[31m' '\033[0m' "$@"
}
consoleNoBold() {
  echo -en '\033[21m'
}
consoleNoUnderline() {
  echo -en '\033[24m'
}
repeat() {
  local count=$((${1:-2} + 0))

  shift
  while [ $count -gt 0 ]; do
    echo -n "$*"
    count=$((count - 1))
  done
}
#
# Decoration
#
echoBar() {
  repeat 80 =
}
prefixLines() {
  local prefix=$1 awkLine
  shift
  awkLine="{ print \"$prefix\"\$0 }"
  awk "$awkLine"
}

#
# Semantics-based
#

#
# info
#
consoleInfo() {
  consoleCyan "$@"
}
#
# code or variables in output
#
consoleCode() {
  consoleYellow "$@"
}
#
# warning things are not normal
#
consoleWarning() {
  consoleOrange "$@"
}
#
# things went well
#
consoleSuccess() {
  consoleGreen "$@"
}
#
# decorations to output (like bars and lines)
#
# shellcheck disable=SC2120
consoleDecoration() {
  consoleBoldMagenta "$@"
}
#
# things went poorly
#
consoleError() {
  __consoleEscape '\033[1;31m' '\033[0m' "$@"
}
#
# Name/Value pairs
#
consoleLabel() {
  consoleOrange "$@"
}
#
# Name/Value pairs
#
consoleValue() {
  consoleMagenta "$@"
}

#
# consoleNameValue characterWidth name value...
#
consoleNameValue() {
  local characterWidth=$1 name=$2
  shift
  shift
  echo "$(alignRight "$characterWidth" "$(consoleLabel -n "$name")") $(consoleValue -n "$@")"
}

maximumFieldLength() {
  local index=$((${1-1} + 0)) separatorChar=${2-\;}

  awk "-F$separatorChar" "{ print length(\$$index) }" | sort -rn | head -1
}

#
# Formats name value pairs separated by semicolon and uses $nSpaces width for first field
#
# usageGenerator nSpaces separatorChar < formatFile
#
usageGenerator() {
  local labelPrefix valuePrefix nSpaces=$((${1-30} + 0)) separatorChar=${2-\;}

  labelPrefix="$(consoleLabel)"
  # shellcheck disable=SC2119
  valuePrefix="$(consoleDecoration)"

  awk "-F$separatorChar" "{ print \"$labelPrefix\" sprintf(\"%-\" $nSpaces \"s\", \$1) \"$valuePrefix\" substr(\$0, index(\$0, \"$separatorChar\") + 1) }"
}

#
# Requires environment variables to be set and non-blank
#
usageEnvironment() {
  set +u
  for e in "$@"; do
    if [ -z "${!e}" ]; then
      usage $errEnv "Required $e not set"
      return "$errEnv"
    fi
  done
  set -u
}

#
# Requires the binaries to be found in the $PATH variable
# fails if not
#
usageWhich() {
  for b in "$@"; do
    if [ -z "$(which "$b")" ]; then
      usage "$errEnv" "$b is not available in path, not found: $PATH"
      return "$errEnv"
    fi
  done
}

#
# Converts a date (YYYY-MM-DD) to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)
#
# dateToFormat 2023-04-20 %s 1681948800
#
dateToFormat() {
  if date --version 2>/dev/null 1>&2; then
    date -u --date="$1 00:00:00" "+$2" 2>/dev/null
  else
    date -u -jf '%F %T' "$1 00:00:00" "+$2" 2>/dev/null
  fi
}

#
# Converts a date to an integer timestamp
#
dateToTimestamp() {
  dateToFormat "$1" %s
}

aptUpdateOnce() {
  local older name quietLog start

  quietLog=./.build/apt-get-update.log
  requireFileDirectory "$quietLog"
  name=./.build/.apt-update
  # once an hour, technically
  older=$(find .build -name .apt-update -mmin +60)
  if [ -n "$older" ]; then
    rm -rf "$older"
  fi
  if [ ! -f "$name" ]; then
    if [ -z "$(which apt-get)" ]; then
      consoleError "No apt-get available" 1>&2
      return $errEnv
    fi
    start=$(beginTiming)
    consoleInfo -n "apt-get update ... "
    if ! DEBIAN_FRONTEND=noninteractive apt-get update -y >"$quietLog" 2>&1; then
      buildFailed "$quietLog"
    fi
    reportTiming "$start" OK
    date >"$name"
  fi
}

#
# Given a list of files, ensure their parent directories exist
#
requireFileDirectory() {
  local name
  while [ $# -gt 0 ]; do
    name="$(dirname "$1")"
    [ -d "$name" ] || mkdir -p "$name"
    shift
  done
}

#
# whichApt binary aptInstallPackage
#
# Installs an apt package if a binary does not exist in the which path
#
# The assuption here is that aptInstallPackage will install the desired binary
#
whichApt() {
  local binary=$1 quietLog
  shift
  if ! which "$binary" >/dev/null; then
    if aptUpdateOnce; then
      quietLog="./.build/apt.log"
      requireFileDirectory "$quietLog"
      if ! DEBIAN_FRONTEND=noninteractive apt-get install -y "$@" >>"$quietLog" 2>&1; then
        consoleError "Unable to install" "$@"
        buildFailed "$quietLog"
      fi
      if which "$binary" >/dev/null; then
        return 0
      fi
      consoleError "Apt packages $* do not add $binary to the PATH $PATH"
      buildFailed "$quietLog"
    fi
  fi
}

# ▗▖     █       ▗▄▄▄▖
# ▐▌     ▀       ▝▀█▀▘           ▐▌
# ▐▙█▙  ██   ▟█▟▌  █   ▟█▙ ▝█ █▘▐███
# ▐▛ ▜▌  █  ▐▛ ▜▌  █  ▐▙▄▟▌ ▐█▌  ▐▌
# ▐▌ ▐▌  █  ▐▌ ▐▌  █  ▐▛▀▀▘ ▗█▖  ▐▌
# ▐█▄█▘▗▄█▄▖▝█▄█▌  █  ▝█▄▄▌ ▟▀▙  ▐▙▄
# ▝▘▀▘ ▝▀▀▀▘ ▞▀▐▌  ▀   ▝▀▀ ▝▀ ▀▘  ▀▀
#            ▜█▛▘
bigText() {
  whichApt toilet toilet
  toilet -f smmono12 "$@"
}

___dumpLines() {
  local nLines=$1 quietLog=$2
  consoleError "$(echoBar)"
  echo "$(consoleInfo "$(consoleBold "$quietLog")")$(consoleBlack ": Last $nLines lines ...")"
  consoleError "$(echoBar)"
  tail -n "$nLines" "$quietLog" | prefixLines "$(consoleYellow)"
}

#
# x "$quietLog"
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
  return "$errEnv"
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
# Usage: plural number singular plural
#
# Sample:
#
# count=$(($(wc -l < $foxSightings) + 0))
# echo "We saw $count $(plural $count fox foxes)."
#
plural() {
  if [ "$(($1 + 0))" -eq 1 ]; then
    echo "$2"
  else
    echo "$3"
  fi
}

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
# alignRight "$characterSize" "string to align"
#
alignRight() {
  local n=$(($1 + 0))
  shift
  printf "%${n}s" "$*"
}

#
# alignLeft "$characterSize" "string to align"
#
alignLeft() {
  local n=$(($1 + 0))
  shift
  printf "%-${n}s" "$*"
}

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
# Install docker PHP extensions
#
# TODO not used anywhere
#
dockerPHPExtensions() {
  local start
  start=$(beginTiming)
  consoleInfo -n "Installing PHP extensions ... "
  [ -d "./.build" ] || mkdir -p "./.build"
  docker-php-ext-install mysqli pcntl calendar >>"./.build/docker-php-ext-install.log"
  reportTiming "$start" Done
}

#
# Get the current IP address of the host
#
ipLookup() {
  # Courtesy of Market Ruler, LLC thanks
  local default="https://www.conversionruler.com/showip/?json"
  if ! whichApt curl curl; then
    return $errEnv
  fi
  curl -s "${IP_URL:-$default}"
}

#
# Get the credentials file path, optionally outputting errors
#
awsCredentialsFile() {
  local credentials=$HOME/.aws/credentials verbose=${1-}

  if [ ! -d "$HOME" ]; then
    if test "$verbose"; then
      consoleWarning "No $HOME directory found" 1>&2
    fi
    return $errEnv
  fi
  if [ ! -f "$credentials" ]; then
    if test "$verbose"; then
      consoleWarning "No $credentials file found" 1>&2
    fi
    return $errEnv
  fi
  echo "$credentials"
}

#
# For security we gotta update our keys every 90 days
#
# This value would be better encrypted and tied to the AWS_ACCESS_KEY_ID so developers
# can not just update the value to avoid the security issue.
#
isAWSKeyUpToDate() {
  local upToDateDays=${1:-90} accessKeyTimestamp todayTimestamp deltaDays maxDays daysAgo pluralDays

  if [ -z "${AWS_ACCESS_KEY_DATE:-}" ]; then
    return 1
  fi
  shift
  maxDays=366
  upToDateDays=$((upToDateDays + 0))
  if [ $upToDateDays -gt $maxDays ]; then
    consoleError "isAWSKeyUpToDate $upToDateDays - values not allowed greater than $maxDays" 1>&2
    return 1
  fi
  if [ $upToDateDays -le 0 ]; then
    consoleError "isAWSKeyUpToDate $upToDateDays - negative or zero values not allowed" 1>&2
    return 1
  fi
  if ! dateToTimestamp "$AWS_ACCESS_KEY_DATE" >/dev/null; then
    consoleError "Invalid date $AWS_ACCESS_KEY_DATE" 1>&2
    return 1
  fi
  accessKeyTimestamp=$(($(dateToTimestamp "$AWS_ACCESS_KEY_DATE") + 0))

  todayTimestamp=$(($(date +%s) + 0))
  deltaDays=$(((todayTimestamp - accessKeyTimestamp) / 86400))
  daysAgo=$((deltaDays - upToDateDays))
  if [ $daysAgo -gt 0 ]; then
    pluralDays=$(plural $daysAgo day days)
    consoleError "Access key expired $AWS_ACCESS_KEY_DATE, $daysAgo $pluralDays" 1>&2
    return 1
  fi
  daysAgo=$((-daysAgo))
  pluralDays=$(plural $daysAgo day days)
  if [ $daysAgo -lt 14 ]; then
    bigText "$daysAgo $pluralDays" | prefixLines "$(consoleError)"
  fi
  if [ $daysAgo -lt 30 ]; then
    consoleWarning "Access key expires on $AWS_ACCESS_KEY_DATE, in $daysAgo $pluralDays"
    return 0
  fi
  return 0
}
#
# Exits successfully if either AWS_ACCESS_KEY_ID or AWS_SECRET_ACCESS_KEY is blank
#
needAWSEnvironment() {
  if [ -z ${AWS_ACCESS_KEY_ID+x} ] || [ -z ${AWS_SECRET_ACCESS_KEY+x} ]; then
    return 0
  fi
  return 1
}

#
# Usage: awsEnvironment groupName
#
# Output the AWS credentials extracted for groupName
#
awsEnvironment() {
  local credentials groupName=${1:-default} aws_access_key_id aws_secret_access_key

  if awsCredentialsFile 1 >/dev/null; then
    credentials=$(awsCredentialsFile)
    eval "$(awk -F= '/\[/{prefix=$0; next} $1 {print prefix " " $0}' "$credentials" | grep "\[$groupName\]" | awk '{ print $2 $3 $4 }' OFS='')"
    if [ -n "${aws_access_key_id:-}" ] && [ -n "${aws_secret_access_key:-}" ]; then
      echo AWS_ACCESS_KEY_ID="${aws_access_key_id}"
      echo AWS_SECRET_ACCESS_KEY="$aws_secret_access_key"
      return 0
    fi
  fi
  return $errEnv
}

#
# Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"
# Delete the old tag as well
#
veeGitTag() {
  local t="$1"

  if [ "$t" != "${t##v}" ]; then
    consoleRed "Tag is already veed: $t" 1>&2
    return 1
  fi
  git tag "v$t" "$t"
  git tag -d "$t"
  git push origin "v$t" ":$t"
  git fetch -q --prune --prune-tags
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
#  urlParse url
#
urlParse() {
  local url=$1 name user password host

  name=${url##*/}

  user=${url##*://}
  user=${user%%:*}

  password=${url%%@*}
  password=${password##*:}

  host=${url##*@}
  host=${host%%/*}

  port=${host##*:}
  if [ "$port" = "$host" ]; then
    port=
  fi
  host=${host%%:*}

  echo "url=$url"
  echo "name=$name"
  echo "user=$user"
  echo "password=$password"
  echo "host=$host"
  echo "port=$port"
}

#
#  urlParseItem url name
#
urlParseItem() {
  local name user password host
  eval "$(parseDSN "$1")"
  echo "${!2}"
}

#
# Platform agnostic tar cfz which ignores owner and attributes
#
createTarFile() {
  local target=$1

  shift
  if tar --version | grep -q GNU; then
    # GNU
    # > tar --version
    # tar (GNU tar) 1.34
    # ...
    tar czf "$target" --owner=0 --group=0 --no-xattrs "$@"
  else
    # BSD
    # > tar --version
    # bsdtar 3.5.3 - libarchive 3.5.3 zlib/1.2.11 liblzma/5.0.5 bz2lib/1.0.8
    tar czf "$target" --uid 0 --gid 0 --no-xattrs "$@"
  fi
}
