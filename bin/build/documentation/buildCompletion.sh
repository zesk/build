#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/completion.sh"
argument="--quiet - Flag. Optional. Do not output any messages to stdout."$'\n'"--alias name - String. Optional. The name of the alias to create."$'\n'"--reload-alias name - String. Optional. The name of the alias which reloads Zesk Build. (source)"$'\n'""
base="completion.sh"
description="Add completion handler for Zesk Build to Bash"$'\n'"This has the side effect of turning on the shell option \`expand_aliases\`"$'\n'"Shell Option: +expand_aliases"$'\n'""
file="bin/build/tools/completion.sh"
fn="buildCompletion"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""$'\n'""$'\n'""
source="bin/build/tools/completion.sh"
sourceModified="1768513812"
summary="Add completion handler for Zesk Build to Bash"
usage="buildCompletion [ --quiet ] [ --alias name ] [ --reload-alias name ]"
