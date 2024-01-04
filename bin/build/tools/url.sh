#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends on no other .sh files
# Shell Dependencies: awk sed date echo sort printf
#
###############################################################################
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
# Exit Code: 0 - If parsing succeeds
# Exit Code: 1 - If parsing fails
# Summary: Simple Database URL Parsing
# Usage: urlParse url
# Argument: url - a Uniform Resource Locator used to specify a database connection
# Example:     eval "$(urlParse scheme://user:password@host:port/path)"
# Example:     echo $name
#
urlParse() {
  local url="${1-}" v name scheme user password host port failed

  name=${url##*/}
  # strip ?
  name=${name%%\?*}
  # strip #
  name=${name%%#*}

  # extract scheme before ://
  scheme=${url%%://*}
  # user is after scheme
  user=${url##*://}
  # before password
  user=${user%%:*}

  password=${url%%@*}
  password=${password##*:}

  host=${url##*@}
  host=${host%%/*}

  port=${host##*:}
  if [ "$port" = "$host" ]; then
    port=
  fi
  host=${host%%:*}

  failed=
  if [ "$scheme" = "$url" ] || [ "$user" = "$url" ] || [ "$password" = "$url" ] || [ "$host" = "$url" ]; then
    echo "url=$url" 1>&2
    echo "failed=1" 1>&2
    return $errorArgument
  fi

  for v in url scheme name user password host port failed; do
    printf "%s=%s\n" "$v" "$(quoteBashString "${!v}")"
  done
}

#
# Gets the component of the URL from a given database URL.
# Summary: Get a database URL component directly
# Usage: urlParseItem url name
# Argument: url - a Uniform Resource Locator used to specify a database connection
# Argument: name - the url component to get: `name`, `user`, `password`, `host`, `port`, `failed`
# Example:     consoleInfo "Connecting as $(urlParseItem "$url" user)"
#
urlParseItem() {
  # shellcheck disable=SC2034
  local scheme url name user password host port failed
  eval "$(urlParse "$1")"
  echo "${!2}"
}
