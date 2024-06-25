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

# IDENTICAL __tools 16
# Load tools.sh and run command
__tools() {
  local relative="$1"
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}"
  shift && set -eou pipefail
  local tools="$here/$relative/bin/build/tools.sh"
  [ -x "$tools" ] || _return 97 "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return 42 source "$tools" "$@" || return $?
  "$@" || return $?
}

# IDENTICAL _return 8
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}"
  shift
  printf "%s ❌ (%d)\n" "${*-§}" "$code" 1>&2
  return "$code"
}

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
  local n found results
  n=$1
  shift
  results=$1
  shift
  found=$(grep -c "$*" "$results" || :)
  if [ "$found" -ne "$n" ]; then
    dumpPipe RESULTS <"$results"
    _environment "Match $* should occur $n times, found $found" || return $?
  fi
  return 0
}
printBasics() {
  consoleNameValue 40 "Test application directory:" "$1"
  consoleNameValue 40 "Top environment file:" "$2"
}

# Argument: --show - Print the displayed test crontab file to stdout
# Argument: --verbose - Be verbose
# Argument: --keep - Do not delete artifacts when done, print created values
# Test script for crontab-application-sync.sh"
#
testCrontabApplicationSync() {
  local usage="_${FUNCNAME[0]}"
  local argument
  local verboseFlag keepFlag showFlag testEnv tempDir results

  verboseFlag=
  keepFlag=
  showFlag=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      -v | --verbose)
        verboseFlag=1
        consoleInfo "Verbosity on" 1>&2
        ;;
      -k | --keep)
        keepFlag=1
        consoleWarning "Keeping test artifacts" 1>&2
        ;;
      -s | --show)
        showFlag=1
        ;;
      *)
        [ -d "$argument" ] || __failArgument "$usage" "No arguments" || return $?
        consoleInfo "Home is $argument"
        ;;
    esac
    shift || __failArgument "$usage" "missing argument $(consoleLabel "$argument")" || return $?
  done

  testEnv=$(mktemp)
  tempDir="$(dirname "$testEnv")/testApps$$"

  if test $verboseFlag; then
    printBasics "$tempDir" "$testEnv"
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
  __usageEnvironment "$usage" ./bin/build/ops/crontab-application-sync.sh --user user --show "$tempDir" --env "$testEnv" >>"$results" || return $?

  if test $showFlag; then
    cat "$results"
  fi
  if test $verboseFlag; then
    echo "Results file has $(($(wc -l <"$results") + 0)) lines"
  fi

  # set -x
  find_count 1 "$results" "lover" || return $?
  find_count 1 "$results" "fighter" || return $?
  find_count 1 "$results" "Three" || return $?
  find_count 1 "$results" "app1 Crontab" || return $?
  find_count 1 "$results" "app2 Crontab" || return $?
  find_count 1 "$results" "app3 Crontab" || return $?
  find_count 1 "$results" "app1/cron.sh Chihuahua" || return $?
  find_count 1 "$results" "app2/cron.sh Chihuahua" || return $?
  find_count 1 "$results" "app3/cron.sh Chihuahua" || return $?
  find_count 3 "$results" "Chihuahua" || return $?
  find_count 3 "$results" "$tempDir" || return $?
  find_count 2 "$results" "fomo" || return $?
  find_count 0 "$results" "{" || return $?
  find_count 0 "$results" "}" || return $?

  if test $keepFlag; then
    if ! test $verboseFlag; then
      if ! test $showFlag; then
        echo "============================================"
      fi
      printBasics "$tempDir" "$testEnv"
    fi
    __failEnvironment "$usage" "Failed" || return $?
  else
    rm -rf "$tempDir"
    rm "$testEnv"
    rm "$results"
    if test $verboseFlag; then
      echo "Removed temporary files"
    fi
  fi
  consoleSuccess Passed.
}
_testCrontabApplicationSync() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. testCrontabApplicationSync "$@"
