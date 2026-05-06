#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="hostName ... - String. Optional. One ore more hosts to add to the known hosts file"$'\n'""
base="ssh.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Adds the host to the \`~/.known_hosts\` if it is not found in it already"$'\n'""$'\n'"Side effects:"$'\n'"1. \`~/.ssh\` may be created if it does not exist"$'\n'"1. \`~/.ssh\` mode is set to \`0700\` (read/write/execute user)"$'\n'"1. \`~/.ssh/known_hosts\` is created if it does not exist"$'\n'"1. \`~/.ssh/known_hosts\` mode is set to \`0600\` (read/write user)"$'\n'"1. \`~./.ssh/known_hosts\` is possibly modified (appended)"$'\n'""$'\n'"If this function fails then ~/.ssh/known_hosts may be modified for any hosts which did not fail"$'\n'""$'\n'"If no arguments are passed, the default behavior is to set up the \`~/.ssh\` directory and create the known hosts file."$'\n'""$'\n'""
descriptionLineCount="13"
file="bin/build/tools/ssh.sh"
fn="sshKnownHostAdd"
fnMarker="sshknownhostadd"
foundNames=([0]="return_code" [1]="argument")
line="73"
rawComment="Adds the host to the \`~/.known_hosts\` if it is not found in it already"$'\n'"Side effects:"$'\n'"1. \`~/.ssh\` may be created if it does not exist"$'\n'"1. \`~/.ssh\` mode is set to \`0700\` (read/write/execute user)"$'\n'"1. \`~/.ssh/known_hosts\` is created if it does not exist"$'\n'"1. \`~/.ssh/known_hosts\` mode is set to \`0600\` (read/write user)"$'\n'"1. \`~./.ssh/known_hosts\` is possibly modified (appended)"$'\n'"If this function fails then ~/.ssh/known_hosts may be modified for any hosts which did not fail"$'\n'"Return Code: 1 - Environment errors"$'\n'"Return Code: 0 - All hosts exist in or were successfully added to the known hosts file"$'\n'"Argument: hostName ... - String. Optional. One ore more hosts to add to the known hosts file"$'\n'"If no arguments are passed, the default behavior is to set up the \`~/.ssh\` directory and create the known hosts file."$'\n'""$'\n'""
return_code="1 - Environment errors"$'\n'"0 - All hosts exist in or were successfully added to the known hosts file"$'\n'""
sourceFile="bin/build/tools/ssh.sh"
sourceHash="da31df886e47e169a75f4a40634ff3d8ce30c031"
sourceLine="73"
summary="Adds the host to the \`~/.known_hosts\` if it is not"
summaryComputed="true"
usage="sshKnownHostAdd [ hostName ... ]"
