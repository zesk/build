#!/bin/bash
#
# Generic log service
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
name="$(basename "$(dirname "$(pwd)")")"
printf "Logging for %s\n" "$name"
logPath="{LOG_PATH}/$name"
if [ ! -d "$logPath" ]; then
  mkdir -p "$logPath"
fi
chown -R "{APPLICATION_USER}:" "$logPath"
chmod 775 "$logPath"
cd "$logPath" || return 1

_setApplicationUserOwner() {
  if [ -n "$(find "$logPath" -type f -print -quit)" ]; then
    if ! find "$logPath" -type f -print0 | xargs -0 chown "{APPLICATION_USER}:"; then
      printf "%s: %s\n" "No files found in" "$logPath"
    else
      printf "%s: %s\n" "Modified owner of files in" "$logPath"
    fi
  fi
}

_setApplicationUserOwner
exec setuidgid "{APPLICATION_USER}" multilog t "$logPath"
