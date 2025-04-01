#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Depends on no other .sh files
# Shell Dependencies: awk sed date echo sort printf
#
# Docs: contextOpen ./documentation/source/tools/url.md
# Test: contextOpen ./test/tools/url-tests.sh
#
# ##############################################################################
#
#   _   _ ____  _
#  | | | |  _ \| |
#  | | | | |_) | |
#  | |_| |  _ <| |___
#   \___/|_| \_\_____|
#
#------------------------------------------------------------------------------
#

#
# Simplistic URL parsing. Converts a `url` into values which can be parsed or evaluated:
#
# - `url` - URL
# - `host` - Database host
# - `user` - Database user
# - `password` - Database password
# - `port` - Database port
# - `name` - Database name
#
# Does little to no validation of any characters so best used for well-formed input.
#
# Now works on multiple URLs, output is separated by a blank line for new entries
#
# Exit Code: 0 - If parsing succeeds
# Exit Code: 1 - If parsing fails
# Summary: Simple Database URL Parsing
# Usage: urlParse url
# Argument: url - a Uniform Resource Locator used to specify a database connection
# Example:     eval "$(urlParse scheme://user:password@host:port/path)"
# Example:     echo $name
urlParse() {
  local usage="_${FUNCNAME[0]}"

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
        local u="${1-}"

        # parts
        local url="$u" path="" name="" user="" password="" host="" port="" error=""
        local scheme="${u%%://*}"

        if [ "$scheme" != "$url" ] && [ -n "$scheme" ]; then
          # Have a scheme
          u="${u#*://}"
          # u is user:pass@host:port/path...
          # path
          name="${u#*/}"
          if [ "$name" != "$u" ]; then
            path="/$name"
          else
            path="/"
            name=""
          fi
          u="${u%%/*}"
          # u now possibly: user:pass@host:port
          host="${u##*@}"
          if [ "$host" = "$u" ]; then
            user=""
            password=""
          else
            user="${u%@*}"
            password="${user#*:}"
            if [ "$password" = "$user" ]; then
              password=""
            else
              user="${user%%:*}"
            fi
          fi
          port="${host##*:}"
          if [ "$port" = "$host" ]; then
            port=""
          else
            host="${host%:*}"
          fi
          error=""
        else
          error="no-scheme"
          scheme=""
        fi
        for v in url path name scheme user password host port error; do
          printf "%s=%s\n" "$v" "$(quoteBashString "${!v}")"
        done
        printf -- "\n"
        : "$path" # usage warning
        # Exit code 1 if failed
        [ -z "$error" ] || return 1
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_urlParse() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Gets the component of one or more URLs
# Summary: Get a database URL component directly
# Usage: urlParseItem component url0 [ url1 ... ]
# Argument: url0 - String. URL. Required. A Uniform Resource Locator used to specify a database connection
# Argument: component - the url component to get: `name`, `user`, `password`, `host`, `port`, `failed`
# Example:     decorate info "Connecting as $(urlParseItem user "$url")"
#
urlParseItem() {
  local usage="_${FUNCNAME[0]}"

  [ $# -ge 2 ] || __throwArgument "$usage" "Need at least one URL" || return $?

  local component="" url=""

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
        if [ -z "$component" ]; then
          component=$(usageArgumentString "$usage" "component" "$1") || return $?
        else
          url="$1"
          # subshell hides variable scope
          (
            local url path name scheme user password host port error=""
            eval "$(urlParse "$url")" || __throwArgument "$usage" "Unable to parse $url" || return $?
            [ -z "$error" ] || __throwArgument "$usage" "Unable to parse $(decorate code "$url"): $(decorate error "$error")" || return $?
            printf "%s\n" "${!component-}"
          ) || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_urlParseItem() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Checks a URL is valid
# Usage: {fn} url ...
# Argument: url ... - String. URL. Required. A Uniform Resource Locator
urlValid() {
  [ $# -gt 0 ] || return 1

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
        urlParse "$1" >/dev/null || return 1
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}

# Open URLs which appear in a stream
# (but continue to output the stream)
# Argument: --exec - Executable. Optional. If not supplied uses `urlOpen`.
# stdin: text
# stdout: text
urlOpener() {
  local usage="_${FUNCNAME[0]}"

  local binary=""

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
      --exec)
        shift
        binary=$(usageArgumentExecutable "$usage" "$argument" "${1-}") || return $?
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$binary" ] || binary="urlOpen"

  local line
  while read -r line; do
    printf -- "%s\n" "$line"
    printf -- "%s\n" "$line" | urlFilter | "$binary"
  done
}
_urlOpener() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} url prefix lineNumber debugFlag
_urlExtract() {
  local match foundPrefix minPrefix="" url="${1-}" prefix="$2" lineNumber="$3" debugFlag="${4-false}"
  for match in 'https://*' 'http://*'; do
    # We WANT this to match as a pattern: SC2295
    # shellcheck disable=SC2295
    foundPrefix="${line%%$match}"
    if [ "$foundPrefix" != "$line" ]; then
      if [ -z "$minPrefix" ]; then
        minPrefix="$foundPrefix"
      elif [ "${#minPrefix}" -gt "${#foundPrefix}" ]; then
        minPrefix="$foundPrefix"
      fi
    fi
  done
  if [ -z "$minPrefix" ]; then
    return 1
  fi
  line="${line:${#minPrefix}}"
  local find="[\"']"
  line="${line//$find/ }"
  ! $debugFlag || printf -- "%s [%s] %s\n" "MATCH LINE CLEAN:" "$(decorate value "$lineNumber")" "$(decorate code "$line")"
  until [ -z "$line" ]; do
    IFS=" " read -r url remain <<<"$line" || :
    url=${url%\"*}
    url=${url%\'*}
    if [ "$url" != "${url#http}" ] && urlValid "$url"; then
      printf "%s%s\n" "$prefix" "$url"
    elif $debugFlag; then
      printf -- "%s [%s] %s\n" "! urlValid:" "$(decorate value "$lineNumber")" "$(decorate code "$url")"
    fi
    line="$remain"
  done
}

# Open URLs which appear in a stream
# Usage: {fn} [ file ]
# Usage: {fn} [ --show-file ] [ --file name ] [ file ]
# Argument: --show-file - Boolean. Optional. Show the file name in the output (suffix with `: `)
# Argument: --file name - String. Optional. The file name to display - can be any text.
# Argument: file - File. Optional. A file to read and output URLs found.
# stdin: text
# stdout: line:URL
# Takes a text file and outputs any `https://` or `http://` URLs found within.
# URLs are explicitly trimmed at quote, whitespace and escape boundaries.
urlFilter() {
  local usage="_${FUNCNAME[0]}"

  local files=() file="" aa=() showFile=false debugFlag=false

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
      --show-file)
        aa=("$argument")
        showFile=true
        ;;
      --debug)
        debugFlag=true
        ;;
      --file)
        shift
        file="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      *)
        files+=("$(usageArgumentFile "$usage" "file" "$1")") || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  if [ "${#files[@]}" -gt 0 ]; then
    for file in "${files[@]}"; do
      # shellcheck disable=SC2094
      urlFilter "${aa[@]+"${aa[@]}"}" --file "$file" <"$file"
    done
    return 0
  fi

  local line prefix="" lineNumber=0
  if $showFile && [ -n "$file" ]; then
    prefix="$file: "
  fi
  stripAnsi | while IFS="" read -r line; do
    lineNumber=$((lineNumber + 1))
    _urlExtract "$line" "$prefix" "$lineNumber" "$debugFlag" || :
  done
}
_urlFilter() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Open a URL using the operating system
# Usage {fn} [ --help ]
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --ignore - Optional. Flag. Ignore any invalid URLs found.
# Argument: --wait - Optional. Flag. Display this help.
# Argument: --url url - Optional. URL. URL to download.
# stdin: line:URL
# stdout: none
urlOpen() {
  local usage="_${FUNCNAME[0]}"

  local urls=() waitFlag=false ignoreFlag=false

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
      --ignore)
        ignoreFlag=true
        ;;
      --wait)
        waitFlag=true
        ;;
      *)
        urls+=("$(usageArgumentString "$usage" "url" "$1")") || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local url exitCode
  if [ ${#urls[@]} -eq 0 ]; then
    # stdin mode
    while IFS=' ' read -d$'\n' -r url; do
      exitCode=0
      __urlOpenInnerLoop "$usage" "$url" "$ignoreFlag" "$waitFlag" || exitCode=$?
      if [ "$exitCode" != 0 ]; then
        if [ "$exitCode" != 120 ]; then
          return $exitCode
        fi
        urls+=("$url")
      fi
    done
  else
    # cli mode
    set - "${urls[@]}"
    urls=()
    while [ $# -gt 0 ]; do
      url="$1"
      exitCode=0
      __urlOpenInnerLoop "$usage" "$url" "$ignoreFlag" "$waitFlag" || exitCode=$?
      if [ "$exitCode" != 0 ]; then
        if [ "$exitCode" != 120 ]; then
          return $exitCode
        fi
        urls+=("$url")
      fi
      shift
    done
  fi
  $waitFlag || [ "${#urls[@]}" -eq 0 ] || __catchEnvironment "$usage" __urlOpen "${urls[@]}" || return $?
  return 0
}
_urlOpen() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__urlOpenInnerLoop() {
  local usage="$1" url="$2" ignoreFlag="$3" waitFlag="$4"
  if ! urlValid "$url"; then
    if ! $ignoreFlag; then
      __throwEnvironment "$usage" "Invalid URL: $(decorate error "$url")" || return $?
    fi
    return 0
  fi
  if $waitFlag; then
    __catchEnvironment "$usage" __urlOpen "$url" || return $?
  else
    return 120
  fi
}

# IDENTICAL urlFetch 128

# Fetch URL content
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --header header - String. Optional. Send a header in the format 'Name: Value'
# Argument: --wget - Flag. Optional. Force use of wget. If unavailable, fail.
# Argument: --curl - Flag. Optional. Force use of curl. If unavailable, fail.
# Argument: --binary binaryName - Callable. Use this binary instead. If the base name of the file is not `curl` or `wget` you MUST supply `--argument-format`.
# Argument: --argument-format format - Optional. String. Supply `curl` or `wget` for parameter formatting.
# Argument: --user userName - Optional. String. If supplied, uses HTTP Simple authentication. Usually used with `--password`. Note: User names may not contain the character `:` when using `curl`.
# Argument: --password password - Optional. String. If supplied along with `--user`, uses HTTP Simple authentication.
# Argument: url - Required. URL. URL to fetch to target file.
# Argument: file - Required. FileDirectory. Target file.
# Requires: _return whichExists printf decorate
# Requires: usageArgumentString
# Requires: __throwArgument __catchArgument
# Requires: __throwEnvironment __catchEnvironment
urlFetch() {
  local usage="_${FUNCNAME[0]}"

  local wgetArgs=() curlArgs=() headers wgetExists binary="" userHasColons=false user="" password="" format="" url="" target=""

  wgetExists=$(whichExists wget && printf true || printf false)

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
      --header)
        shift
        local name value
        name="${1%%:}"
        value="${1#*:}"
        if [ "$name" = "$1" ] || [ "$value" = "$1" ]; then
          __catchArgument "$usage" "Invalid $argument $1 passed" || return $?
        fi
        headers+=("$1")
        curlArgs+=("--header" "$1")
        wgetArgs+=("--header=$1")
        ;;
      --wget)
        binary="wget"
        ;;
      --curl)
        binary="curl"
        ;;
      --binary)
        shift
        binary=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        whichExists "$binary" || __throwArgument "$usage" "$binary must be in PATH: $PATH" || return $?
        ;;
      --argument-format)
        format=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        case "$format" in curl | wget) ;; *) __throwArgument "$usage" "$argument must be curl or wget" || return $? ;; esac
        ;;
      --password)
        shift
        password="$1"
        ;;
      --user)
        shift
        user=$(usageArgumentString "$usage" "$argument (user)" "$user") || return $?
        if [ "$user" != "${user#*:}" ]; then
          userHasColons=true
        fi
        curlArgs+=(--user "$user:$password")
        wgetArgs+=("--http-user=$user" "--http-password=$password")
        genericArgs+=("$argument" "$1")
        ;;
      --agent)
        shift
        local agent="$1"
        [ -n "$agent" ] || __throwArgument "$usage" "$argument must be non-blank" || return $?
        wgetArgs+=("--user-agent=$1")
        curlArgs+=("--user-agent" "$1")
        genericArgs+=("$argument" "$1")
        ;;
      *)
        if [ -z "$url" ]; then
          url="$1"
        elif [ -z "$target" ]; then
          target="$1"
          shift
          break
        else
          # _IDENTICAL_ argumentUnknown 1
          __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  if [ -n "$user" ]; then
    curlArgs+=(--user "$user:$password")
    wgetArgs+=("--http-user=$user" "--http-password=$password")
    genericArgs+=("--user" "$user" "--password" "$password")
  fi
  if [ "$binary" = "curl" ] && $userHasColons; then
    __throwArgument "$usage" "$argument: Users ($argument \"$(decorate code "$user")\") with colons are not supported by curl, use wget" || return $?
  fi
  if [ -z "$binary" ]; then
    if $wgetExists; then
      binary="wget"
    elif whichExists "curl"; then
      binary="curl"
    fi
  fi
  [ -n "$binary" ] || __throwEnvironment "$usage" "wget or curl required" || return $?
  [ -n "$format" ] || format="$binary"
  case "$format" in
    wget) __catchEnvironment "$usage" "$binary" -q --output-document="$target" --timeout=10 "${wgetArgs[@]+"${wgetArgs[@]}"}" "$url" "$@" || return $? ;;
    curl) __catchEnvironment "$usage" "$binary" -L -s "$url" "$@" -o "$target" "${curlArgs[@]+"${curlArgs[@]}"}" || return $? ;;
    *) __throwEnvironment "$usage" "No handler for binary format $(decorate value "$format") (binary is $(decorate code "$binary")) $(decorate each value "${genericArgs[@]}")" || return $? ;;
  esac
}
_urlFetch() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__urlOpen() {
  local usage="${FUNCNAME[0]#_}" binary

  binary=$(__catchEnvironment "$usage" buildEnvironmentGet BUILD_URL_BINARY) || return $?
  if [ -z "$binary" ]; then
    while IFS='' read -d$'\n' -r binary; do
      if whichExists "$binary"; then
        break
      fi
    done < <(__catchEnvironment "$usage" __urlBinary) || return $?
    if [ -z "$binary" ]; then
      printf "%s %s\n" "OPEN: " "$(consoleLink "$url")"
      return 0
    fi
  else
    binary=$(usageArgumentExecutable "$usage" "BUILD_URL_BINARY" "$binary") || return $?
  fi
  [ $# -gt 0 ] || __catchArgument "$usage" "Require at least one URL" || return $?
  __environment "$binary" "$@" || return $?
}
