#!/bin/bash
#
# Original of realPath
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# wget notes
#
# Sessions
# --save-cookies file
# --load-cookies file
# Bugs
# --ignore-length (ignores incorrect length)
#
# Security-stuff:
# --certificate=file
# --certificate-type=type
# --private-key=file
# --private-key-type=type

# IDENTICAL __fetch EOF
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
# Requires: usageArgumentExecutable usageArgumentString
# Requires: __failArgument __usageArgument _command
# Requires: __failEnvironment __usageEnvironment
__fetch() {
  local usage="$1" && shift

  local wgetArgs=() curlArgs=() headers wgetExists binary="" userHasColons=false user="" password="" format=""

  wgetExists=$(whichExists wget && printf true || printf false)

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __failArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
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
          __usageArgument "$usage" "Invalid $argument $1 passed" || return $?
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
        binary=$(usageArgumentExecutable "$usage" "$argument" "${1-}") || return $?
        ;;
      --argument-format)
        format=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        case "$format" in curl | wget) ;; *) __failArgument "$usage" "$argument must be curl or wget" || return $? ;; esac
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
        [ -n "$agent" ] || __failArgument "$usage" "$argument must be non-blank" || return $?
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
        __failArgument "$usage" "unknown #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift || __failArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
  done

  if [ -n "$user" ]; then
    curlArgs+=(--user "$user:$password")
    wgetArgs+=("--http-user=$user" "--http-password=$password")
    genericArgs+=("--user" "$user" "--password" "$password")
  fi
  if [ "$binary" = "curl" ] && $userHasColons; then
    __failArgument "$usage" "$argument: Users ($argument \"$(decorate code "$user")\") with colons are not supported by curl, use wget" || return $?
  fi
  if [ -z "$binary" ]; then
    if $wgetExists; then
      binary="wget"
    elif whichExists "curl"; then
      binary="curl"
    fi
  fi
  [ -n "$binary" ] || __failEnvironment "$usage" "wget or curl required" || return $?
  [ -z "$format" ] || format="$binary"
  case "$format" in
    wget) __usageEnvironment "$usage" "$binary" --no-verbose --output-document="$target" --timeout=10 "${wgetArgs[@]+"${wgetArgs[@]}"}" "$url" "$@" || return $? ;;
    curl) __usageEnvironment "$usage" "$binary" -L -s "$url" "$@" -o "$target" "${curlArgs[@]+"${curlArgs[@]}"}" || return $? ;;
    *) __failEnvironment "$usage" "No handler for binary format $(decorate value "$format") (binary is $(decorate code "$binary")) $(decorate each value "${genericArgs[@]}")" || return $? ;;
  esac
}
