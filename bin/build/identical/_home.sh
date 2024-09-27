#!/bin/bash
#
# Original of _home
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Require: IDENTICAL _return
# Example: setuidgid $(_user) binary ...

# IDENTICAL _home EOF
# Usage: {fn} user
# Summary: Quick user database look up
# Look user up, output user home
_home() {
  local userDatabase=/etc/passwd
  export APPLICATION_USER HOME
  APPLICATION_USER="$1"
  HOME=$(grep "^$APPLICATION_USER:" "$userDatabase" | cut -d : -f 6) || _return $? "No such user $APPLICATION_USER in $userDatabase" || return $?
  [ -d "$HOME" ] || _return 1 "User $APPLICATION_USER HOME=$HOME is not a directory" || return $?
  printf -- "%s\n" "$HOME"
}
