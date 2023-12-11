#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
echo "Killing daemontools and starting from scratch ..."
pgrep svscan -l | while read -r pid name; do
    printf "%s (%s) " "$name" "$pid"
    kill -9 "$pid" || printf "kill %s FAILED (?: %d) " "$name" $?
done
pkill svscan -t KILL
svc -dx /etc/service/* /etc/service/*/log

## Typically this runs `svscanboot &`
# shellcheck source=/dev/null
. /etc/rc.local

echo "Waiting 5 seconds ..."
sleep 5
svstat /etc/service
echo "Done."
