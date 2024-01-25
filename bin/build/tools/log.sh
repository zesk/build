#!/usr/bin/env bash
#
# Log file management
#
# Copyright &copy; 2024 Market Acumen, LLC
#
# Depends: documentation.sh colors.sh
# bin: find
# Docs: o ./docs/_templates/tools/log.md
# Test: o ./test/tools/log-tests.sh

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

#
# Usage: {fn} [ --dry-run ] logPath count
# Argument: logPath - Required. Path where log files exist.
# Argument: count - Required. Integer of log files to maintain.
# Rotate a log file
#
# Backs up files as:
#
#     logFile
#     logFile.1
#     logFile.2
#     logFile.3
#
# But maintains file descriptors for `logFile`.
#
rotateLog() {
  local logFile count index dryRun

  logFile=
  count=
  dryRun=
  while [ $# -gt 0 ]; do
    case "$1" in
      --dry-run) dryRun=1 ;;
      *)
        if [ -z "$logFile" ]; then
          logFile="$1"
        elif [ -z "$count" ]; then
          count="$1"
        else
          _rotateLogUsage "$errorArgument" "${FUNCNAME[0]} Unknown argument $1"
        fi
        ;;
    esac
    shift
  done
  if ! logFile=$(usageArgumentFile _rotateLogUsage logFile "$logFile"); then
    return $?
  fi
  if ! isInteger "$count"; then
    _rotateLogUsage "$errorArgument" "${FUNCNAME[0]} count $count must be a positive integer"
    return $?
  fi
  if [ "$count" -le 0 ]; then
    _rotateLogUsage "$errorArgument" "${FUNCNAME[0]} count $count must be a positive integer greater than zero"
    return $?
  fi

  if [ "$count" -gt 1 ]; then
    index="$count"
    if [ -f "$logFile.$count" ]; then
      if test "$dryRun"; then
        printf "%s \"%s\"\n" rm "$(escapeDoubleQuotes "$logFile.$count")"
      else
        if ! rm "$logFile.$count"; then
          _rotateLogUsage "$errorEnvironment" "${FUNCNAME[0]} Can not remove $logFile.$count"
          return $?
        fi
      fi
    fi
  fi
  index=$((index - 1))
  while [ "$index" -ge 1 ]; do
    if [ -f "$logFile.$index" ]; then
      if test "$dryRun"; then
        printf "%s \"%s\" \"%s\"\n" mv "$(escapeDoubleQuotes "$logFile.$index")" "$(escapeDoubleQuotes "$logFile.$((index + 1))")"
      else
        if ! mv "$logFile.$index" "$logFile.$((index + 1))"; then
          _rotateLogUsage "$errorEnvironment" "${FUNCNAME[0]} Failed to mv $logFile.$index -> $logFile.$((index + 1))"
          return $?
        fi
      fi
    fi
    index=$((index - 1))
  done

  index=1
  if test "$dryRun"; then
    printf "%s \"%s\" \"%s\"\n" cp "$(escapeDoubleQuotes "$logFile")" "$(escapeDoubleQuotes "$logFile.$index")"
    printf "printf \"\">\"%s\"\n" "$(escapeDoubleQuotes "$logFile")"
  else
    if ! cp "$logFile" "$logFile.$index"; then
      _rotateLogUsage "$errorEnvironment" "${FUNCNAME[0]} Failed to copy $logFile $logFile.$index"
      return $?
    fi
    if ! printf "" >"$logFile"; then
      _rotateLogUsage "$errorEnvironment" "${FUNCNAME[0]} Failed to truncate $logFile"
      return $?
    fi
  fi
}
_rotateLogUsage() {
  usageDocument "${BASH_SOURCE[0]}" rotateLog "$@"
}

# Usage: {fn} [ --dry-run ] logPath count
# Argument: logPath - Required. Path where log files exist.
# Argument: count - Required. Integer of log files to maintain.
# Rotate log files
# For all log files in logPath with extension `.log`, rotate them safely
rotateLogs() {
  local logPath count index dryRunArgs

  logPath=
  count=
  dryRunArgs=()
  while [ $# -gt 0 ]; do
    case "$1" in
      --dry-run) dryRunArgs=(--dry-run) ;;
      *)
        if [ -z "$logPath" ]; then
          logPath="$1"
        elif [ -z "$count" ]; then
          count="$1"
        else
          _rotateLogsUsage "$errorArgument" "${FUNCNAME[0]} Unknown argument $1"
        fi
        ;;
    esac
    shift
  done
  if ! logPath=$(usageArgumentDirectory _rotateLogsUsage logPath "$logPath"); then
    return $?
  fi
  if ! isInteger "$count"; then
    _rotateLogsUsage "$errorArgument" "${FUNCNAME[0]} count $count must be an integer"
    return $?
  fi
  if [ "$count" -le 0 ]; then
    _rotateLogUsage "$errorArgument" "${FUNCNAME[0]} count $count must be a positive integer greater than zero"
    return $?
  fi

  statusMessage consoleInfo "Rotating log files in path $logPath"
  find "$logPath" -type f -name '*.log' ! -path '*/.*' | while IFS= read -r logFile; do
    statusMessage consoleInfo "Rotating log file $logFile"
    if ! rotateLog "${dryRunArgs[@]+${dryRunArgs[@]}}" "$logFile" "$count"; then
      return $?
    fi
  done
  clearLine
}
_rotateLogsUsage() {
  usageDocument "${BASH_SOURCE[0]}" rotateLogs "$@"
}
