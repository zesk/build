#!/bin/bash
#
# Generic log service
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
name="$(basename "$(dirname "$(pwd)")")"
printf "Logging for %s" "$name"
logPath="{LOG_PATH}/$1"
if [ ! -d "$logPath" ]; then
  mkdir -p "$logPath"
fi
chown -R "{APPLICATION_USER}" "$logPath"
chmod 775 "$logPath"
cd "$logPath" || return 1

applicationUserOwner() {
  if [ -n "$(find "$logPath" -type f -print -quit)" ]; then
    find "$logPath" -type f -print0 | xargs -0 chown "{APPLICATION_USER}"
  fi
}

applicationUserOwner
exec setuidgid "{APPLICATION_USER}" multilog t "$logPath"
