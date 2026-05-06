#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--find findArguments - String. Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options."$'\n'"path ... - Directory. Optional. One or more paths to scan for shell files. Uses PWD if not specified."$'\n'""
base="platform.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Makes all \`*.sh\` files executable"$'\n'""$'\n'""
descriptionLineCount="2"
environment="Works from the current directory"$'\n'""
file="bin/build/tools/platform.sh"
fn="bashMakeExecutable"
fnMarker="bashmakeexecutable"
foundNames=([0]="todo" [1]="argument" [2]="environment" [3]="see")
line="124"
rawComment="Makes all \`*.sh\` files executable"$'\n'"TODO: - findArguments is different here than other places"$'\n'"Argument: --find findArguments - String. Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options."$'\n'"Argument: path ... - Directory. Optional. One or more paths to scan for shell files. Uses PWD if not specified."$'\n'"Environment: Works from the current directory"$'\n'"See: bashMakeExecutable"$'\n'"See: chmod-sh.sh"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashMakeExecutable"$'\n'"chmod-sh.sh"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="097e41ee15602cdab3bc28d8a420362c8b93b425"
sourceLine="124"
summary="Makes all \`*.sh\` files executable"
summaryComputed="true"
todo="- findArguments is different here than other places"$'\n'""
usage="bashMakeExecutable [ --find findArguments ] [ path ... ]"
