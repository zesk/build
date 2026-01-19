#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/developer.sh"
argument="--verbose - Flag. Optional. Be verbose about what the function is doing."$'\n'"--list - Flag. Optional. Show the list of what has changed since the first invocation."$'\n'"--profile - Flag. Optional. Mark the end of profile definitions."$'\n'"--developer - Flag. Optional. Mark the start of developer definitions."$'\n'""
base="developer.sh"
description="Track changes to the bash environment. WIth no arguments this function returns the new or changed bash functions, variables, or aliases since marks occurred."$'\n'""$'\n'"In general, you will add \`{fn} --profile\` at the end of your \`.bashrc\` file, and you will add \`{fn} --developer\` at the *start* of your \`developer.sh\` before you define anything."$'\n'""$'\n'""
file="bin/build/tools/developer.sh"
fn="developerTrack"
foundNames=([0]="argument" [1]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/developer.sh"
sourceModified="1768588589"
stdout="list of function|alias|environment"$'\n'""
summary="Track changes to the bash environment. WIth no arguments this"
usage="developerTrack [ --verbose ] [ --list ] [ --profile ] [ --developer ]"
