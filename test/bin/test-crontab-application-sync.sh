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

# IDENTICAL __tools 17
# Usage: {fn} [ relative [ command ... ] ]
# Load build tools and run command
# Argument: relative - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  local source="${BASH_SOURCE[0]}" e=253
  local here="${source%/*}"
  local tools="$here/${1:-".."}/bin/build"
  [ -d "$tools" ] || _return $e "$tools is not a directory" || return $?
  tools="$tools/tools.sh"
  [ -x "$tools" ] || _return $e "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return $e source "$tools" "$@" || return $?
  shift
  [ $# -eq 0 ] && return 0
  "$@" || return $?
}

# IDENTICAL _return 19
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  _integer "$r" || _return 2 "${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() {
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# END of IDENTICAL _return

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

  __environment mkdir -p "$tempDir"/app1 || return $?
  __environment mkdir -p "$tempDir"/app2 || return $?
  __environment mkdir -p "$tempDir/app3/and/it/is/really/deep" || return $?

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
  cp "$tempDir"/app1/user.crontab "$tempDir/app3/and/it/is/really/deep/user.crontab"

  results=$(mktemp)
  __usageEnvironment "$usage" crontabApplicationUpdate --user user --show "$tempDir" --env "$testEnv" >>"$results" || return $?

  if test $showFlag; then
    cat "$results"
  fi
  if test $verboseFlag; then
    echo "Results file has $(($(wc -l <"$results") + 0)) lines"
  fi

  dumpPipe "Cron results" <"$results"
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
