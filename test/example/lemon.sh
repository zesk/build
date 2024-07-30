#!/usr/bin/env bash
#
# Simple service
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
odd() {
  [ "$1" -eq $(($(($1 / 2)) * 2)) ]
}

lemonDaemon() {
  local total
  local source="${BASH_SOURCE[0]}"
  local processIDFile="/tmp/lemon.pid"
  local start

  export PPID
  printf "%s\n" $$ "${PPID-No PPID}" >"$processIDFile" || printf "%s" "Creating process ID file $processIDFile failed" || :
  total=0
  start="$(date +%s)"
  printf "%s started on %s (%s)\n" "$source" "$(date "+%F %T")" "$processIDFile"
  while [ "$total" -lt 3600 ]; do
    random=$(($(od -A n -t d -N 1 /dev/urandom) + 0))
    if odd "$random"; then
      printf "%d %s\n" "$random" "hip"
    else
      printf "%d %s\n" "$random" "hop"
    fi
    sleep 1
    total=$((total + 1))
  done
  rm -rf "$processIDFile" || :
  printf "%s ended on %s (%d seconds)\n" "$source" "$(date "+%F %T")" "$((start - $(date %s))))"
}

lemonDaemon "$@"
