#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--only - Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)"$'\n'"file - File. Optional. File(s) to filter."$'\n'""
base="bash.sh"
description="Filter comments from a bash stream"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashCommentFilter"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/bash.sh"
sourceModified="1768721469"
stdin="a bash file"$'\n'""
stdout="bash file without line-comments \`#\`"$'\n'""
summary="Filter comments from a bash stream"
usage="bashCommentFilter [ --help ] [ --only ] [ file ]"
