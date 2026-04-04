#!/usr/bin/env bash
#
# Log file management
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Depends: documentation.sh colors.sh
# bin: find
# Docs: o ./documentation/source/tools/log.md
# Test: o ./test/tools/log-tests.sh

# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: --dry-run - Flag. Optional. Do not change anything.
# Argument: --cull cullCount - UnsignedInteger. Optional. Delete log file indexes which exist beyond the `count`. Default is `0`.
# Argument: logFile - File. Required. A log file which exists.
# Argument: count - PositiveInteger. Required. Integer of log file backups to maintain.
# Summary: Rotate a log file
# Rotates a log file by adding a digit to the end numerically, and moves logs such that the most recent
# log backup suffix is `.1` and the oldest log backup suffix is `.count`.
#
# Backs up files as:
#
#     logFile
#     logFile.1
#     logFile.2
#     logFile.3
#
# `--cull` will delete `cullCount` files in addition to the backup files if they exist. This is useful if you change this number
# from a higher to a lower number and want the extra files deleted.
#
# But maintains file descriptors for `logFile`.
logRotate() {
  local handler="_${FUNCNAME[0]}"

  local logFile="" count="" dryRun=false cullCount=0

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --dry-run) dryRun=true ;;
    --cull) shift && cullCount="$(validate "$handler" UnsignedInteger "$argument" "${1-}")" || return $? ;;
    *)
      if [ -z "$logFile" ]; then
        logFile="$(validate "$handler" File logFile "$argument")" || return $?
      elif [ -z "$count" ]; then
        count=$(validate "$handler" "PositiveInteger" "count" "$argument")
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  [ -n "$logFile" ] || throwArgument "$handler" "logFile required" || return $?
  [ -n "$count" ] || throwArgument "$handler" "count required" || return $?

  local index="$count"
  if [ "$count" -gt 1 ] || [ "$cullCount" -gt 0 ]; then
    while [ "$index" -le $((count + cullCount)) ]; do
      local f="$logFile.$index"
      index=$((index + 1))
      [ -f "$f" ] || continue
      "$dryRun" && printf "%s \"%s\"\n" rm "$(escapeDoubleQuotes "$f")" || catchReturn "$handler" rm -f "$f" || return $?
    done
    index="$count"
  fi

  index=$((index - 1))
  while [ "$index" -ge 1 ]; do
    local f="$logFile.$index" next="$logFile.$((index + 1))"
    index=$((index - 1))
    [ -f "$f" ] || continue
    "$dryRun" && printf "%s \"%s\" \"%s\"\n" mv "$(escapeDoubleQuotes "$f")" "$(escapeDoubleQuotes "$next")" || catchReturn "$handler" mv -f "$f" "$next" || return $?
  done

  index=1
  if "$dryRun"; then
    printf -- "cp -f \"%s\" \"%s\"\n" "$(escapeDoubleQuotes "$logFile")" "$(escapeDoubleQuotes "$logFile.$index")"
    printf -- "printf \"\">\"%s\"\n" "$(escapeDoubleQuotes "$logFile")"
  else
    cp -f "$logFile" "$logFile.$index" || throwEnvironment "$handler" "Failed to copy $logFile $logFile.$index" || return $?
    printf "" >"$logFile" || throwEnvironment "$handler" "Failed to truncate $logFile" || return $?
  fi
}
_logRotate() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Rotate log files
# For all log files in logPath with extension `.log`, rotate them safely.
# See: logRotate
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: --dry-run - Flag. Optional. Do not change anything.
# Argument: --cull cullCount - UnsignedInteger. Optional. Delete log file indexes which exist beyond the `count`. Default is `0`.
# Argument: logPath - Directory. Required. Path where log files exist. Looks for files which match `*.log`.
# Argument: count - PositiveInteger. Required. Integer of log files to maintain.
logDirectoryRotate() {
  local handler="_${FUNCNAME[0]}"

  local logPath="" count="" rr=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --dry-run) rr=(--dry-run) ;;
    --cull) shift && rr+=("$argument" "${1-}") ;;
    *)
      if [ -z "$logPath" ]; then
        logPath="$(validate "$handler" Directory logPath "$argument")" || return $?
      elif [ -z "$count" ]; then
        count="$(validate "$handler" PositiveInteger "count" "$argument")" || return $?
      else
        throwArgument "$handler" "Unknown argument $argument" || return $?
      fi
      ;;
    esac
    shift
  done
  [ -n "$logPath" ] || throwArgument "$handler" "missing logPath" || return $?
  [ -n "$count" ] || throwArgument "$handler" "missing count" || return $?

  statusMessage decorate info "Rotating log files in path $(decorate file "$logPath")"
  directoryChange "$logPath" find "." -type f -name '*.log' ! -path "*/\.*/*" -print0 | while IFS="" read -d $'\0' -r logFile; do
    logFile="${logPath%/}/${logFile#./}"
    statusMessage decorate info "Rotating log file $logFile" || :
    catchEnvironment "$handler" logRotate "$logFile" "$count" "${rr[@]+"${rr[@]}"}" || return $?
  done
  statusMessage --last decorate info "Rotated log files in path $(decorate file "$logPath")"
}
_logDirectoryRotate() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
