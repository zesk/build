#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/completion.sh"
argument="--quiet - Flag. Optional. Do not output any messages to stdout."$'\n'"--alias name - String. Optional. The name of the alias to create."$'\n'"--reload-alias name - String. Optional. The name of the alias which reloads Zesk Build. (source)"$'\n'""
base="completion.sh"
description="Add completion handler for Zesk Build to Bash"$'\n'"This has the side effect of turning on the shell option \`expand_aliases\`"$'\n'"Shell Option: +expand_aliases"$'\n'""
file="bin/build/tools/completion.sh"
fn="buildCompletion"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/completion.sh"
sourceModified="1768513812"
summary="Add completion handler for Zesk Build to Bash"
usage="buildCompletion [ --quiet ] [ --alias name ] [ --reload-alias name ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbuildCompletion[0m [94m[ --quiet ][0m [94m[ --alias name ][0m [94m[ --reload-alias name ][0m

    [94m--quiet              [1;97mFlag. Optional. Do not output any messages to stdout.[0m
    [94m--alias name         [1;97mString. Optional. The name of the alias to create.[0m
    [94m--reload-alias name  [1;97mString. Optional. The name of the alias which reloads Zesk Build. (source)[0m

Add completion handler for Zesk Build to Bash
This has the side effect of turning on the shell option [38;2;0;255;0;48;2;0;0;0mexpand_aliases[0m
Shell Option: +expand_aliases

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: buildCompletion [ --quiet ] [ --alias name ] [ --reload-alias name ]

    --quiet              Flag. Optional. Do not output any messages to stdout.
    --alias name         String. Optional. The name of the alias to create.
    --reload-alias name  String. Optional. The name of the alias which reloads Zesk Build. (source)

Add completion handler for Zesk Build to Bash
This has the side effect of turning on the shell option expand_aliases
Shell Option: +expand_aliases

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
