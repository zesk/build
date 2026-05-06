#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--force - Flag. Optional. Force the program to create a new key if one exists"$'\n'"server - String. Required. Servers to connect to to set up authorization"$'\n'""
base="ssh.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Set up SSH for a user with ID and backup keys in \`~/.ssh\`"$'\n'""$'\n'"Create a key for a user for SSH authentication to other servers."$'\n'""$'\n'"Add .ssh key for current user"$'\n'""$'\n'"You will need the password for this server for the current user."$'\n'""$'\n'""
descriptionLineCount="8"
file="bin/build/tools/ssh.sh"
fn="sshSetup"
fnMarker="sshsetup"
foundNames=([0]="argument" [1]="requires")
line="206"
rawComment="Set up SSH for a user with ID and backup keys in \`~/.ssh\`"$'\n'"Create a key for a user for SSH authentication to other servers."$'\n'"Add .ssh key for current user"$'\n'"Argument: --force - Flag. Optional. Force the program to create a new key if one exists"$'\n'"Argument: server - String. Required. Servers to connect to to set up authorization"$'\n'"You will need the password for this server for the current user."$'\n'"Requires: userRecordHome catchEnvironment throwEnvironment"$'\n'""$'\n'""
requires="userRecordHome catchEnvironment throwEnvironment"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/ssh.sh"
sourceHash="da31df886e47e169a75f4a40634ff3d8ce30c031"
sourceLine="206"
summary="Set up SSH for a user with ID and backup"
summaryComputed="true"
usage="sshSetup [ --force ] server"
