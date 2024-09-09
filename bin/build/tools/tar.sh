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
# Platform agnostic tar extract with wildcards
#
# e.g. `tar -xf '*/file.json'` or `tar -xf --wildcards '*/file.json'` depending on OS
#
# `tar` command is not cross-platform so this differentiates between the GNU and BSD command line arguments.
#
# Short description: Platform agnostic tar extract
# Usage: {fn} pattern
# Argument: pattern - The file pattern to extract
# stdin: A gzipped-tar file
# stdout: The desired file
extractTarFilePattern() {
  local usage="_${FUNCNAME[0]}"
  local argument
  local pattern

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
        pattern="$argument"
        shift || __failArgument "No pattern supplied" || return $?
        # -h means follow symlinks
        if tar --version | grep -q GNU; then
          # GNU
          # > tar --version
          # tar (GNU tar) 1.34
          # ...
          tar -O -zx --wildcards "$pattern" "$@"
        else
          # BSD
          # > tar --version
          # bsdtar 3.5.3 - libarchive 3.5.3 zlib/1.2.11 liblzma/5.0.5 bz2lib/1.0.8
          tar -O -zx "$pattern" "$@"
        fi
        return 0
        ;;
    esac
  done
}
_extractTarFilePattern() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Platform agnostic tar cfz which ignores owner and attributes
#
# `tar` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (`.tgz` or `.tar.gz`) with user and group set to 0 and no extended attributes attached to the files.
# Short description: Platform agnostic tar create which keeps user and group as user 0
# Usage: tarCreate target files
# Argument: target - The tar.gz file to create
# Argument: files - A list of files to include in the tar file
#
tarCreate() {
  local usage="_${FUNCNAME[0]}"
  local argument
  local target

  [ $# -gt 0 ] || __failArgument "$usage" "Need target and files" || return $?
  target=
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
        target="$argument"
        shift || __failArgument "No files supplied" || return $?
        # -h means follow symlinks
        if tar --version | grep -q GNU; then
          # GNU
          # > tar --version
          # tar (GNU tar) 1.34
          # ...
          tar -czf "$target" --owner=0 --group=0 --no-xattrs -h "$@"
        else
          # BSD
          # > tar --version
          # bsdtar 3.5.3 - libarchive 3.5.3 zlib/1.2.11 liblzma/5.0.5 bz2lib/1.0.8
          tar -czf "$target" --uid 0 --gid 0 --no-acls --no-fflags --no-xattrs -h "$@"
        fi
        return 0
        ;;
    esac
  done
}
_tarCreate() {
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

# Makes shell files (`.sh`) executable
#
# Makes all `*.sh` files executable in directories provided. If no arguments, uses current directory.
#
# Usage: {fn} [ directory ... ]
# Argument: findArguments - Optional. Add arguments to exclude files or paths.
# Environment: If no arguments supplied, works from the current directory.
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
        path=$(usageArgumentDirectory "$usage" "directory" "$1") || return $?
        paths+=("$path")
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
  done
  [ "${#paths[@]}" -gt 0 ] || paths+=("$(pwd)")
  for path in "${paths[@]}"; do
    find "$path" -name '*.sh' -type f ! -path "*/.*/*" "${findArgs[@]+"${findArgs[@]}"}" -print0 | xargs -0 chmod -v +x
  done
}
_makeShellFilesExecutable() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
