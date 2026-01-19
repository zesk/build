#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/ssh.sh"
argument="--force - Flag. Optional. Force the program to create a new key if one exists"$'\n'"server - String. Required. Servers to connect to to set up authorization"$'\n'""
base="ssh.sh"
description="Set up SSH for a user with ID and backup keys in \`~/.ssh\`"$'\n'""$'\n'"Create a key for a user for SSH authentication to other servers."$'\n'""$'\n'""$'\n'"Add .ssh key for current user"$'\n'""$'\n'""$'\n'"You will need the password for this server for the current user."$'\n'""
file="bin/build/tools/ssh.sh"
fn="sshSetup"
foundNames=([0]="argument" [1]="requires")
requires="userRecordHome catchEnvironment throwEnvironment"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/ssh.sh"
sourceModified="1768513812"
summary="Set up SSH for a user with ID and backup"
usage="sshSetup [ --force ] server"
