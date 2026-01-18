#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="--find findArguments - Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options."$'\n'"path ... - Directory. Optional. One or more paths to scan for shell files. Uses PWD if not specified."$'\n'""
base="platform.sh"
description="Makes all \`*.sh\` files executable"$'\n'""$'\n'""
environment="Works from the current directory"$'\n'""
file="bin/build/tools/platform.sh"
fn="makeShellFilesExecutable"
foundNames=([0]="argument" [1]="environment" [2]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="makeShellFilesExecutable"$'\n'"chmod-sh.sh"$'\n'""
source="bin/build/tools/platform.sh"
sourceModified="1768721470"
summary="Makes all \`*.sh\` files executable"
usage="makeShellFilesExecutable [ --find findArguments ] [ path ... ]"
