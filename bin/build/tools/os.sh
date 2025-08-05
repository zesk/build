#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/os.md
# Test: o ./test/tools/os-tests.sh

#
# Usage: {fn} count binary [ args ... ]
# Argument: count - The number of times to run the binary
# Argument: binary - The binary to run
# Argument: args ... - Any arguments to pass to the binary each run
# Exit Code: 0 - success
# Exit Code: 2 - `count` is not an unsigned number
# Exit Code: Any - If `binary` fails, the exit code is returned
# Summary: Run a binary count times
#
runCount() {
  local usage="_${FUNCNAME[0]}"
  local argument index total

  total=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    *)
      if [ -z "$total" ]; then
        isUnsignedInteger "$argument" || __throwArgument "$usage" "$argument must be a positive integer" || return $?
        total="$argument"
      else
        index=0
        while [ "$index" -lt "$total" ]; do
          index=$((index + 1))
          "$@" || __throwEnvironment "$usage" "iteration #$index" "$@" return $?
        done
        return 0
      fi
      ;;
    esac
    shift || __throwArgument "$usage" shift || return $?
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
  local usage="_${FUNCNAME[0]}"

  local path findArgs=() tempArgs paths=()

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --find)
      shift
      IFS=' ' read -r -a tempArgs <<<"${1-}" || :
      findArgs+=("${tempArgs[@]+"${tempArgs[@]}"}")
      ;;
    *)
      paths+=("$(usageArgumentDirectory "$usage" "directory" "$1")") || return $?
      ;;
    esac
    shift
  done
  [ "${#paths[@]}" -gt 0 ] || paths+=("$(__catchEnvironment "$usage" pwd)") || return $?
  (
    for path in "${paths[@]}"; do
      __catchEnvironment "$usage" cd "$path" || return $?
      find "." -name '*.sh' -type f ! -path "*/.*/*" "${findArgs[@]+"${findArgs[@]}"}" -exec chmod -v +x {} \;
    done
  ) || return $?
}
_makeShellFilesExecutable() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Modify the MANPATH environment variable to add a path.
# See: manPathRemove
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --first - Optional. Place any paths after this flag first in the list
# Argument: --last - Optional. Place any paths after this flag last in the list. Default.
# Argument: path - the path to be added to the `MANPATH` environment
#
manPathConfigure() {
  local usage="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0

  local tempPath
  export MANPATH

  __catch "$usage" buildEnvironmentLoad MANPATH || return $?
  tempPath="$(__catchEnvironment "$usage" listAppend "$MANPATH" ':' "$@")" || return $?
  MANPATH="$tempPath"
}
_manPathConfigure() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Remove a path from the MANPATH environment variable
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: path - Directory. Required. The path to be removed from the `MANPATH` environment
manPathRemove() {
  local usage="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0

  local tempPath
  export MANPATH

  __catch "$usage" buildEnvironmentLoad MANPATH || return $?
  tempPath="$(__catchEnvironment "$usage" listRemove "$MANPATH" ':' "$@")" || return $?
  MANPATH="$tempPath"
}
_manPathRemove() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Cleans the MANPATH and removes non-directory entries and duplicates
#
# Maintains ordering.
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# No-Arguments: default
manPathCleanDuplicates() {
  local usage="_${FUNCNAME[0]}" newPath
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
  export MANPATH

  __catch "$usage" buildEnvironmentLoad MANPATH || return $?

  newPath=$(__catchEnvironment "$usage" listCleanDuplicates --test _pathIsDirectory ':' "${PATH-}") || return $?

  MANPATH="$newPath"
}
_manPathCleanDuplicates() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Remove a path from the PATH environment variable
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: path - Requires. String. The path to be removed from the `PATH` environment.
pathRemove() {
  local usage="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
  local tempPath
  export PATH

  __catch "$usage" buildEnvironmentLoad PATH || return $?
  tempPath="$(__catchEnvironment "$usage" listRemove "$PATH" ':' "$@")" || return $?
  PATH="$tempPath"
}
_pathRemove() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Modify the PATH environment variable to add a path.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --first - Optional. Place any paths after this flag first in the list
# Argument: --last - Optional. Place any paths after this flag last in the list. Default.
# Argument: path - the path to be added to the `PATH` environment
pathConfigure() {
  local usage="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
  local tempPath
  export PATH

  __catch "$usage" buildEnvironmentLoad PATH || return $?
  tempPath="$(__catchEnvironment "$usage" listAppend "$PATH" ':' "$@")" || return $?
  PATH="$tempPath"
}
_pathConfigure() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Utility for pathCleanDuplicates to show bad directories
_pathIsDirectory() {
  [ -n "${1-}" ] || return 1
  [ -d "${1-}" ] || return 1
}

# Cleans the path and removes non-directory entries and duplicates
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Maintains ordering.
#
# Environment: PATH
pathCleanDuplicates() {
  local usage="_${FUNCNAME[0]}" newPath
  [ $# -eq 0 ] || __help --only "$usage" "$@" || return "$(convertValue $? 1 0)"
  export PATH

  newPath=$(__catchEnvironment "$usage" listCleanDuplicates --test _pathIsDirectory ':' "${PATH-}") || return $?

  PATH="$newPath"
}
_pathCleanDuplicates() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL whichExists 25

# Summary: Does a binary exist in the PATH?
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: binary ... - Required. String. One or more Binaries to find in the system `PATH`.
# Exit code: 0 - If all values are found
# Exit code: 1 - If any value is not found
# Requires: __throwArgument which decorate __decorateExtensionEach
whichExists() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local __saved=("$@") __count=$#
  [ $# -gt 0 ] || __throwArgument "$handler" "no arguments" || return $?
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    which "$1" >/dev/null || return 1
    shift
  done
}
_whichExists() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Format something neatly as JSON
# Usage: JSON < inputFile > outputFile
JSON() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  jq .
}
_JSON() {
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
# Exit Code: 1 - service not found
# Exit Code: 0 - service found and output is an integer
# See: serviceToPort
#
serviceToStandardPort() {
  local handler="_${FUNCNAME[0]}"

  [ $# -gt 0 ] || __throwArgument "$handler" "No arguments" || return $?
  local port

  # _IDENTICAL_ argumentTrimBlankLoopHandler 7
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    argument=$(__catch "$handler" trimSpace "$argument") || return $?
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    ssh) port=22 ;;
    http) port=80 ;;
    https) port=443 ;;
    mariadb | mysql) port=3306 ;;
    postgres) port=5432 ;;
    *) __throwEnvironment "$handler" "$argument unknown" || return $? ;;
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
# Usage: {fn} service [ ... ]
# Argument: service - A unix service typically found in `/etc/services`
# Argument: --services servicesFile - Optional. File. File like '/etc/services`.
# Output: Port number of associated service (integer) one per line
# Exit Code: 1 - service not found
# Exit Code: 2 - bad argument or invalid port
# Exit Code: 0 - service found and output is an integer
#
serviceToPort() {
  local handler="_${FUNCNAME[0]}"
  local port servicesFile=/etc/services service

  [ $# -gt 0 ] || __throwArgument "$handler" "Require at least one service" || return $?
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --services)
      shift || __throwArgument "$handler" "missing $argument argument" || return $?
      servicesFile=$(usageArgumentFile "$handler" "servicesFile" "$1") || return $?
      ;;
    *)
      if [ ! -f "$servicesFile" ]; then
        __catchEnvironment "$handler" serviceToStandardPort "$@" || return $?
      else
        service="$(trimSpace "$argument")"
        [ -n "$service" ] || __throwArgument "$handler" "whitespace argument: $(decorate quote "$argument") #$__index/$__count" || return $?
        if port="$(grep /tcp "$servicesFile" | grep "^$service\s" | awk '{ print $2 }' | cut -d / -f 1)"; then
          isInteger "$port" || __throwEnvironment "$handler" "Port found in $servicesFile is not an integer: $port" || return $?
        else
          port="$(serviceToStandardPort "$service")" || __throwEnvironment "$handler" serviceToStandardPort "$service" || return $?
        fi
        printf "%d\n" "$port"
      fi
      ;;
    esac
    shift || __throwArgument "$handler" "shift argument $argument" || return $?
  done
}
_serviceToPort() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} directory original
# Appends (or creates) `original` to the file named `extension` in `directory`
# Appends `original` to file `directory/@` as well.
# `extension` is computed from `original` and an empty extension is written to '!'
__extensionListsLog() {
  local directory="$1" original="$2"
  local name extension
  name="$(basename "$original")" || _argument "basename $name" || return $?
  extension="${name##*.}"
  # Tests, in order:
  # - Not `.just-extension`
  # - Not `no-period`
  # - Not `".."` or `"."` or `""`
  # If any of the above - use `!` bucket
  [ "${name%%.*}" != "" ] && [ "$extension" != "$name" ] && [ "$extension" != "." ] && [ "$extension" != ".." ] && [ -n "$extension" ] || extension="!"
  printf "%s\n" "$original" | tee -a "$directory/@" >>"$directory/$extension" || _environment "writing $directory/$extension" || return $?
}

#
# Usage: {fn} directory file0 ...
# Argument: --help - Optional. Flag. This help.
# Argument: --clean - Optional. Flag. Clean directory of all files first.
# Argument: directory - Required. Directory. Directory to create extension lists.
# Argument: file0 - Optional. List of files to add to the extension list.
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
  local usage="_${FUNCNAME[0]}"

  local names=() directory="" cleanFlag=false
  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --clean)
      cleanFlag=true
      ;;
    *)
      if [ -z "$directory" ]; then
        directory=$(usageArgumentDirectory "$usage" "directory" "$1") || return $?
      else
        names+=("$1")
      fi
      ;;
    esac
    shift
  done
  [ -n "$directory" ] || __throwArgument "$usage" "No directory supplied" || return $?

  ! $cleanFlag || __catchEnvironment "$usage" find "$directory" -type f -delete || return $?

  local name
  if [ ${#names[@]} -gt 0 ]; then
    for name in "${names[@]}"; do
      __catch "$usage" __extensionListsLog "$directory" "$name" || return $?
    done
  else
    __catchEnvironment "$usage" touch "$directory/@" || return $?
    while read -r name; do
      __catch "$usage" __extensionListsLog "$directory" "$name" || return $?
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
loadAverage() {
  local usage="_${FUNCNAME[0]}"
  local text
  [ $# -eq 0 ] || __help --only "$usage" "$@" || return "$(convertValue $? 1 0)"
  text=$(__catchEnvironment "$usage" uptime) || return $?
  text="${text##*average}"
  text="${text##*:}"
  text="${text# }"
  text="${text//,/ }"
  text="${text//  / }"
  local averages=()
  read -r -a averages <<<"$text" || :
  printf "%s\n" "${averages[@]}"
}
_loadAverage() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
