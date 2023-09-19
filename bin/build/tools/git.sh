#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: colors.sh
#

###############################################################################
#
#               ██
#               ▀▀       ██
#   ▄███▄██   ████     ███████
#  ██▀  ▀██     ██       ██
#  ██    ██     ██       ██
#  ▀██▄▄███  ▄▄▄██▄▄▄    ██▄▄▄
#   ▄▀▀▀ ██  ▀▀▀▀▀▀▀▀     ▀▀▀▀
#   ▀████▀▀
#
#------------------------------------------------------------------------------

#
# Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"
# Delete the old tag as well
#
veeGitTag() {
    local t="$1"

    if [ "$t" != "${t##v}" ]; then
        consoleError "Tag is already veed: $t" 1>&2
        return 1
    fi
    git tag "v$t" "$t"
    git tag -d "$t"
    git push origin "v$t" ":$t"
    git fetch -q --prune --prune-tags
}
