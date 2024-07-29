#!/usr/bin/env bash
#
# Directory Functions
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/directory.md
# Test: o ./test/tools/directory-tests.sh

# Is a path an absolute path?
# Usage: {fn} path ...
# Exit Code: 0 - if all paths passed in are absolute paths (begin with `/`).
# Exit Code: 1 - one ore more paths are not absolute paths
isAbsolutePath() {
  local usage="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || __failArgument "$usage" "Need at least one argument" || return $?
  while [ $# -gt 0 ]; do
    [ "$1" != "${1#/}" ] || return 1
    shift || :
  done
}
_isAbsolutePath() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} source target
#
# Copy directory over another sort-of-atomically
#
directoryClobber() {
  local usage="_${FUNCNAME[0]}"
  local source target targetPath targetName sourceStage targetBackup

  source=$(usageArgumentDirectory "$usage" source "$1") || return $?
  shift || :
  target="${1-}"
  targetPath="$(dirname "$target")" || __failArgument "$usage" "dirname $target" || return $?
  [ -d "$targetPath" ] || __failEnvironment "$usage" "$targetPath is not a directory" || return $?
  targetName="$(basename "$target")" || __failEnvironment basename "$target" || return $?
  sourceStage="$targetPath/.NEW.$$.$targetName"
  targetBackup="$targetPath/.OLD.$$.$targetName"
  __usageEnvironment "$usage" mv -f "$source" "$sourceStage" || return $?
  __usageEnvironment "$usage" mv -f "$target" "$targetBackup" || return $?
  if ! mv -f "$sourceStage" "$target"; then
    mv -f "$targetBackup" "$target" || __failEnvironment "$usage" "Unable to revert $targetBackup -> $target" || return $?
    mv -f "$sourceStage" "$source" || __failEnvironment "$usage" "Unable to revert $sourceStage -> $source" || return $?
    __failEnvironment "$usage" "Clobber failed" || return $?
  fi
  __usageEnvironment "$usage" rm -rf "$targetBackup" || return $?
}
_directoryClobber() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Given a list of files, ensure their parent directories exist
#
# Creates the directories for all files passed in.
#
# Usage: {fn} file1 file2 ...
# Example:     logFile=./.build/$me.log
# Example:     {fn} "$logFile"
#
requireFileDirectory() {
  local name
  local argument usage="_${FUNCNAME[0]}"
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    name="$(dirname "$1")" || __failEnvironment "$usage" "dirname $argument" || return $?
    [ -d "$name" ] || mkdir -p "$name" || __failEnvironment "$usage" "Unable to create directory \"$(consoleCode "$name")\"" || return $?
    shift || __failArgument "$usage" shift || return $?
  done
}
_requireFileDirectory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Does the file's directory exist?
#
# Usage: {fn} directory
# Argument: directory - Test if file directory exists (file does not have to exist)
fileDirectoryExists() {
  local path
  local argument usage="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || _argument "No arguments" || return $?
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    path=$(dirname "$argument") || __failEnvironment "$usage" "dirname $argument" || return $?
    [ -d "$path" ] || return 1
    shift || __failArgument "$usage" shift || return $?
  done
}
_fileDirectoryExists() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Given a list of directories, ensure they exist and create them if they do not.
#
# Usage: {fn} dir1 [ dir2 ... ]
# Argument: dir1 - One or more directories to create
# Example:     {fn} "$cachePath"
#
requireDirectory() {
  local name
  local usage="_${FUNCNAME[0]}"
  while [ $# -gt 0 ]; do
    name="$1"
    [ -n "$name" ] || __failArgument "$usage" "blank argument" || return $?
    [ -d "$name" ] || mkdir -p "$name" || __failEnvironment "$usage" "Unable to create directory \"$(consoleCode "$name")\"" || return $?
    printf "%s\n" "$name"
    shift || __failArgument "$usage" shift || return $?
  done
}
_requireDirectory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} directory
# Does a directory exist and is it empty?
# Exit code: 2 - Directory does not exist
# Exit code: 1 - Directory is not empty
# Exit code: 0 - Directory is empty
directoryIsEmpty() {
  local argument

  while [ $# -gt 0 ]; do
    argument="$1"
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        [ -d "$argument" ] || __failArgument "$usage" "Not a directory $(consoleCode "$argument")" || return $?
        find "$argument" -mindepth 1 -maxdepth 1 | read -r && return 1 || return 0
        ;;
    esac
  done
}
_directoryIsEmpty() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
