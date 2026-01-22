#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="none"
base="git.sh"
description="List remote hosts for the current git repository"$'\n'"Parses \`user@host:path/project.git\` and extracts \`host\`"$'\n'""$'\n'""
file="bin/build/tools/git.sh"
fn="gitRemoteHosts"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="List remote hosts for the current git repository"
usage="gitRemoteHosts"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitRemoteHosts[0m

List remote hosts for the current git repository
Parses [38;2;0;255;0;48;2;0;0;0muser@host:path/project.git[0m and extracts [38;2;0;255;0;48;2;0;0;0mhost[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitRemoteHosts

List remote hosts for the current git repository
Parses user@host:path/project.git and extracts host

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
