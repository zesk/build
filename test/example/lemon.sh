#!/usr/bin/env bash
#
# Simple service
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
odd() {
  [ "$1" -eq $(($(($1 / 2)) * 2)) ]
}
while true; do
  random=$(od -A n -t d -N 1 /dev/urandom)
  if odd "$random"; then
    printf "%d %s\n" "$random" "hip"
  else
    printf "%d %s\n" "$random" "hop"
  fi
  sleep 2
done
