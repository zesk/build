#!/usr/bin/env bash
#
# Log file management
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Depends: documentation.sh colors.sh
# bin: find
# Docs: o ./documentation/source/tools/log.md
# Test: o ./test/tools/log-tests.sh

#
# Usage: {fn} [ --dry-run ] logFile count
# Argument: logFile - Required. A log file which exists.
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
# But maintains file` descriptors for `logFile`.
#
rotateLog() {
  local this="${FUNCNAME[0]}"
  local handler="_$this"

  local logFile="" count="" dryRun=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --dry-run)
      dryRun=true
      ;;
    *)
      if [ -z "$logFile" ]; then
        logFile="$argument"
      elif [ -z "$count" ]; then
        count="$argument"
      else
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  logFile="$(usageArgumentFile _rotateLog logFile "$logFile")" || return $?

  isInteger "$count" || __throwArgument "$handler" "$this count $(decorate value "$count") must be a positive integer" || return $?
  [ "$count" -gt 0 ] || __throwArgument "$handler" "$this count $(decorate value "$count") must be a positive integer greater than zero" || return $?

  local index="$count"
  if [ "$count" -gt 1 ]; then
    if [ -f "$logFile.$count" ]; then
      if "$dryRun"; then
        printf "%s \"%s\"\n" rm "$(escapeDoubleQuotes "$logFile.$count")"
      else
        rm "$logFile.$count" || __throwEnvironment "$handler" "$this Can not remove $logFile.$count" || return $?
      fi
    fi
  fi

  index=$((index - 1))
  while [ "$index" -ge 1 ]; do
    if [ -f "$logFile.$index" ]; then
      if "$dryRun"; then
        printf "%s \"%s\" \"%s\"\n" mv "$(escapeDoubleQuotes "$logFile.$index")" "$(escapeDoubleQuotes "$logFile.$((index + 1))")"
      else
        mv "$logFile.$index" "$logFile.$((index + 1))" || __throwEnvironment "$handler" "$this Failed to mv $logFile.$index -> $logFile.$((index + 1))" || return $?
      fi
    fi
    index=$((index - 1))
  done

  index=1
  if "$dryRun"; then
    printf "%s \"%s\" \"%s\"\n" cp "$(escapeDoubleQuotes "$logFile")" "$(escapeDoubleQuotes "$logFile.$index")"
    printf "printf \"\">\"%s\"\n" "$(escapeDoubleQuotes "$logFile")"
  else
    cp "$logFile" "$logFile.$index" || __throwEnvironment "$handler" "$this Failed to copy $logFile $logFile.$index" || return $?
    printf "" >"$logFile" || __throwEnvironment "$handler" "$this Failed to truncate $logFile" || return $?
  fi
}
_rotateLog() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} [ --dry-run ] logPath count
# Argument: logPath - Required. Path where log files exist.
# Argument: count - Required. Integer of log files to maintain.
# Rotate log files
# For all log files in logPath with extension `.log`, rotate them safely
rotateLogs() {
  local handler="_${FUNCNAME[0]}"

  local logPath="" count="" dryRunArgs=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --dry-run)
      dryRunArgs=(--dry-run)
      ;;
    *)
      if [ -z "$logPath" ]; then
        logPath="$(usageArgumentDirectory "$handler" logPath "$logPath") || return $?"
      elif [ -z "$count" ]; then
        count="$(usageArgumentPositiveInteger "$handler" "count" "$argument")" || return $?
      else
        __throwArgument "$handler" "$this Unknown argument $argument" || return $?
      fi
      ;;
    esac
    shift
  done
  [ -z "$logPath" ] || __throwArgument "$handler" "missing logPath" || return $?
  [ -z "$count" ] || __throwArgument "$handler" "missing count" || return $?

  statusMessage decorate info "Rotating log files in path $(decorate file "$logPath")"
  find "$logPath" -type f -name '*.log' ! -path "*/.*/*" | while IFS= read -r logFile; do
    statusMessage decorate info "Rotating log file $logFile" || :
    __catchEnvironment "$handler" rotateLog "${dryRunArgs[@]+${dryRunArgs[@]}}" "$logFile" "$count" || return $?
  done
  statusMessage --last decorate info "Rotated log files in path $(decorate file "$logPath")"
}
_rotateLogs() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
