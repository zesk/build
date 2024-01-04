#!/bin/bash
#
# ╺┳╸┏━╸┏━┓╺┳╸   ┏━╸┏━┓┏━┓┏┓╻╺┳╸┏━┓┏┓    ┏━┓┏━┓┏━┓╻  ╻┏━╸┏━┓╺┳╸╻┏━┓┏┓╻   ┏━┓╻ ╻┏┓╻┏━╸ ┏━┓╻ ╻
#  ┃ ┣╸ ┗━┓ ┃ ╺━╸┃  ┣┳┛┃ ┃┃┗┫ ┃ ┣━┫┣┻┓╺━╸┣━┫┣━┛┣━┛┃  ┃┃  ┣━┫ ┃ ┃┃ ┃┃┗┫╺━╸┗━┓┗┳┛┃┗┫┃   ┗━┓┣━┫
#  ╹ ┗━╸┗━┛ ╹    ┗━╸╹┗╸┗━┛╹ ╹ ╹ ╹ ╹┗━┛   ╹ ╹╹  ╹  ┗━╸╹┗━╸╹ ╹ ╹ ╹┗━┛╹ ╹   ┗━┛ ╹ ╹ ╹┗━╸╹┗━┛╹ ╹
#
# Structure is:
#
# appPath/application1/.env
# appPath/application1/.env.local
# appPath/application1/etc/user.crontab
#
# Test the related script
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

errorEnvironment=1
errorArgument=2
me=$(basename "$0")
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

usageOptions() {
  echo "--show        Print the displayed test crontab file to stdout"
  echo "--verbose|-v  Be chatty"
  echo "--keep        Do not delete artifacts when done, print created values"
}
usage() {
  local rs
  rs=$1
  shift
  exec 1>&2
  if [ -n "$*" ]; then
    echo "$*"
    echo
  fi
  echo "$me [ -k | --keep ] [ -v | --verbose ] [ -s | --show ]" | usageGenerator
  echo
  consoleInfo "Test script for crontab-application-sync.sh"
  echo
  usageOptions | usageGenerator $(($(usageOptions | maximumFieldLength) + 2))
  echo
  exit "$rs"
}

verboseFlag=
keepFlag=
showFlag=
while [ $# -gt 0 ]; do
  case $1 in
    -v | --verbose)
      verboseFlag=1
      echo "Verbosity on" 1>&2
      ;;
    -k | --keep)
      keepFlag=1
      echo "Keeping test artifacts" 1>&2
      ;;
    -s | --show)
      showFlag=1
      ;;
    *)
      if [ -d "$1" ]; then
        echo "Home is $1"
      else
        usage $errorArgument "No arguments"
      fi
      ;;
  esac
  shift
done

testEnv=$(mktemp)
tempDir="$(dirname "$testEnv")/testApps$$"

printBasics() {
  echo "Test application directory: $tempDir"
  echo "Top environment file: $testEnv"
}

if test $verboseFlag; then
  printBasics
fi
{
  echo "FOO=top"
  echo "DOG=Chihuahua"
  echo "BAR=one"
  echo "APPLICATION_PATH=hello"
} >>"$testEnv"

mkdir -p "$tempDir"/app1
mkdir -p "$tempDir"/app2
mkdir -p "$tempDir"/app3

{
  echo "FOO=lover"
  echo "DOG=Chihuahua"
  echo "APPNAME=app1"
  echo "APPLICATION_PATH=world"
} >>"$tempDir/app1/.env"
{
  echo "FOO=not-foo"
  echo "APPLICATION_PATH=world"
} >>"$tempDir/app2/.env"
{
  echo "FOO=fighter"
  echo "APPNAME=app2"
  echo "APPLICATION_PATH=really"
} >>"$tempDir/app2/.env.local"
{
  echo "FOO=Three"
  echo "APPNAME=app3"
  echo "BAR=fomo"
  echo "APPLICATION_PATH=never-set"
} >>"$tempDir/app3/.env.local"

{
  echo "# {APPNAME} Crontab {BAR}"
  echo "* * * * * : {FOO}; {APPLICATION_PATH}/cron.sh {DOG} {BAR}"
  echo
} >>"$tempDir"/app1/user.crontab
cp "$tempDir"/app1/user.crontab "$tempDir"/app2/user.crontab
cp "$tempDir"/app1/user.crontab "$tempDir"/app3/user.crontab

results=$(mktemp)
./bin/build/ops/crontab-application-sync.sh --user user --show "$tempDir" --env "$testEnv" >>"$results"

if test $showFlag; then
  cat "$results"
fi
if test $verboseFlag; then
  echo "Results file has $(($(wc -l <"$results") + 0)) lines"
fi

# Sample output (delete first 2 characters on each line to remove comments)
#
# # app1 Crontab {BAR}
# * * * * * : lover; /var/folders/6r/r9y5y7f51q592kr56jyz4gh80000z_/T/testApps47204/app1/cron.sh Chihuahua {BAR}
#
# # app2 Crontab {BAR}
# * * * * * : fighter; /var/folders/6r/r9y5y7f51q592kr56jyz4gh80000z_/T/testApps47204/app2/cron.sh Chihuahua {BAR}
#
# # app3 Crontab fomo
# * * * * * : Three; /var/folders/6r/r9y5y7f51q592kr56jyz4gh80000z_/T/testApps47204/app3/cron.sh Chihuahua fomo
find_count() {
  local n found
  n=$1
  shift
  found=$(grep -c "$*" "$results" || :)
  if test $verboseFlag; then
    echo "found $n x $*"
  fi
  if [ "$found" -ne "$n" ]; then
    consoleError "Match $* should occur $n times, found $found"
    consoleError "$(echoBar)"
    prefixLines "$(consoleCode)" <"$results"
    exit "$errorEnvironment"
  fi
  return 0
}

# set -x
find_count 1 "lover"
find_count 1 "fighter"
find_count 1 "Three"
find_count 1 "app1 Crontab"
find_count 1 "app2 Crontab"
find_count 1 "app3 Crontab"
find_count 1 "app1/cron.sh Chihuahua"
find_count 1 "app2/cron.sh Chihuahua"
find_count 1 "app3/cron.sh Chihuahua"
find_count 3 "Chihuahua"
find_count 3 "$tempDir"
find_count 2 "fomo"
find_count 0 "{"
find_count 0 "}"

if test $keepFlag; then
  if ! test $verboseFlag; then
    if ! test $showFlag; then
      echo "============================================"
    fi
    printBasics
  fi
  exit "$errorEnvironment"
else
  rm -rf "$tempDir"
  rm "$testEnv"
  rm "$results"
  if test $verboseFlag; then
    echo "Removed temporary files"
  fi
fi
consoleSuccess Passed.
