#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends on no other .sh files
# Shell Dependencies: awk sed date echo sort printf
#
# Docs: contextOpen ./docs/_templates/tools/url.md
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
# Exit Code: 0 - If parsing succeeds
# Exit Code: 1 - If parsing fails
# Summary: Simple Database URL Parsing
# Usage: urlParse url
# Argument: url - a Uniform Resource Locator used to specify a database connection
# Example:     eval "$(urlParse scheme://user:password@host:port/path)"
# Example:     echo $name
#
urlParse() {
  local v u="${1-}"

  # parts
  local url path name scheme user password host port error

  # u is scheme://user:pass@host:port/path...
  url="$u"
  scheme="${u%%://*}"
  user=
  password=
  host=
  port=
  path=
  name=
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
      name=
    fi
    u="${u%%/*}"
    # u now possibly: user:pass@host:port
    host="${u##*@}"
    if [ "$host" = "$u" ]; then
      user=
      password=
    else
      user="${u%@*}"
      password="${user#*:}"
      if [ "$password" = "$user" ]; then
        password=
      else
        user="${user%%:*}"
      fi
    fi
    port="${host##*:}"
    if [ "$port" = "$host" ]; then
      port=
    else
      host="${host%:*}"
    fi
    error=
  else
    error="no-scheme"
    scheme=
  fi

  for v in url path name scheme user password host port error; do
    printf "%s=%s\n" "$v" "$(quoteBashString "${!v}")"
  done
  : "$path" # usage warning
  # Exit code 1 if failed
  [ -z "$error" ]
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
  [ $# -ge 2 ] || __failArgument "$usage" "Need at least one URL" || return $?

  local usage="_${FUNCNAME[0]}"
  local component="" url

  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
            eval "$(urlParse "$url")" || __failArgument "$usage" "Unable to parse $url" || return $?
            [ -z "$error" ] || __failArgument "$usage" "Unable to parse $(decorate code "$url"): $(decorate error "$error")" || return $?
            printf "%s\n" "${!component-}"
          ) || return $?
        fi
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done
}
_urlParseItem() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Checks a URL is valid
# Usage: {fn} url ...
# Argument: url ... - String. URL. Required. A Uniform Resource Locator
urlValid() {
  while [ $# -gt 0 ]; do
    urlParse "$1" >/dev/null || return 1
    shift
  done
}

# Open URLs which appear in a stream (but continue to output the stream)
# stdin: text
# stdout: text
urlOpener() {
  local usage="_${FUNCNAME[0]}"

  local binary=""
  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --exec)
        shift
        binary=$(usageArgumentExecutable "$usage" "$argument" "${1-}") || return $?
        ;;
      *)
        # IDENTICAL argumentUnknown 1
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  [ -n "$binary" ] || binary="urlOpen"

  local line
  while read -r line; do
    printf -- "%s\n" "$line"
    printf -- "%s\n" "$line" | urlFilter | "$binary"
  done
}
_urlOpener() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done
  if [ "${#files[@]}" -gt 0 ]; then
    for file in "${files[@]}"; do
      # shellcheck disable=SC2094
      urlFilter "${aa[@]+"${aa[@]}"}" --file "$file" <"$file"
    done
    return 0
  fi

  local line minPrefix foundPrefix url match prefix="" lineNumber=0
  if $showFile && [ -n "$file" ]; then
    prefix="$file: "
  fi
  stripAnsi | while IFS="" read -r line; do
    lineNumber=$((lineNumber + 1))
    minPrefix=""
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
    [ -n "$minPrefix" ] || continue
    line="${line:${#minPrefix}}"
    local find="\""''
    line="${line//$find/ }"
    ! $debugFlag || printf -- "%s [%s] %s\n" "MATCH LINE CLEAN:" "$(decorate value "$lineNumber")" "$(decorate code "$line")"
    url=$(trimSpace "$line")
    url=${url%\"*}
    url=${url%\'*}
    url=${url%$'\e'*}
    if urlValid "$url"; then
      printf "%s%s\n" "$prefix" "$url"
    elif $debugFlag; then
      printf -- "%s [%s] %s\n" "! urlValid:" "$(decorate value "$lineNumber")" "$(decorate code "$url")"
    fi
  done
}
_urlFilter() {
  # IDENTICAL usageDocument 1
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

  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
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
  $waitFlag || [ "${#urls[@]}" -eq 0 ] || __usageEnvironment "$usage" __urlOpen "${urls[@]}" || return $?
  return 0
}
_urlOpen() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__urlOpenInnerLoop() {
  local usage="$1" url="$2" ignoreFlag="$3" waitFlag="$4"
  if ! urlValid "$url"; then
    if ! $ignoreFlag; then
      __failEnvironment "$usage" "Invalid URL: $(decorate error "$url")" || return $?
    fi
    return 0
  fi
  if $waitFlag; then
    __usageEnvironment "$usage" __urlOpen "$url" || return $?
  else
    return 120
  fi
}

__urlOpen() {
  local usage="${FUNCNAME[0]#_}" binary

  binary=$(__usageEnvironment "$usage" buildEnvironmentGet BUILD_URL_BINARY)
  if [ -z "$binary" ]; then
    while IFS='' read -d$'\n' -r binary; do
      if whichExists "$binary"; then
        break
      fi
    done < <(__usageEnvironment "$usage" __urlBinary)
    if [ -z "$binary" ]; then
      printf "%s %s\n" "OPEN: " "$(consoleLink "$url")"
      return 0
    fi
  else
    binary=$(usageArgumentExecutable "$usage" "BUILD_URL_BINARY" "$binary") || return $?
  fi
  [ $# -gt 0 ] || __usageArgument "$usage" "Require at least one URL" || return $?
  __environment "$binary" "$@" || return $?
}
