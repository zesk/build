#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--only - Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)"$'\n'"file - File. Optional. File(s) to filter."$'\n'""
base="bash.sh"
description="Filter comments from a bash stream"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashCommentFilter"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Filter comments from a bash stream"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --only - Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)"$'\n'"Argument: file - File. Optional. File(s) to filter."$'\n'"stdin: a bash file"$'\n'"stdout: bash file without line-comments \`#\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="f595398f728c584ee7c7e2255d6ece3e08b0d67d"
stdin="a bash file"$'\n'""
stdout="bash file without line-comments \`#\`"$'\n'""
summary="Filter comments from a bash stream"
summaryComputed="true"
usage="bashCommentFilter [ --help ] [ --only ] [ file ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
