#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/ssh.sh"
argument="hostName ... - String. Optional. One ore more hosts to add to the known hosts file"$'\n'""
base="ssh.sh"
description="Adds the host to the \`~/.known_hosts\` if it is not found in it already"$'\n'""$'\n'"Side effects:"$'\n'"1. \`~/.ssh\` may be created if it does not exist"$'\n'"1. \`~/.ssh\` mode is set to \`0700\` (read/write/execute user)"$'\n'"1. \`~/.ssh/known_hosts\` is created if it does not exist"$'\n'"1. \`~/.ssh/known_hosts\` mode is set to \`0600\` (read/write user)"$'\n'"1. \`~./.ssh/known_hosts\` is possibly modified (appended)"$'\n'""$'\n'"If this function fails then ~/.ssh/known_hosts may be modified for any hosts which did not fail"$'\n'""$'\n'"Return Code: 1 - Environment errors"$'\n'"Return Code: 0 - All hosts exist in or were successfully added to the known hosts file"$'\n'""$'\n'""$'\n'"If no arguments are passed, the default behavior is to set up the \`~/.ssh\` directory and create the known hosts file."$'\n'""$'\n'""
file="bin/build/tools/ssh.sh"
fn="sshKnownHostAdd"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/ssh.sh"
sourceModified="1768513812"
summary="Adds the host to the \`~/.known_hosts\` if it is not"
usage="sshKnownHostAdd [ hostName ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255msshKnownHostAdd[0m [94m[ hostName ... ][0m

    [94mhostName ...  [1;97mString. Optional. One ore more hosts to add to the known hosts file[0m

Adds the host to the [38;2;0;255;0;48;2;0;0;0m~/.known_hosts[0m if it is not found in it already

Side effects:
1. [38;2;0;255;0;48;2;0;0;0m~/.ssh[0m may be created if it does not exist
1. [38;2;0;255;0;48;2;0;0;0m~/.ssh[0m mode is set to [38;2;0;255;0;48;2;0;0;0m0700[0m (read/write/execute user)
1. [38;2;0;255;0;48;2;0;0;0m~/.ssh/known_hosts[0m is created if it does not exist
1. [38;2;0;255;0;48;2;0;0;0m~/.ssh/known_hosts[0m mode is set to [38;2;0;255;0;48;2;0;0;0m0600[0m (read/write user)
1. [38;2;0;255;0;48;2;0;0;0m~./.ssh/known_hosts[0m is possibly modified (appended)

If this function fails then ~/.ssh/known_hosts may be modified for any hosts which did not fail

Return Code: 1 - Environment errors
Return Code: 0 - All hosts exist in or were successfully added to the known hosts file


If no arguments are passed, the default behavior is to set up the [38;2;0;255;0;48;2;0;0;0m~/.ssh[0m directory and create the known hosts file.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: sshKnownHostAdd [ hostName ... ]

    hostName ...  String. Optional. One ore more hosts to add to the known hosts file

Adds the host to the ~/.known_hosts if it is not found in it already

Side effects:
1. ~/.ssh may be created if it does not exist
1. ~/.ssh mode is set to 0700 (read/write/execute user)
1. ~/.ssh/known_hosts is created if it does not exist
1. ~/.ssh/known_hosts mode is set to 0600 (read/write user)
1. ~./.ssh/known_hosts is possibly modified (appended)

If this function fails then ~/.ssh/known_hosts may be modified for any hosts which did not fail

Return Code: 1 - Environment errors
Return Code: 0 - All hosts exist in or were successfully added to the known hosts file


If no arguments are passed, the default behavior is to set up the ~/.ssh directory and create the known hosts file.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
