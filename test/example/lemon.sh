#!/usr/bin/env bash
#
# Simple service
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
odd() {
  [ "$1" -eq $(($(($1 / 2)) * 2)) ]
}
printf "%s started on %s\n" "${BASH_SOURCE[0]}" "$(date "+%F %T")"
while true; do
  random=$(($(od -A n -t d -N 1 /dev/urandom) + 0))
  if odd "$random"; then
    printf "%d %s\n" "$random" "hip"
  else
    printf "%d %s\n" "$random" "hop"
  fi
  sleep 1
done
