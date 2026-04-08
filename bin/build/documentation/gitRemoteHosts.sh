#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-08
# shellcheck disable=SC2034
argument="none"
base="git.sh"
description="List remote hosts for the current git repository"$'\n'"Parses \`user@host:path/project.git\` and extracts \`host\`"$'\n'""
file="bin/build/tools/git.sh"
fn="gitRemoteHosts"
foundNames=()
rawComment="List remote hosts for the current git repository"$'\n'"Parses \`user@host:path/project.git\` and extracts \`host\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="ef317634b04a01c8ac47c9c01567340a86b0e4b6"
summary="List remote hosts for the current git repository"
summaryComputed="true"
usage="gitRemoteHosts"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitRemoteHosts'$'\e''[0m'$'\n'''$'\n''List remote hosts for the current git repository'$'\n''Parses '$'\e''[[(code)]muser@host:path/project.git'$'\e''[[(reset)]m and extracts '$'\e''[[(code)]mhost'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitRemoteHosts'$'\n'''$'\n''List remote hosts for the current git repository'$'\n''Parses user@host:path/project.git and extracts host'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
