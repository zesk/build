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
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  localSize=$(__catchEnvironment "$usage" fileSize "$file") || return $?
  remoteSize=$(__catchEnvironment "$usage" urlContentLength "$url") || return $?
  localSize=$((localSize + 0))
  isPositiveInteger "$remoteSize" || __throwEnvironment "$usage" "Remote size is not integer: $(decorate value "$remoteSize")" || return $?

  [ "$localSize" -eq "$remoteSize" ]
}
_urlMatchesLocalFileSize() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get the size of a remote URL
# Depends: curl
#
urlContentLength() {
  local usage="_${FUNCNAME[0]}"
  local url remoteSize
  local tempFile

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
        url=$(usageArgumentURL "$usage" "url" "$1")
        tempFile=$(fileTemporaryName "$usage") || return $?
        __catchEnvironment "$usage" curl -s -I "$url" >"$tempFile" || _clean $? "$tempFile" || return $?
        remoteSize=$(grep -q -i 'Content-Length' "$tempFile" | awk '{ print $2 }') || __throwEnvironment "$usage" "Remote URL did not return Content-Length" || return $?
        printf "%d\n" $((remoteSize + 0))
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_urlContentLength() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List IPv4 Addresses associated with this system using `ifconfig`
# Output: lines:IPv4
# Argument: --install - Flag. Optional. Install any packages required to get `ifconfig` installed first.
# Argument: --help - Flag. Optional. This help.
hostIPList() {
  local usage="_${FUNCNAME[0]}"

  export OSTYPE

  __catchEnvironment "$usage" buildEnvironmentLoad OSTYPE || return $?

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
      --install)
        __catchEnvironment "$usage" packageWhich ifconfig net-tools || return $?
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  case "$(lowercase "$OSTYPE")" in
    linux) ifconfig | grep 'inet addr:' | cut -f 2 -d : | trimSpace | cut -f 1 -d ' ' ;;
    linux-gnu | darwin* | freebsd*) ifconfig | grep 'inet ' | trimSpace | cut -f 2 -d ' ' ;;
    *) __throwEnvironment "$usage" "hostIPList Unsupported OSTYPE \"$OSTYPE\"" || return $? ;;
  esac
}
_hostIPList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Fetch Time to First Byte and other stats
hostTTFB() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  curl -L -s -o /dev/null -w "connect=%{time_connect}\n""ttfb: %{time_starttransfer}\n""total: %{time_total} \n" "$@"
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
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  logFile=$(__catchEnvironment "$usage" buildQuietLog "$usage.$$.log") || return $?
  progressFile=$(__catchEnvironment "$usage" buildQuietLog "$usage.$$.progress.log") || return $?

  __catchEnvironment "$usage" packageWhich wget wget || return $?

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
  ) || _clean $? "$logFile" || return $?
  statusMessage decorate success "Launched scraping process $(decorate code "$pid") ($progressFile)"
  _watchFile "$progressFile"
}
_websiteScrape() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
