#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/platform.md
# Test: o ./test/tools/platform-tests.sh

# Argument: count - The number of times to run the binary
# Argument: binary - The binary to run
# Argument: args ... - Any arguments to pass to the binary each run
# Return Code: 0 - success
# Return Code: 2 - `count` is not an unsigned number
# Return Code: Any - If `binary` fails, the exit code is returned
# Summary: Run a binary count times
runCount() {
  local handler="_${FUNCNAME[0]}"

  local total=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      if [ -z "$total" ]; then
        isUnsignedInteger "$argument" || throwArgument "$handler" "$argument must be a positive integer" || return $?
        total="$argument"
      else
        local index=0
        while [ "$index" -lt "$total" ]; do
          index=$((index + 1))
          "$@" || throwEnvironment "$handler" "iteration #$index" "$@" return $?
        done
        return 0
      fi
      ;;
    esac
    shift || throwArgument "$handler" shift || return $?
  done

}
_runCount() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL fileReverseLines 18

# Reverses a pipe's input lines to output using an awk trick.
#
# Not recommended on big files.
#
# Summary: Reverse output lines
# Source: https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt
# Credits: Eric Pement
# Depends: awk
fileReverseLines() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'
}
_fileReverseLines() {
  true || fileReverseLines --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Makes all `*.sh` files executable
#
# Argument: --find findArguments - Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options.
# Argument: path ... - Optional. Directory. One or more paths to scan for shell files. Uses PWD if not specified.
# Environment: Works from the current directory
# See: makeShellFilesExecutable
# See: chmod-sh.sh
makeShellFilesExecutable() {
  local handler="_${FUNCNAME[0]}"

  local path findArgs=() tempArgs paths=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --find)
      shift
      IFS=' ' read -r -a tempArgs <<<"${1-}" || :
      findArgs+=("${tempArgs[@]+"${tempArgs[@]}"}")
      ;;
    *)
      paths+=("$(validate "$handler" Directory "directory" "$1")") || return $?
      ;;
    esac
    shift
  done
  [ "${#paths[@]}" -gt 0 ] || paths+=("$(catchEnvironment "$handler" pwd)") || return $?
  (
    for path in "${paths[@]}"; do
      catchEnvironment "$handler" cd "$path" || return $?
      find "." -name '*.sh' -type f ! -path "*/.*/*" "${findArgs[@]+"${findArgs[@]}"}" -exec chmod -v +x {} \;
    done
  ) || return $?
}
_makeShellFilesExecutable() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL whichExists 40

# Summary: Does a binary exist in the PATH?
# Argument: --any - Flag. Optional. If any binary exists then return 0 (success). Otherwise, all binaries must exist.
# Argument: binary ... - Required. String. One or more Binaries to find in the system `PATH`.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Return Code: 0 - If all values are found (without the `--any` flag), or if *any* binary is found with the `--any` flag
# Return Code: 1 - If any value is not found (without the `--any` flag), or if *all* binaries are NOT found with the `--any` flag.
# Example:     whichExists cp date aws ls mv stat || throwEnvironment "$handler" "Need basic environment to work" || return $?
# Example:     whichExists --any terraform tofu || throwEnvironment "$handler" "No available infrastructure providers" || return $?
# Example:     whichExists --any curl wget || throwEnvironment "$handler" "No way to download URLs easily" || return $?
# Requires: throwArgument decorate __decorateExtensionEach command
whichExists() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$# anyFlag=false
  [ $# -gt 0 ] || throwArgument "$handler" "no arguments" || return $?
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --any) anyFlag=true ;;
    *)
      local bin
      # printf is returned as just printf with no path, same with all builtins
      bin=$(command -v "$1" 2>/dev/null) || return 1
      [ -n "$bin" ] || return 1
      [ "${bin:0:1}" != "/" ] || [ -e "$bin" ] || return 1
      ! $anyFlag || return 0
      ;;
    esac
    shift
  done
}
_whichExists() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Hard-coded services for:
#
# - `ssh` -> 22
# - `http`-> 80
# - `https`-> 80
# - `postgres`-> 5432
# - `mariadb`-> 3306
# - `mysql`-> 3306
#
# Backup when `/etc/services` does not exist.
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: service ... - String. Optional. A unix service typically found in `/etc/services`
# Output: Port number of associated service (integer) one per line
# Return Code: 1 - service not found
# Return Code: 0 - service found and output is an integer
# See: serviceToPort
#
serviceToStandardPort() {
  local handler="_${FUNCNAME[0]}"

  [ $# -gt 0 ] || throwArgument "$handler" "No arguments" || return $?
  local port

  # _IDENTICAL_ argumentTrimBlankLoopHandler 7
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    argument=$(catchReturn "$handler" trimSpace "$argument") || return $?
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    ssh) port=22 ;;
    http) port=80 ;;
    https) port=443 ;;
    mariadb | mysql) port=3306 ;;
    postgres) port=5432 ;;
    *) throwEnvironment "$handler" "$argument unknown" || return $? ;;
    esac
    printf "%d\n" "$port"
    shift
  done
}
_serviceToStandardPort() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get the port number associated with a service
#
# Argument: service - String. Required. A unix service typically found in `/etc/services`
# Argument: --services servicesFile - Optional. File. File like '/etc/services`.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Output: Port number of associated service (integer) one per line
# Return Code: 1 - service not found
# Return Code: 2 - bad argument or invalid port
# Return Code: 0 - service found and output is an integer
serviceToPort() {
  local handler="_${FUNCNAME[0]}"
  local port servicesFile=/etc/services service

  [ $# -gt 0 ] || throwArgument "$handler" "Require at least one service" || return $?
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" function "$argument" "${1-}") || return $? ;;
    --services)
      shift || throwArgument "$handler" "missing $argument argument" || return $?
      servicesFile=$(validate "$handler" File "servicesFile" "$1") || return $?
      ;;
    *)
      if [ ! -f "$servicesFile" ]; then
        catchEnvironment "$handler" serviceToStandardPort "$@" || return $?
      else
        service="$(trimSpace "$argument")"
        [ -n "$service" ] || throwArgument "$handler" "whitespace argument: $(decorate quote "$argument") #$__index/$__count" || return $?
        if port="$(grep /tcp "$servicesFile" | grep "^$service\s" | awk '{ print $2 }' | cut -d / -f 1)"; then
          isInteger "$port" || throwEnvironment "$handler" "Port found in $servicesFile is not an integer: $port" || return $?
        else
          port="$(serviceToStandardPort "$service")" || throwEnvironment "$handler" serviceToStandardPort "$service" || return $?
        fi
        printf "%d\n" "$port"
      fi
      ;;
    esac
    shift
  done
}
_serviceToPort() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: directory - Directory. Required.
# Argument: original - String. Required.
# Appends (or creates) `original` to the file named `extension` in `directory`
# Appends `original` to file `directory/@` as well.
# `extension` is computed from `original` and an empty extension is written to '!'
__extensionListsLog() {
  local directory="$1" original="$2"
  local name extension
  name="$(basename "$original")" || returnArgument "basename $name" || return $?
  extension="${name##*.}"
  # Tests, in order:
  # - Not `.just-extension`
  # - Not `no-period`
  # - Not `".."` or `"."` or `""`
  # If any of the above - use `!` bucket
  [ "${name%%.*}" != "" ] && [ "$extension" != "$name" ] && [ "$extension" != "." ] && [ "$extension" != ".." ] && [ -n "$extension" ] || extension="!"
  printf "%s\n" "$original" | tee -a "$directory/@" >>"$directory/$extension" || returnEnvironment "writing $directory/$extension" || return $?
}

# Argument: --clean - Optional. Flag. Clean directory of all files first.
# Argument: directory - Required. Directory. Directory to create extension lists.
# Argument: file0 - Optional. List of files to add to the extension list.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Input: Takes a list of files, one per line
# Generates a directory containing files with `extension` as the file names.
# All files passed to this are added to the `@` file, the `!` file is used for files without extensions.
# Extension parsing is done by removing the final dot from the filename:
# - `foo.sh` -> `"sh"`
# - `foo.tar.gz` -> `"gz"`
# - `foo.` -> `"!"``
# - `foo-bar` -> `"!"``
#
extensionLists() {
  local handler="_${FUNCNAME[0]}"

  local names=() directory="" cleanFlag=false
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --clean)
      cleanFlag=true
      ;;
    *)
      if [ -z "$directory" ]; then
        directory=$(validate "$handler" Directory "directory" "$1") || return $?
      else
        names+=("$1")
      fi
      ;;
    esac
    shift
  done
  [ -n "$directory" ] || throwArgument "$handler" "No directory supplied" || return $?

  ! $cleanFlag || catchEnvironment "$handler" find "$directory" -type f -delete || return $?

  local name
  if [ ${#names[@]} -gt 0 ]; then
    for name in "${names[@]}"; do
      catchReturn "$handler" __extensionListsLog "$directory" "$name" || return $?
    done
  else
    catchEnvironment "$handler" touch "$directory/@" || return $?
    while read -r name; do
      catchReturn "$handler" __extensionListsLog "$directory" "$name" || return $?
    done
  fi
}
_extensionLists() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get the load average using uptime
# Requires: uptime
# Uptime output: 0:00  up 30 days,  6:02, 19 users, load averages: 15.01 12.66 11.64
# Uptime output: 05:01:06 up 8 days,  4:03,  0 users,  load average: 3.87, 3.09, 2.71
# stdout: lines:Number
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
loadAverage() {
  local handler="_${FUNCNAME[0]}"
  local text
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local averages=()
  if [ -f "/proc/loadavg" ]; then
    text="$(cat /proc/loadavg)"
  elif whichExists uptime; then
    text=$(catchEnvironment "$handler" uptime) || return $?
    text="${text##*average}"_
    text="${text##*:}"
    text="${text# }"
    text="${text//,/ }"
    text="${text//  / }"
  fi
  read -r -a averages <<<"$text" || :
  printf "%s\n" "${averages[0]}" "${averages[1]-}" "${averages[2]-}"
}
_loadAverage() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Convert a group name to a group ID
# Argument: groupName - String. Required. One or more names to find group IDs for.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# stdout: PositiveInteger
groupID() {
  local handler="_${FUNCNAME[0]}" one=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local gid
      gid="$(__groupID "$1")" || return 1
      isPositiveInteger "$gid" || throwEnvironment "$handler" "No group found: $1" || return $?
      printf "%d\n" "$gid"
      one=true
      ;;
    esac
    shift
  done
  $one || throwArgument "$handler" "Requires a group name" || return $?
}
_groupID() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__pcregrepInstall() {
  packageGroupWhich "$(__pcregrepBinary)" pcregrep || return $?
}
