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
# Return Code: 0 - if all paths passed in are absolute paths (begin with `/`).
# Return Code: 1 - one ore more paths are not absolute paths
pathIsAbsolute() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  while [ $# -gt 0 ]; do
    [ "$1" != "${1#/}" ] || return 1
    shift || :
  done
}
_pathIsAbsolute() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: directory - Directory. Required. Directory to change to prior to running command.
# Argument: command - Callable. Required. Thing to do in this directory.
# Argument: ... - Arguments. Optional. Arguments to `command`.
# Run a command after changing directory to it and then returning to the previous directory afterwards.
# Requires: pushd popd
directoryChange() {
  local handler="_${FUNCNAME[0]}"

  local directory="" command=""

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
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    *)
      if [ -z "$directory" ]; then
        directory=$(usageArgumentDirectory "$handler" "directory" "$1") || return $?
      elif [ -z "$command" ]; then
        command=$(usageArgumentCallable "$handler" "command" "$1") && shift || return $?
        catchEnvironment "$handler" muzzle pushd "$directory" || return $?
        catchEnvironment "$handler" "$command" "$@" || returnUndo $? muzzle popd || return $?
        catchEnvironment "$handler" muzzle popd || return $?
        return 0
      fi
      ;;
    esac
    shift
  done
  [ -n "$directory" ] || throwArgument "$handler" "Missing directory" || return $?
  throwArgument "$handler" "Missing command" || return $?
}
_directoryChange() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} source target
#
# Copy directory over another sort-of-atomically
#
directoryClobber() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local source target targetPath targetName sourceStage targetBackup

  source=$(usageArgumentDirectory "$handler" source "$1") || return $?
  shift || :
  target="${1-}"
  targetPath="$(dirname "$target")" || throwArgument "$handler" "dirname $target" || return $?
  [ -d "$targetPath" ] || throwEnvironment "$handler" "$targetPath is not a directory" || return $?
  targetName="$(basename "$target")" || throwEnvironment basename "$target" || return $?
  sourceStage="$targetPath/.NEW.$$.$targetName"
  targetBackup="$targetPath/.OLD.$$.$targetName"
  catchEnvironment "$handler" mv -f "$source" "$sourceStage" || return $?
  catchEnvironment "$handler" mv -f "$target" "$targetBackup" || return $?
  if ! mv -f "$sourceStage" "$target"; then
    mv -f "$targetBackup" "$target" || throwEnvironment "$handler" "Unable to revert $targetBackup -> $target" || return $?
    mv -f "$sourceStage" "$source" || throwEnvironment "$handler" "Unable to revert $sourceStage -> $source" || return $?
    throwEnvironment "$handler" "Clobber failed" || return $?
  fi
  catchEnvironment "$handler" rm -rf "$targetBackup" || return $?
}
_directoryClobber() {
  # __IDENTICAL__ usageDocument 1
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
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --mode fileMode - String. Optional. Enforce the directory mode for `mkdir --mode` and `chmod`. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to `-` to reset to no value.
# Argument: --owner ownerName - String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to `-` to reset to no value.
# Argument: fileDirectory ... - FileDirectory. Required. Test if file directory exists (file does not have to exist)
# Requires: chmod throwArgument usageArgumentString decorate catchEnvironment dirname
fileDirectoryRequire() {
  local handler="_${FUNCNAME[0]}"

  local name="" rr=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --owner | --mode)
      shift
      local value
      value=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      rr+=("$argument" "$value") || return $?
      ;;
    *)
      rr+=(--output "$argument" "$(catchEnvironment "$handler" dirname "$argument")") || return $?
      ;;
    esac
    shift
  done
  directoryRequire --handler "$handler" --noun "file directory" "${rr[@]+"${rr[@]}"}" || return $?
}
_fileDirectoryRequire() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Does the file's directory exist?
#
# Argument: directory - Directory. Required. Test if file directory exists (file does not have to exist)
fileDirectoryExists() {
  local handler="_${FUNCNAME[0]}"
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
      local path
      path=$(dirname "$argument") || throwEnvironment "$handler" "dirname $argument" || return $?
      [ -d "$path" ] || return 1
      ;;
    esac
    shift
  done
}
_fileDirectoryExists() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Given a list of directories, ensure they exist and create them if they do not.
#
# Usage: {fn} dir1 [ dir2 ... ]
# Argument: dir1 - One or more directories to create
# Example:     {fn} "$cachePath"
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --mode fileMode - String. Optional. Enforce the directory mode for `mkdir --mode` and `chmod`. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to `-` to reset to no value.
# Argument: --owner ownerName - String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to `-` to reset to no value.
# Requires: throwArgument usageArgumentFunction usageArgumentString decorate catchEnvironment dirname
# Requires: chmod chown
directoryRequire() {
  local handler="_${FUNCNAME[0]}"

  local mode=() owner="" directories=() noun="directory" output=""

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
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --owner)
      shift
      owner=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      [ "$owner" != "-" ] || owner=""
      ;;
    --mode)
      shift
      mode=("$argument" "$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      [ "${mode[1]}" != "-" ] || mode=()
      ;;
    --noun)
      shift
      noun=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --output)
      shift
      output=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    *)
      local name="$argument"
      if [ -d "$name" ]; then
        [ 0 -eq "${#mode[@]}" ] || catchEnvironment "$handler" chmod "${mode[1]}" "$name" || return $?
      else
        catchEnvironment "$handler" mkdir -p "${mode[@]+"${mode[@]}"}" "$name" || return $?
      fi
      [ -z "$owner" ] || catchEnvironment "$handler" chown "$owner" "$name" || return $?
      directories+=("$name")
      [ -z "$output" ] || name="$output"
      printf "%s\n" "$name"
      output=""
      ;;
    esac
    shift
  done
  [ ${#directories[@]} -gt 0 ] || throwArgument "$handler" "Need at least one $noun" || return $?
}
_directoryRequire() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: directory - Directory. Optional. Directory to check if empty.
# Does a directory exist and is it empty?
# Return Code: 2 - Directory does not exist
# Return Code: 1 - Directory is not empty
# Return Code: 0 - Directory is empty
directoryIsEmpty() {
  local handler="_${FUNCNAME[0]}"
  local argument

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
      [ -d "$argument" ] || throwArgument "$handler" "Not a directory $(decorate code "$argument")" || return $?
      find "$argument" -mindepth 1 -maxdepth 1 | read -r && return 1 || return 0
      ;;
    esac
  done
}
_directoryIsEmpty() {
  # __IDENTICAL__ usageDocument 1
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
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
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
_directoryRelativePath() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  # __IDENTICAL__ usageDocument 1
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
  local handler="${1-}" && shift

  local testExpression directory lastDirectory="" passed passedExpression failedExpression
  local startingDirectory="" filePattern="" testExpressions=() bestFailure=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --pattern)
      [ -z "$filePattern" ] || throwArgument "$handler" "$argument already specified" || return $?
      shift
      filePattern=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --test)
      shift
      testExpressions+=("$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    *)
      [ -z "$startingDirectory" ] || throwArgument "$handler" "startingDirectory $(decorate code "$argument") was already specified $(decorate value "$startingDirectory") (Arguments: $(decorate each code "${handler#_}" "${__saved[@]}"))" || return $?
      [ -n "$argument" ] || argument=$(catchEnvironment "$handler" pwd) || return $?
      startingDirectory=$(usageArgumentRealDirectory "$handler" startingDirectory "$argument") || return $?
      ;;
    esac
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
      [ "$testExpression" != "${testExpression#-}" ] || throwArgument "$handler" "Invalid expression: $(decorate code "$testExpression") (Arguments: $(decorate each code "${handler#_}" "${__saved[@]}"))" || return $?
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
  throwEnvironment "$handler" "$bestFailure" || return $?
  return 1
}
