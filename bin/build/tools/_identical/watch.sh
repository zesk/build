#!/usr/bin/env bash
#
# Watching identical
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# In case you forgot, the directory in which this file is named `_identical` and *NOT* `identical`.

# Argument: --prefix prefix - Required. String. A text prefix to search for to identify identical sections (e.g. `# IDENTICAL`) (may specify more than one)
# Argument: file ... - Required. File. A file to search for identical tokens.
# stdout: tokens, one per line
identicalFindTokens() {
  local handler="_${FUNCNAME[0]}"
  local prefixes=() files=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --prefix)
      shift
      prefixes+=("$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    *)
      files+=("$(usageArgumentFile "$handler" "$argument" "${1-}")") || return $?
      ;;
    esac
    shift
  done

  [ "${#prefixes[@]}" -gt 0 ] || __throwArgument "$handler" "Need at least one prefix" || return $?
  [ "${#files[@]}" -gt 0 ] || __throwArgument "$handler" "Need at least one file" || return $?

  foundLines=$(fileTemporaryName "$handler") || return $?

  if cat "${files[@]}" | __identicalFindPrefixes "${prefixes[@]}" | __identicalReplacePrefixes "PREFIX" "${prefixes[@]}" | awk '{ print $2 }' | sort -u >>"$foundLines"; then
    cat "$foundLines"
  fi
  __catchEnvironment "$handler" rm -f "$foundLines" || return $?
}
_identicalFindTokens() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__identicalFindPrefixes() {
  local patterns=()
  while [ $# -gt 0 ]; do
    local extendedPattern
    extendedPattern="^\s*$(quoteGrepPattern "$1")\s\s*[-a-zA-Z0-9_.][-a-zA-Z0-9_.]*\s\s*(\S*)"
    patterns+=("-e" "$extendedPattern")
    shift
  done
  if ! grep -E -n "${patterns[@]}"; then
    return 1
  fi
}

__identicalReplacePrefixes() {
  local aa=() replace="${1-}" && shift

  replace=$(quoteSedReplacement "$replace")
  while [ $# -gt 0 ]; do
    aa+=("-e" "s/[[:space:]]*$(quoteSedPattern "$1")/$replace/1")
    shift
  done
  sed "${aa[@]}"
}

__identicalWatchDecorateDate() {
  decorate magenta "$(dateFromTimestamp "$1")"
}

# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
#
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: ... - Arguments. Required. Arguments to `identicalCheck` for your watch.
# Watch a project for changes and propagate them immediately upon save. Can be quite dangerous so use with caution.
# Still a known bug which trims the last end bracket from files
identicalWatch() {
  local handler="_${FUNCNAME[0]}"

  local repairSources=()
  local findArgs=() rootDir="" days="" debugFlag=false

  local ff=() rr=() justTokens=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --ignore-singles)
      rr+=("$argument")
      ;;
    --watch)
      : "Do nothing"
      ;;
    --repair)
      shift
      rr+=("$argument" "${1-}")
      repairSources+=("$(usageArgumentDirectory "$handler" "$argument" "${1-}")") || return $?
      ;;
    --cd)
      shift
      rootDir=$(usageArgumentDirectory "$handler" "$argument" "${1-}") || return $?
      rr+=("$argument" "${1-}")
      ;;
    --token)
      shift
      justTokens+=("$argument" "${1-}")
      rr+=("$argument" "${1-}")
      ;;
    --exec | --skip | --singles | --single | --exclude)
      shift
      rr+=("$argument" "${1-}")
      ;;
    --prefix)
      shift
      ff+=("$argument" "${1-}")
      rr+=("$argument" "${1-}")
      ;;
    --debug)
      debugFlag=true
      rr+=("$argument")
      ;;
    --no-map)
      rr+=("$argument")
      ;;
    --extension)
      shift
      rr+=("$argument" "${1-}")
      findArgs+=("-name" "*.$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    --days)
      shift && days=$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}") || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  [ -n "$rootDir" ] || rootDir=$(__catch "$handler" buildHome) || return $?

  local fileList finished=false lastTimestamp="" lastFile=""

  local newerThanThisTime clean=()

  newerThanThisTime=$(($(date +%s) - (86400 * days)))
  fileList=$(fileTemporaryName "$handler")
  clean+=("$fileList")
  statusMessage decorate info "Watching $(decorate file "$rootDir") ..."
  while ! $finished; do
    local why=0
    __identicalWatchLoop "$handler" "$fileList" "$rootDir" "$lastTimestamp" "$lastFile" "${findArgs[@]+"${findArgs[@]}"}" || why=$?
    case "$why" in
    0)
      if [ -z "$lastTimestamp" ] && [ -z "$days" ]; then
        read -r lastTimestamp lastFile <"$fileList" || :
        statusMessage decorate info "Starting at most recently modified file $(decorate file "$lastFile") ..."
        files+=("$lastFile")
      else
        statusMessage decorate success "Files changed ..."
        local files=() currentTimestamp currentFile
        while read -r currentTimestamp currentFile; do
          if [ -n "$lastTimestamp" ] && [ "$currentTimestamp" -gt "$lastTimestamp" ]; then
            files+=("$currentFile")
            statusMessage decorate info "Stopping at $currentTimestamp $(decorate file "$currentFile") ($(__identicalWatchDecorateDate "$currentTimestamp") > $(__identicalWatchDecorateDate "$lastTimestamp"))"
            break
          fi
          if [ -n "$days" ] && [ "$currentTimestamp" -lt "$newerThanThisTime" ]; then
            statusMessage decorate info "Stopping at $currentFile as it's older than $(__identicalWatchDecorateDate "$newerThanThisTime")"
            break
          fi
          statusMessage decorate info "Processing $(decorate file "$currentFile") $(__identicalWatchDecorateDate "$currentTimestamp")"
          files+=("$currentFile")
        done <"$fileList"
        if [ "${#files[@]}" -gt 0 ]; then
          local tokens=()
          if [ "${#justTokens[@]}" -gt 0 ]; then
            tokens=("${justTokens[@]}")
          else
            while read -r token; do
              tokens+=("--token" "$token")
            done < <(identicalFindTokens "${ff[@]}" "${files[@]}")
          fi
          if [ "${#tokens[@]}" -gt 0 ]; then
            ! $debugFlag || statusMessage decorate info "Replacing tokens $(decorate each code -- "${tokens[@]}")"
            __catch "$handler" identicalCheck "${rr[@]}" "${tokens[@]}" || return $?
          else
            statusMessage decorate info "No tokens found in $(decorate each file -- "${files[@]}")"
          fi
        fi
        read -r lastTimestamp lastFile <"$fileList" || :
      fi
      statusMessage decorate info "New state is: $(decorate file "$lastFile") $(__identicalWatchDecorateDate "$lastTimestamp")"
      ;;
    3) finished=true ;;
    *) return "$why" ;;
    esac
    __catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
  done

  # read file and mod date, one per
  # for file - find tokens found in file
  # replace all tokens, each uniquely since start
  # next file until we find our saved file name or end of list
  # update top mod date and file name
  # done - next loop watches most recently modified and compares to our file, if it fails - repeat
}
_identicalWatch() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__identicalWatchLoop() {
  local handler="${1-}" && shift
  local fileList="${1-}" && shift
  local rootDir="${1-}" && shift
  local lastTimestamp="${1-}" && shift
  local lastFile="${1-}" && shift

  local running=true
  while $running; do
    printf -- "" >"$fileList"
    start=$(timingStart)
    __catchEnvironment "$handler" fileModificationTimes "$rootDir" "$@" | sort -rn >>"$fileList" || return $?
    elapsed=$(($(timingStart) - start))

    local newTimestamp newFile
    read -r newTimestamp newFile <"$fileList" || :

    if [ "$newTimestamp" != "$lastTimestamp" ] || [ "$newFile" != "$lastFile" ]; then
      return 0
    fi

    elapsed=$(((elapsed + 999) / 1000))
    statusMessage decorate info "$(decorate subtle "$(date +%T)"): Sleeping for $elapsed $(plural $elapsed second seconds) $(decorate file "$lastFile") modified $(__identicalWatchDecorateDate "$lastTimestamp") ..."
    __catchEnvironment "$handler" sleep "$elapsed" || return $?
  done
}
