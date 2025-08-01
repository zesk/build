#!/usr/bin/env bash
#
# Web protocol tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Compare a remote file size with a local file size
# Usage: {fn} url file
# Argument: url - Required. URL. URL to check.
# Argument: file - Required. File. File to compare.
urlMatchesLocalFileSize() {
  local usage="_${FUNCNAME[0]}"

  local url file remoteSize localSize

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
    *)
      if [ -z "$url" ]; then
        url=$(usageArgumentString "$usage" "url" "$1") || return $?
      elif [ -z "$file" ]; then
        file="$(usageArgumentFile "$usage" "file" "$1")" || return $?
      else
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  localSize=$(__catch "$usage" fileSize "$file") || return $?
  remoteSize=$(__catch "$usage" urlContentLength "$url") || return $?
  localSize=$((localSize + 0))
  isPositiveInteger "$remoteSize" || __throwEnvironment "$usage" "Remote size is not integer: $(decorate value "$remoteSize")" || return $?

  [ "$localSize" -eq "$remoteSize" ]
}
_urlMatchesLocalFileSize() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get the size of a remote URL
# Depends: curl
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: url - Required. URL. URL to fetch the Content-Length.
urlContentLength() {
  local handler="_${FUNCNAME[0]}"
  local url remoteSize
  local tempFile

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ argumentBlankCheck 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    *)
      local tempFile
      tempFile=$(fileTemporaryName "$handler") || return $?
      url=$(usageArgumentURL "$handler" "url" "$1") || return $?
      __catchEnvironment "$handler" curl -s -I "$url" >"$tempFile" || returnClean $? "$tempFile" || return $?
      remoteSize=$(grep -i 'Content-Length' "$tempFile" | awk '{ print $2 }') || __throwEnvironment "$handler" "Remote URL did not return Content-Length" || returnClean $? "$tempFile" || return $?
      __catch "$handler" rm -f "$tempFile" || return $?
      remoteSize="$(trimSpace "$remoteSize")"
      isUnsignedInteger "$remoteSize" || __throwEnvironment "$handler" "Remote content length was non-integer: $remoteSize" || return $?
      printf "%d\n" $((remoteSize + 0))
      ;;
    esac
    shift
  done
}
_urlContentLength() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Fetch Time to First Byte and other stats
# Argument: url - URL. Required. URL to check.
hostTTFB() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  curl -L -s -o /dev/null -w "connect=%{time_connect}\n""ttfb: %{time_starttransfer}\n""total: %{time_total} \n" "$@"
}
_hostTTFB() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_watchFile() {
  decorate info "Watching $1"
  while IFS='' read -r line; do
    if [ "${line}" != "${line#--}" ]; then
      line=$(trimSpace "${line##.*--}")
      statusMessage --last decorate green "$line"
    fi
  done
}

#
# Usage: {fn} siteURL
# Untested: true
# Uses wget to fetch a site, convert it to HTML nad rewrite it for local consumption
# SIte is stored in a directory called `host` for the URL requested
# This is not final yet and may not work properly.
websiteScrape() {
  local usage="_${FUNCNAME[0]}"
  local logFile pid progressFile aa

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
    *)
      url=$(usageArgumentURL "$usage" "url" "$1") || return $?
      break
      ;;
    esac
    shift
  done

  logFile=$(__catch "$usage" buildQuietLog "$usage.$$.log") || return $?
  progressFile=$(__catch "$usage" buildQuietLog "$usage.$$.progress.log") || return $?

  __catch "$usage" packageWhich wget wget || return $?

  aa=()
  aa+=(-e robots=off)
  aa+=(-R "zip,exe")
  aa+=(--no-check-certificate)
  aa+=(--user-agent="Mozilla/4.0 (compatible; MSIE 10.0; Windows NT 5.1)")
  aa+=(-r --level=5 -t 10 --random-wait --force-directories --html-extension)
  aa+=(--no-parent --convert-links --backup-converted --page-requisites)
  pid=$(
    wget "${aa[@]}" "$url" 2>&1 | tee "$logFile" | grep -E '^--' >"$progressFile" &
    printf "%d" $!
  ) || returnClean $? "$logFile" || return $?
  statusMessage decorate success "Launched scraping process $(decorate code "$pid") ($progressFile)"
  _watchFile "$progressFile"
}
_websiteScrape() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
