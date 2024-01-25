#!/bin/bash
#
# Simple service to run a binary as a user
#
# Install to /etc/service/nameOfService/run
#
# Environment: APPLICATION_USER - Set and then map this file
# Environment: BINARY - Set and then map this file
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# See: daemontools
#
set -eou pipefail

userDatabase=/etc/passwd
export APPLICATION_USER="{APPLICATION_USER}"
export HOME
if ! HOME=$(grep "^$APPLICATION_USER:" "$userDatabase" | cut -d : -f 6); then
  printf "No such user %s in %s\n" "$APPLICATION_USER" "$userDatabase" 1>&2
  sleep 7
  exit 1
fi
exec setuidgid "$APPLICATION_USER" "{BINARY}"
