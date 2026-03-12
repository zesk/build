#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--find findArguments - String. Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options."$'\n'"path ... - Directory. Optional. One or more paths to scan for shell files. Uses PWD if not specified."$'\n'""
base="platform.sh"
description="Makes all \`*.sh\` files executable"$'\n'""
environment="Works from the current directory"$'\n'""
file="bin/build/tools/platform.sh"
fn="bashMakeExecutable"
foundNames=([0]="todo" [1]="argument" [2]="environment" [3]="see")
rawComment="Makes all \`*.sh\` files executable"$'\n'"TODO: - findArguments is different here than other places"$'\n'"Argument: --find findArguments - String. Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options."$'\n'"Argument: path ... - Directory. Optional. One or more paths to scan for shell files. Uses PWD if not specified."$'\n'"Environment: Works from the current directory"$'\n'"See: bashMakeExecutable"$'\n'"See: chmod-sh.sh"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="bashMakeExecutable"$'\n'"chmod-sh.sh"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="6141b6985f95828e1ff8727449bdd48567afe942"
summary="Makes all \`*.sh\` files executable"
summaryComputed="true"
todo="- findArguments is different here than other places"$'\n'""
usage="bashMakeExecutable [ --find findArguments ] [ path ... ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
