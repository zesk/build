#!/bin/bash
#
# Original of urlFetch
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

# IDENTICAL urlFetch EOF

# Fetch URL content
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --header header - String. Optional. Send a header in the format 'Name: Value'
# Argument: --wget - Flag. Optional. Force use of wget. If unavailable, fail.
# Argument: --redirect-max maxRedirections - PositiveInteger. Optional. Sets the number of allowed redirects from the original URL. Default is 9.
# Argument: --curl - Flag. Optional. Force use of curl. If unavailable, fail.
# Argument: --binary binaryName - Callable. Use this binary instead. If the base name of the file is not `curl` or `wget` you MUST supply `--argument-format`.
# Argument: --argument-format format - Optional. String. Supply `curl` or `wget` for parameter formatting.
# Argument: --user userName - Optional. String. If supplied, uses HTTP Simple authentication. Usually used with `--password`. Note: User names may not contain the character `:` when using `curl`.
# Argument: --password password - Optional. String. If supplied along with `--user`, uses HTTP Simple authentication.
# Argument: url - Required. URL. URL to fetch to target file.
# Argument: file - Optional. FileDirectory. Target file. Use `-` to send to `stdout`. Default value is `-`.
# Requires: _return whichExists printf decorate
# Requires: usageArgumentString
# Requires: __throwArgument __catchArgument
# Requires: __throwEnvironment __catchEnvironment
urlFetch() {
  local handler="_${FUNCNAME[0]}"

  local wgetArgs=() curlArgs=() headers wgetExists binary="" userHasColons=false user="" password="" format="" url="" target="-"
  local maxRedirections=9

  wgetExists=$(whichExists wget && printf true || printf false)

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --header)
      shift
      local name value
      name="${1%%:}"
      value="${1#*:}"
      if [ "$name" = "$1" ] || [ "$value" = "$1" ]; then
        __catchArgument "$handler" "Invalid $argument $1 passed" || return $?
      fi
      headers+=("$1")
      curlArgs+=("--header" "$1")
      wgetArgs+=("--header=$1")
      ;;
    --wget) binary="wget" ;;
    --curl) binary="curl" ;;
    --binary)
      shift
      binary=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      whichExists "$binary" || __throwArgument "$handler" "$binary must be in PATH: $PATH" || return $?
      ;;
    --argument-format)
      format=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      case "$format" in curl | wget) ;; *) __throwArgument "$handler" "$argument must be curl or wget" || return $? ;; esac
      ;;
    --redirect-max) shift && maxRedirections=$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}") || return $? ;;
    --password) shift && password="$1" ;;
    --user)
      shift
      user=$(usageArgumentString "$handler" "$argument (user)" "$user") || return $?
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
      [ -n "$agent" ] || __throwArgument "$handler" "$argument must be non-blank" || return $?
      wgetArgs+=("--user-agent=$1")
      curlArgs+=("--user-agent" "$1")
      genericArgs+=("$argument" "$1")
      ;;
    *)
      if [ -z "$url" ]; then
        url="$1"
      elif [ -z "$target" ]; then
        target="$1"
        if [ "$target" != "-" ]; then
          curlArgs+=("-o" "$target")
        fi
        shift
        break
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  [ -n "$url" ] || __throwArgument "$handler" "URL is required" || return $?
  [ -n "$target" ] || __throwArgument "$handler" "target is required" || return $?

  if [ -n "$user" ]; then
    curlArgs+=(--user "$user:$password")
    wgetArgs+=("--http-user=$user" "--http-password=$password")
    genericArgs+=("--user" "$user" "--password" "$password")
  fi
  if [ "$binary" = "curl" ] && $userHasColons; then
    __throwArgument "$handler" "$argument: Users ($argument \"$(decorate code "$user")\") with colons are not supported by curl, use wget" || return $?
  fi
  if [ -z "$binary" ]; then
    if $wgetExists; then
      binary="wget"
    elif whichExists "curl"; then
      binary="curl"
    fi
  fi
  # wget options:
  # -q quiet
  #  --timeout - seconds to time out
  wgetArgs+=(--max-redirect "$maxRedirections")
  wgetArgs+=(-q)
  wgetArgs+=(--timeout=10)
  # Curl options:
  # -s silent
  # -S show errors
  # -f FAIL - ignore documents for 4XX or 5XX errors
  # -L follow redirects
  curlArgs+=(--max-redirs "$maxRedirections" -s -f -L --no-show-error)
  [ -n "$binary" ] || __throwEnvironment "$handler" "wget or curl required" || return $?
  [ -n "$format" ] || format="$binary"
  case "$format" in
  wget) __catchEnvironment "$handler" "$binary" --output-document="$target" "${wgetArgs[@]+"${wgetArgs[@]}"}" "$url" "$@" || return $? ;;
  curl) __catchEnvironment "$handler" "$binary" "$url" "$@" "${curlArgs[@]+"${curlArgs[@]}"}" || return $? ;;
  *) __throwEnvironment "$handler" "No handler for binary format $(decorate value "$format") (binary is $(decorate code "$binary")) $(decorate each value -- "${genericArgs[@]}")" || return $? ;;
  esac
}
_urlFetch() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
