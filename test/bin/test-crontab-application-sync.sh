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
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL __source 21

# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Optional. Directory. Path to application root. Defaults to `..`
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: _return
# Security: source
# Exit Code: 253 - source failed to load (internal error)
# Exit Code: 0 - source loaded (and command succeeded)
# Exit Code: ? - All other codes are returned by the command itself
__source() {
  local here="${BASH_SOURCE[0]%/*}" e=253
  local source="$here/${2:-".."}/${1-}" && shift 2 || _return $e "missing source" || return $?
  [ -d "${source%/*}" ] || _return $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || _return $e "$source not an executable file" "$@" || return $?
  local a=("$@") && set --
  # shellcheck source=/dev/null
  source "$source" || _return $e source "$source" "$@" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  "${a[@]}" || return $?
}

# IDENTICAL __tools 8

# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: __source
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL _return 28

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - Required. UnsignedInteger. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output
# Exit Code: exitCode
# Requires: isUnsignedInteger printf _return
_return() {
  local to=1 icon="✅" code="${1:-1}" && shift 2>/dev/null
  isUnsignedInteger "$code" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer \"$code\"" "$@" || return $?
  [ "$code" -eq 0 ] || icon="❌ [$code]" && to=2
  printf -- "%s %s\n" "$icon" "${*-§}" 1>&"$to"
  return "$code"
}

# Test if an argument is an unsigned integer
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Usage: {fn} argument ...
# Exit Code: 0 - if it is an unsigned integer
# Exit Code: 1 - if it is not an unsigned integer
# Requires: _return
isUnsignedInteger() {
  [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
  case "${1#+}" in --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

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
  decorate pair 40 "Test application directory:" "$1"
  decorate pair 40 "Top environment file:" "$2"
}

# Argument: --show - Print the displayed test crontab file to stdout
# Argument: --verbose - Be verbose
# Argument: --keep - Do not delete artifacts when done, print created values
# Test script for
#
testCrontabApplicationSync() {
  local usage="_${FUNCNAME[0]}"
  local argument
  local verboseFlag keepFlag showFlag testEnv tempDir results

  testTools :

  verboseFlag=
  keepFlag=
  showFlag=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
    -v | --verbose)
      verboseFlag=1
      decorate info "Verbosity on" 1>&2
      ;;
    -k | --keep)
      keepFlag=1
      decorate warning "Keeping test artifacts" 1>&2
      ;;
    -s | --show)
      showFlag=1
      ;;
    *)
      [ -d "$argument" ] || __throwArgument "$usage" "No arguments" || return $?
      decorate info "Home is $argument"
      ;;
    esac
    shift || __throwArgument "$usage" "missing argument $(decorate label "$argument")" || return $?
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
  __catchEnvironment "$usage" crontabApplicationUpdate --user user --show "$tempDir" --env-file "$testEnv" >>"$results" || return $?

  if test $showFlag; then
    cat "$results"
  fi
  if test $verboseFlag; then
    local number
    number=$(fileLineCount "$results")
    echo "Results file has $number $(plural "$number" line lines)"
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
    __throwEnvironment "$usage" "Failed" || return $?
  else
    rm -rf "$tempDir"
    rm "$testEnv"
    rm "$results"
    if test $verboseFlag; then
      echo "Removed temporary files"
    fi
  fi
  decorate success Passed.
}
_testCrontabApplicationSync() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. testCrontabApplicationSync "$@"
