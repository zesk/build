#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--quiet - Flag. Optional. Do not output any messages to stdout."$'\n'"--alias name - String. Optional. The name of the alias to create."$'\n'"--reload-alias name - String. Optional. The name of the alias which reloads Zesk Build. (source)"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="completion.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Add completion handler for Zesk Build to Bash (EXPERIMENTAL)"$'\n'"This has the side effect of turning on the shell option \`expand_aliases\`"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/completion.sh"
fn="buildCompletion"
fnMarker="buildcompletion"
foundNames=([0]="summary" [1]="argument" [2]="shell_option")
line="17"
rawComment="Add completion handler for Zesk Build to Bash (EXPERIMENTAL)"$'\n'"Summary: Completion for Zesk Build (EXPERIMENTAL)"$'\n'"Argument: --quiet - Flag. Optional. Do not output any messages to stdout."$'\n'"Argument: --alias name - String. Optional. The name of the alias to create."$'\n'"Argument: --reload-alias name - String. Optional. The name of the alias which reloads Zesk Build. (source)"$'\n'"This has the side effect of turning on the shell option \`expand_aliases\`"$'\n'"Shell Option: +expand_aliases"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
shell_option="+expand_aliases"$'\n'""
sourceFile="bin/build/tools/completion.sh"
sourceHash="261e02f4521c420bc48a4cbad5ecd023eab402d5"
sourceLine="17"
summary="Completion for Zesk Build (EXPERIMENTAL)"
summaryComputed=""
usage="buildCompletion [ --quiet ] [ --alias name ] [ --reload-alias name ] [ --help ]"
