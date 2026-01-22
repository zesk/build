#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/ssh.sh"
argument="--force - Flag. Optional. Force the program to create a new key if one exists"$'\n'"server - String. Required. Servers to connect to to set up authorization"$'\n'""
base="ssh.sh"
description="Set up SSH for a user with ID and backup keys in \`~/.ssh\`"$'\n'""$'\n'"Create a key for a user for SSH authentication to other servers."$'\n'""$'\n'""$'\n'"Add .ssh key for current user"$'\n'""$'\n'""$'\n'"You will need the password for this server for the current user."$'\n'""
file="bin/build/tools/ssh.sh"
fn="sshSetup"
requires="userRecordHome catchEnvironment throwEnvironment"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/ssh.sh"
sourceModified="1768513812"
summary="Set up SSH for a user with ID and backup"
usage="sshSetup [ --force ] server"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255msshSetup[0m [94m[ --force ][0m [38;2;255;255;0m[35;48;2;0;0;0mserver[0m[0m

    [94m--force  [1;97mFlag. Optional. Force the program to create a new key if one exists[0m
    [31mserver   [1;97mString. Required. Servers to connect to to set up authorization[0m

Set up SSH for a user with ID and backup keys in [38;2;0;255;0;48;2;0;0;0m~/.ssh[0m

Create a key for a user for SSH authentication to other servers.


Add .ssh key for current user


You will need the password for this server for the current user.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: sshSetup [ --force ] server

    --force  Flag. Optional. Force the program to create a new key if one exists
    server   String. Required. Servers to connect to to set up authorization

Set up SSH for a user with ID and backup keys in ~/.ssh

Create a key for a user for SSH authentication to other servers.


Add .ssh key for current user


You will need the password for this server for the current user.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
