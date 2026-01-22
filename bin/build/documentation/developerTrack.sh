#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/developer.sh"
argument="--verbose - Flag. Optional. Be verbose about what the function is doing."$'\n'"--list - Flag. Optional. Show the list of what has changed since the first invocation."$'\n'"--profile - Flag. Optional. Mark the end of profile definitions."$'\n'"--developer - Flag. Optional. Mark the start of developer definitions."$'\n'""
base="developer.sh"
description="Track changes to the bash environment. WIth no arguments this function returns the new or changed bash functions, variables, or aliases since marks occurred."$'\n'""$'\n'"In general, you will add \`{fn} --profile\` at the end of your \`.bashrc\` file, and you will add \`{fn} --developer\` at the *start* of your \`developer.sh\` before you define anything."$'\n'""$'\n'""
file="bin/build/tools/developer.sh"
fn="developerTrack"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/developer.sh"
sourceModified="1768588589"
stdout="list of function|alias|environment"$'\n'""
summary="Track changes to the bash environment. WIth no arguments this"
usage="developerTrack [ --verbose ] [ --list ] [ --profile ] [ --developer ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeveloperTrack[0m [94m[ --verbose ][0m [94m[ --list ][0m [94m[ --profile ][0m [94m[ --developer ][0m

    [94m--verbose    [1;97mFlag. Optional. Be verbose about what the function is doing.[0m
    [94m--list       [1;97mFlag. Optional. Show the list of what has changed since the first invocation.[0m
    [94m--profile    [1;97mFlag. Optional. Mark the end of profile definitions.[0m
    [94m--developer  [1;97mFlag. Optional. Mark the start of developer definitions.[0m

Track changes to the bash environment. WIth no arguments this function returns the new or changed bash functions, variables, or aliases since marks occurred.

In general, you will add [38;2;0;255;0;48;2;0;0;0mdeveloperTrack --profile[0m at the end of your [38;2;0;255;0;48;2;0;0;0m.bashrc[0m file, and you will add [38;2;0;255;0;48;2;0;0;0mdeveloperTrack --developer[0m at the [36mstart[0m of your [38;2;0;255;0;48;2;0;0;0mdeveloper.sh[0m before you define anything.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
list of function|alias|environment
'
# shellcheck disable=SC2016
helpPlain='Usage: developerTrack [ --verbose ] [ --list ] [ --profile ] [ --developer ]

    --verbose    Flag. Optional. Be verbose about what the function is doing.
    --list       Flag. Optional. Show the list of what has changed since the first invocation.
    --profile    Flag. Optional. Mark the end of profile definitions.
    --developer  Flag. Optional. Mark the start of developer definitions.

Track changes to the bash environment. WIth no arguments this function returns the new or changed bash functions, variables, or aliases since marks occurred.

In general, you will add developerTrack --profile at the end of your .bashrc file, and you will add developerTrack --developer at the start of your developer.sh before you define anything.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
list of function|alias|environment
'
