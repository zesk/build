#!/usr/bin/env bash
#
# Directory Functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/directory.md
# Test: o ./test/tools/directory-tests.sh

# Is a path an absolute path?
# Usage: {fn} path ...
# Exit Code: 0 - if all paths passed in are absolute paths (begin with `/`).
# Exit Code: 1 - one ore more paths are not absolute paths
isAbsolutePath() {
  local usage="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || __throwArgument "$usage" "Need at least one argument" || return $?
  while [ $# -gt 0 ]; do
    [ "$1" != "${1#/}" ] || return 1
    shift || :
  done
}
_isAbsolutePath() {
  # _IDENTICAL_ usageDocument 1
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
  targetPath="$(dirname "$target")" || __throwArgument "$usage" "dirname $target" || return $?
  [ -d "$targetPath" ] || __throwEnvironment "$usage" "$targetPath is not a directory" || return $?
  targetName="$(basename "$target")" || __throwEnvironment basename "$target" || return $?
  sourceStage="$targetPath/.NEW.$$.$targetName"
  targetBackup="$targetPath/.OLD.$$.$targetName"
  __catchEnvironment "$usage" mv -f "$source" "$sourceStage" || return $?
  __catchEnvironment "$usage" mv -f "$target" "$targetBackup" || return $?
  if ! mv -f "$sourceStage" "$target"; then
    mv -f "$targetBackup" "$target" || __throwEnvironment "$usage" "Unable to revert $targetBackup -> $target" || return $?
    mv -f "$sourceStage" "$source" || __throwEnvironment "$usage" "Unable to revert $sourceStage -> $source" || return $?
    __throwEnvironment "$usage" "Clobber failed" || return $?
  fi
  __catchEnvironment "$usage" rm -rf "$targetBackup" || return $?
}
_directoryClobber() {
  # _IDENTICAL_ usageDocument 1
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
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    name="$(dirname "$1")" || __throwEnvironment "$usage" "dirname $argument" || return $?
    [ -d "$name" ] || mkdir -p "$name" || __throwEnvironment "$usage" "Unable to create directory \"$(decorate code "$name")\"" || return $?
    shift || __throwArgument "$usage" shift || return $?
  done
}
_requireFileDirectory() {
  # _IDENTICAL_ usageDocument 1
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
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    path=$(dirname "$argument") || __throwEnvironment "$usage" "dirname $argument" || return $?
    [ -d "$path" ] || return 1
    shift || __throwArgument "$usage" shift || return $?
  done
}
_fileDirectoryExists() {
  # _IDENTICAL_ usageDocument 1
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
    [ -n "$name" ] || __throwArgument "$usage" "blank argument" || return $?
    [ -d "$name" ] || mkdir -p "$name" || __throwEnvironment "$usage" "Unable to create directory \"$(decorate code "$name")\"" || return $?
    printf "%s\n" "$name"
    shift || __throwArgument "$usage" shift || return $?
  done
}
_requireDirectory() {
  # _IDENTICAL_ usageDocument 1
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
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    *)
      [ -d "$argument" ] || __throwArgument "$usage" "Not a directory $(decorate code "$argument")" || return $?
      find "$argument" -mindepth 1 -maxdepth 1 | read -r && return 1 || return 0
      ;;
    esac
  done
}
_directoryIsEmpty() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Given a path to a file, compute the path back up to the top in reverse (../..)
# If path is blank, outputs `.`.
#
# Essentially converts the slash `/` to a `..`, so convert your source appropriately.
#
#      directoryRelativePath "/" -> ".."
#      directoryRelativePath "/a/b/c" -> ../../..
#
# Usage: {fn} directory ...
# Argument: directory - String. A path to convert.
# stdout: Relative paths, one per line
directoryRelativePath() {
  local relTop
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      relTop=.
    else
      relTop=$(printf "%s\n" "$1" | sed -e 's/[^/]//g' -e 's/\//..\//g')
      relTop="${relTop%/}"
    fi
    printf "%s\n" "$relTop"
    shift
  done
}

# Usage: {fn} startingDirectory filePattern [ testExpression ... ]
# Finds a file above `startingDirectory`, uses `testExpression` to test (defaults to `-d`)
# Argument: startingDirectory - Required. EmptyString|RealDirectory. Uses the current directory if blank.
# Argument: --pattern filePattern - Required. RelativePath. The file or directory to find the home for.
# Argument: --test testExpression - String. Optional. Zero or more. The `test` argument to test the targeted `filePattern`. By default uses `-d`.
directoryParent() {
  __directoryParent "_${FUNCNAME[0]}" "$@"
}
_directoryParent() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Utility for specific implementations of `directoryParent`
# See: gitFindHome
# Usage: {fn} usageFunction [ --help ] startingDirectory filePattern [ testExpression ]
# Argument: usageFunction - Required. Function. Called when an error occurs.
# Argument: startingDirectory - Required. EmptyString|RealDirectory. Uses the current directory if blank.
# Argument: --pattern filePattern - Required. RelativePath. The file or directory to find the home for.
# Argument: --test testExpression - String. Optional. Zero or more. The `test` argument to test the targeted `filePattern`. By default uses `-d`.
__directoryParent() {
  local usage="${1-}" && shift

  local testExpression directory lastDirectory="" passed passedExpression failedExpression
  local startingDirectory="" filePattern="" testExpressions=() bestFailure=""

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
    --pattern)
      [ -z "$filePattern" ] || __throwArgument "$usage" "$argument already specified" || return $?
      shift
      filePattern=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      ;;
    --test)
      shift
      testExpressions+=("$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
      ;;
    *)
      [ -z "$startingDirectory" ] || __throwArgument "$usage" "startingDirectory $(decorate code "$argument") was already specified $(decorate value "$startingDirectory") (Arguments: $(decorate each code "${usage#_}" "${__saved[@]}"))" || return $?
      [ -n "$argument" ] || argument=$(__catchEnvironment "$usage" pwd) || return $?
      startingDirectory=$(usageArgumentRealDirectory "$usage" startingDirectory "$argument") || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  # Default is directory test
  [ ${#testExpressions[@]} -gt 0 ] || testExpressions+=("-d")

  directory="$startingDirectory"
  while [ "$directory" != "$lastDirectory" ]; do
    passed=true
    passedExpression=""
    failedExpression=""
    for testExpression in "${testExpressions[@]+"${testExpressions[@]}"}"; do
      [ "$testExpression" != "${testExpression#-}" ] || __throwArgument "$usage" "Invalid expression: $(decorate code "$testExpression") (Arguments: $(decorate each code "${usage#_}" "${__saved[@]}"))" || return $?
      if ! test "$testExpression" "$directory/$filePattern"; then
        passed=false
        failedExpression="$testExpression"
        break
      fi
      passedExpression="$testExpression"
    done
    if $passed; then
      printf "%s\n" "$directory"
      return 0
    fi
    if [ -n "$passedExpression" ]; then
      bestFailure="$directory/$filePattern ${#testExpressions[@]} passed $(decorate green "$passedExpression") failed: $(decorate red "$failedExpression")" || return $?
    fi
    lastDirectory="$directory"
    directory="$(dirname "$directory")"
  done
  [ -n "$bestFailure" ] || bestFailure="No $(decorate code "$filePattern") found above $(decorate value "$argument")"
  __throwEnvironment "$usage" "$bestFailure" || return $?
  return 1
}
