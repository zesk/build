#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/ssh.sh"
argument="hostName ... - String. Optional. One ore more hosts to add to the known hosts file"$'\n'""
base="ssh.sh"
description="Adds the host to the \`~/.known_hosts\` if it is not found in it already"$'\n'""$'\n'"Side effects:"$'\n'"1. \`~/.ssh\` may be created if it does not exist"$'\n'"1. \`~/.ssh\` mode is set to \`0700\` (read/write/execute user)"$'\n'"1. \`~/.ssh/known_hosts\` is created if it does not exist"$'\n'"1. \`~/.ssh/known_hosts\` mode is set to \`0600\` (read/write user)"$'\n'"1. \`~./.ssh/known_hosts\` is possibly modified (appended)"$'\n'""$'\n'"If this function fails then ~/.ssh/known_hosts may be modified for any hosts which did not fail"$'\n'""$'\n'"Return Code: 1 - Environment errors"$'\n'"Return Code: 0 - All hosts exist in or were successfully added to the known hosts file"$'\n'""$'\n'""$'\n'"If no arguments are passed, the default behavior is to set up the \`~/.ssh\` directory and create the known hosts file."$'\n'""$'\n'""
file="bin/build/tools/ssh.sh"
fn="sshKnownHostAdd"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""$'\n'""$'\n'""
source="bin/build/tools/ssh.sh"
sourceModified="1768513812"
summary="Adds the host to the \`~/.known_hosts\` if it is not"
usage="sshKnownHostAdd [ hostName ... ]"
