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

# IDENTICAL errorArgument 1
errorArgument=2

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
# Gets the component of the URL from a given database URL.
# Summary: Get a database URL component directly
# Usage: urlParseItem component url0 [ url1 ... ]
# Argument: url0 - String. URL. Required. A Uniform Resource Locator used to specify a database connection
# Argument: component - the url component to get: `name`, `user`, `password`, `host`, `port`, `failed`
# Example:     consoleInfo "Connecting as $(urlParseItem user "$url")"
#
urlParseItem() {
  local component parsed
  # shellcheck disable=SC2034
  local url path name scheme user password host port error
  if [ $# -lt 2 ]; then
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" "$errorArgument" "Need at least one url"
    return $errorArgument
  fi
  component="$1"
  shift
  while [ $# -gt 0 ]; do
    if ! parsed=$(urlParse "$1"); then
      return $errorArgument
    fi
    if ! eval "$parsed"; then
      consoleError "Failed to eval $parsed" 1>&2
      return $errorArgument
    fi
    printf "%s\n" "${!component-}"
    shift
  done
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
