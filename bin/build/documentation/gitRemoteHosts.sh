#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="none"
base="git.sh"
description="List remote hosts for the current git repository"$'\n'""
file="bin/build/tools/git.sh"
foundNames=([0]="parses__user_host")
parses__user_host="path/project.git\` and extracts \`host\`"$'\n'""
rawComment="List remote hosts for the current git repository"$'\n'"Parses \`user@host:path/project.git\` and extracts \`host\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1769199547"
summary="List remote hosts for the current git repository"
usage="gitRemoteHosts"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitRemoteHosts'$'\e''[0m'$'\n'''$'\n''List remote hosts for the current git repository'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitRemoteHosts'$'\n'''$'\n''List remote hosts for the current git repository'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.383
