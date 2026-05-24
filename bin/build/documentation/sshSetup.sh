#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--force - Flag. Optional. Force the program to create a new key if one exists\nserver - String. Required. Servers to connect to to set up authorization\n'
base="ssh.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Set up SSH for a user with ID and backup keys in `~/.ssh`\n\nCreate a key for a user for SSH authentication to other servers.\n\nAdd .ssh key for current user\n\nYou will need the password for this server for the current user.\n\n'
descriptionLineCount="8"
file="bin/build/tools/ssh.sh"
fn="sshSetup"
fnMarker="sshsetup"
foundNames=([0]="argument" [1]="requires")
line="206"
rawComment=$'Set up SSH for a user with ID and backup keys in `~/.ssh`\nCreate a key for a user for SSH authentication to other servers.\nAdd .ssh key for current user\nArgument: --force - Flag. Optional. Force the program to create a new key if one exists\nArgument: server - String. Required. Servers to connect to to set up authorization\nYou will need the password for this server for the current user.\nRequires: userRecordHome catchEnvironment throwEnvironment\n\n'
requires=$'userRecordHome catchEnvironment throwEnvironment\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/ssh.sh"
sourceHash="da31df886e47e169a75f4a40634ff3d8ce30c031"
sourceLine="206"
summary="Set up SSH for a user with ID and backup"
summaryComputed="true"
usage="sshSetup [ --force ] server"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]msshSetup'$'\e''[0m '$'\e''[[(blue)]m[ --force ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mserver'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--force  '$'\e''[[(value)]mFlag. Optional. Force the program to create a new key if one exists'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mserver   '$'\e''[[(value)]mString. Required. Servers to connect to to set up authorization'$'\e''[[(reset)]m'$'\n'''$'\n''Set up SSH for a user with ID and backup keys in '$'\e''[[(code)]m~/.ssh'$'\e''[[(reset)]m'$'\n'''$'\n''Create a key for a user for SSH authentication to other servers.'$'\n'''$'\n''Add .ssh key for current user'$'\n'''$'\n''You will need the password for this server for the current user.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: sshSetup [ --force ] server'$'\n'''$'\n''    --force  Flag. Optional. Force the program to create a new key if one exists'$'\n''    server   String. Required. Servers to connect to to set up authorization'$'\n'''$'\n''Set up SSH for a user with ID and backup keys in ~/.ssh'$'\n'''$'\n''Create a key for a user for SSH authentication to other servers.'$'\n'''$'\n''Add .ssh key for current user'$'\n'''$'\n''You will need the password for this server for the current user.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/ssh.md"
