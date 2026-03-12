#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="script - File. Required. Bash script to fetch requires tokens from."$'\n'""
base="bash.sh"
description="Gets a list of the \`Requires:\` comments in a bash file"$'\n'"Returns a unique list of tokens"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashGetRequires"
foundNames=([0]="argument")
rawComment="Argument: script - File. Required. Bash script to fetch requires tokens from."$'\n'"Gets a list of the \`Requires:\` comments in a bash file"$'\n'"Returns a unique list of tokens"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="f595398f728c584ee7c7e2255d6ece3e08b0d67d"
summary="Gets a list of the \`Requires:\` comments in a bash"
summaryComputed="true"
usage="bashGetRequires script"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
