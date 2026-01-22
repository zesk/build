#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/manpath.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--first - Flag. Optional. Place any paths after this flag first in the list"$'\n'"--last - Flag. Optional. Place any paths after this flag last in the list. Default."$'\n'"path - the path to be added to the \`MANPATH\` environment"$'\n'""
base="manpath.sh"
description="Modify the MANPATH environment variable to add a path."$'\n'""$'\n'""
file="bin/build/tools/manpath.sh"
fn="manPathConfigure"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="manPathRemove"$'\n'""
sourceFile="bin/build/tools/manpath.sh"
sourceModified="1769063211"
summary="Modify the MANPATH environment variable to add a path."
usage="manPathConfigure [ --help ] [ --first ] [ --last ] [ path ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmanPathConfigure[0m [94m[ --help ][0m [94m[ --first ][0m [94m[ --last ][0m [94m[ path ][0m

    [94m--help   [1;97mFlag. Optional. Display this help.[0m
    [94m--first  [1;97mFlag. Optional. Place any paths after this flag first in the list[0m
    [94m--last   [1;97mFlag. Optional. Place any paths after this flag last in the list. Default.[0m
    [94mpath     [1;97mthe path to be added to the [38;2;0;255;0;48;2;0;0;0mMANPATH[0m environment[0m

Modify the MANPATH environment variable to add a path.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: manPathConfigure [ --help ] [ --first ] [ --last ] [ path ]

    --help   Flag. Optional. Display this help.
    --first  Flag. Optional. Place any paths after this flag first in the list
    --last   Flag. Optional. Place any paths after this flag last in the list. Default.
    path     the path to be added to the MANPATH environment

Modify the MANPATH environment variable to add a path.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
