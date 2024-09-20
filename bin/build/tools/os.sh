#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/os.md
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
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        if [ -z "$total" ]; then
          isUnsignedInteger "$argument" || __failArgument "$usage" "$argument must be a positive integer" || return $?
          total="$argument"
        else
          index=0
          while [ "$index" -lt "$total" ]; do
            index=$((index + 1))
            "$@" || __failEnvironment "$usage" "iteration #$index" "$@" return $?
          done
          return 0
        fi
        ;;
    esac
    shift || __failArgument "$usage" shift || return $?
  done

}
_runCount() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Reverses a pipe's input lines to output using an awk trick. Do not recommend on big files.
#
# Summary: Reverse output lines
# Source: https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt
# Credits: Eric Pement
#
reverseFileLines() {
  awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'
}

# Makes all `*.sh` files executable
#
# Usage: {fn} [ findArguments ... ]
# Argument: findArguments - Optional. Add arguments to exclude files or paths.
# Environment: Works from the current directory
# See: makeShellFilesExecutable
# fn: chmod-sh.sh
makeShellFilesExecutable() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local path findArgs=() tempArgs paths=()

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --find)
        shift
        IFS=' ' read -r -a tempArgs <<<"${1-}"
        findArgs+=("${tempArgs[@]+"${tempArgs[@]}"}")
        ;;
      *)
        paths+=("$(usageArgumentDirectory "$usage" "directory" "$1")") || return $?
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
  done
  [ "${#paths[@]}" -gt 0 ] || paths+=("$(__usageEnvironment "$usage" pwd)") || return $?
  (
    for path in "${paths[@]}"; do
      __usageEnvironment "$usage" cd "$path" || return $?
      find "." -name '*.sh' -type f ! -path "*/.*/*" "${findArgs[@]+"${findArgs[@]}"}" -print0 | xargs -0 chmod -v +x
    done
  ) || return $?
}
_makeShellFilesExecutable() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} [ --first | --last | path ] ...
# Argument: --first - Optional. Place any paths after this flag first in the list
# Argument: --last - Optional. Place any paths after this flag last in the list. Default.
# Argument: path - the path to be added to the `MANPATH` environment
#
manPathConfigure() {
  local tempPath
  export MANPATH

  __environment buildEnvironmentLoad MANPATH || return $?
  tempPath="$(listAppend "$MANPATH" ':' "$@")" || _environment listAppend "$MANPATH" ':' "$@" || return $?
  MANPATH="$tempPath"
}

#
# Cleans the MANPATH and removes non-directory entries and duplicates
#
# Maintains ordering.
#
# Usage: manPathCleanDuplicates
#
manPathCleanDuplicates() {
  local usage="_${FUNCNAME[0]}" newPath
  export MANPATH

  __usageEnvironment "$usage" buildEnvironmentLoad MANPATH || return $?

  newPath=$(__usageEnvironment "$usage" listCleanDuplicates --test _pathIsDirectory ':' "${PATH-}") || return $?

  MANPATH="$newPath"
}
_manPathCleanDuplicates() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} [ --first | --last | path ] ...
# Argument: --first - Optional. Place any paths after this flag first in the list
# Argument: --last - Optional. Place any paths after this flag last in the list. Default.
# Argument: path - the path to be added to the `PATH` environment
pathConfigure() {
  local usage="_${FUNCNAME[0]}"
  local tempPath
  export PATH

  __usageEnvironment "$usage" buildEnvironmentLoad PATH || return $?
  tempPath="$(__usageEnvironment "$usage" listAppend "$PATH" ':' "$@")" || return $?
  PATH="$tempPath"
}
_pathConfigure() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Utility for pathCleanDuplicates to show bad directories
_pathIsDirectory() {
  [ -n "${1-}" ] || _environment "blank entry" || return $?
  [ -d "${1-}" ] || _environment "$1 is not a directory" || return $?
}

#
# Cleans the path and removes non-directory entries and duplicates
#
# Maintains ordering.
#
# Usage: pathCleanDuplicates
#
pathCleanDuplicates() {
  local usage="_${FUNCNAME[0]}" newPath
  export PATH

  newPath=$(__usageEnvironment "$usage" listCleanDuplicates --test _pathIsDirectory ':' "${PATH-}") || return $?

  PATH="$newPath"
}
_pathCleanDuplicates() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL whichExists 11
# Usage: {fn} binary ...
# Argument: binary - Required. String. Binary to find in the system `PATH`.
# Exit code: 0 - If all values are found
whichExists() {
  local nArguments=$# && [ $# -gt 0 ] || _argument "no arguments" || return $?
  while [ $# -gt 0 ]; do
    [ -n "${1-}" ] || _argument "blank argument #$((nArguments - $# + 1))" || return $?
    which "$1" >/dev/null || return 1
    shift
  done
}

#
# Format something neatly as JSON
# Usage: JSON < inputFile > outputFile
# Depend: python
JSON() {
  python -c "import sys, json; print(json.dumps(json.load(sys.stdin), indent=4))"
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
# Usage: {fn} service [ ... ]
# Argument: service - A unix service typically found in `/etc/services`
# Output: Port number of associated service (integer) one per line
# Exit Code: 1 - service not found
# Exit Code: 0 - service found and output is an integer
# See: serviceToPort
#
serviceToStandardPort() {
  local usage="_${FUNCNAME[0]}"
  local port service
  [ $# -gt 0 ] || __failArgument "$usage" "No arguments" || return $?
  while [ $# -gt 0 ]; do
    service="$(trimSpace "${1-}")"
    case "$service" in
      ssh) port=22 ;;
      http) port=80 ;;
      https) port=443 ;;
      mariadb | mysql) port=3306 ;;
      postgres) port=5432 ;;
      *) __failEnvironment "$usage" "$service unknown" || return $? ;;
    esac
    printf "%d\n" "$port"
    shift || __failArgument "$usage" shift "$argument" "$@" || return $?
  done
}
_serviceToStandardPort() {
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
  local usage="_${FUNCNAME[0]}"
  local argument
  local port servicesFile service

  servicesFile=/etc/services
  [ $# -gt 0 ] || __failArgument "$usage" "Require at least one service" || return $?
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    argument="$(trimSpace "$argument")"
    [ -n "$argument" ] || __failArgument "$usage" "argument is whitespace" || return $?
    case "$argument" in
      --services)
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        servicesFile=$(usageArgumentFile "$usage" "servicesFile" "$1") || return $?
        ;;
      *)
        if [ ! -f "$servicesFile" ]; then
          __usageEnvironment "$usage" serviceToStandardPort "$@" || return $?
        else
          service="$(trimSpace "${1-}")"
          if port="$(grep /tcp "$servicesFile" | grep "^$service\s" | awk '{ print $2 }' | cut -d / -f 1)"; then
            isInteger "$port" || __failEnvironment "$usage" "Port found in $servicesFile is not an integer: $port" || return $?
          else
            port="$(serviceToStandardPort "$service")" || __failEnvironment "$usage" serviceToStandardPort "$service" || return $?
          fi
          printf "%d\n" "$port"
        fi
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $argument" || return $?
  done
}
_serviceToPort() {
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
  local argument directory name names extension cleanFlag

  names=()
  directory=
  cleanFlag=false
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
    shift || __failArgument "$usage" "shift argument $argument" || return $?
  done
  [ -n "$directory" ] || __failArgument "$usage" "No directory supplied" || return $?

  ! $cleanFlag || statusMessage consoleInfo "Cleaning ..." || :
  ! $cleanFlag || __usageEnvironment "$usage" find "$directory" -type f -delete || return $? && clearLine

  if [ ${#names[@]} -gt 0 ]; then
    for name in "${names[@]}"; do
      __usageEnvironment "$usage" __extensionListsLog "$directory" "$name" || return $?
    done
  else
    __usageEnvironment "$usage" touch "$directory/@" || return $?
    while read -r name; do
      __usageEnvironment "$usage" __extensionListsLog "$directory" "$name" || return $?
    done
  fi
}
_extensionLists() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
