#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="ssh.sh"
description="Set up SSH for a user with ID and backup keys in \`~/.ssh\`"$'\n'"Create a key for a user for SSH authentication to other servers."$'\n'"Add .ssh key for current user"$'\n'"Argument: --force - Flag. Optional. Force the program to create a new key if one exists"$'\n'"Argument: server - String. Required. Servers to connect to to set up authorization"$'\n'"You will need the password for this server for the current user."$'\n'"Requires: userRecordHome catchEnvironment throwEnvironment"$'\n'""
file="bin/build/tools/ssh.sh"
foundNames=()
rawComment="Set up SSH for a user with ID and backup keys in \`~/.ssh\`"$'\n'"Create a key for a user for SSH authentication to other servers."$'\n'"Add .ssh key for current user"$'\n'"Argument: --force - Flag. Optional. Force the program to create a new key if one exists"$'\n'"Argument: server - String. Required. Servers to connect to to set up authorization"$'\n'"You will need the password for this server for the current user."$'\n'"Requires: userRecordHome catchEnvironment throwEnvironment"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/ssh.sh"
sourceHash="bc6023e10d6a93b2c94638a207506f0f0be475d1"
summary="Set up SSH for a user with ID and backup"
usage="sshSetup"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]msshSetup'$'\e''[0m'$'\n'''$'\n''Set up SSH for a user with ID and backup keys in '$'\e''[[(code)]m~/.ssh'$'\e''[[(reset)]m'$'\n''Create a key for a user for SSH authentication to other servers.'$'\n''Add .ssh key for current user'$'\n''Argument: --force - Flag. Optional. Force the program to create a new key if one exists'$'\n''Argument: server - String. Required. Servers to connect to to set up authorization'$'\n''You will need the password for this server for the current user.'$'\n''Requires: userRecordHome catchEnvironment throwEnvironment'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: sshSetup'$'\n'''$'\n''Set up SSH for a user with ID and backup keys in ~/.ssh'$'\n''Create a key for a user for SSH authentication to other servers.'$'\n''Add .ssh key for current user'$'\n''Argument: --force - Flag. Optional. Force the program to create a new key if one exists'$'\n''Argument: server - String. Required. Servers to connect to to set up authorization'$'\n''You will need the password for this server for the current user.'$'\n''Requires: userRecordHome catchEnvironment throwEnvironment'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.501
