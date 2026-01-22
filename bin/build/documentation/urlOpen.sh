#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/url.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--ignore - Flag. Optional. Ignore any invalid URLs found."$'\n'"--wait - Flag. Optional. Display this help."$'\n'"--url url - URL. Optional. URL to download."$'\n'""
base="url.sh"
description="Open a URL using the operating system"$'\n'"Usage {fn} [ --help ]"$'\n'""
file="bin/build/tools/url.sh"
fn="urlOpen"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceModified="1768721470"
stdin="line:URL"$'\n'""
stdout="none"$'\n'""
summary="Open a URL using the operating system"
usage="urlOpen [ --help ] [ --ignore ] [ --wait ] [ --url url ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255murlOpen[0m [94m[ --help ][0m [94m[ --ignore ][0m [94m[ --wait ][0m [94m[ --url url ][0m

    [94m--help     [1;97mFlag. Optional. Display this help.[0m
    [94m--ignore   [1;97mFlag. Optional. Ignore any invalid URLs found.[0m
    [94m--wait     [1;97mFlag. Optional. Display this help.[0m
    [94m--url url  [1;97mURL. Optional. URL to download.[0m

Open a URL using the operating system
Usage urlOpen [ --help ]

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
line:URL

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
none
'
# shellcheck disable=SC2016
helpPlain='Usage: urlOpen [ --help ] [ --ignore ] [ --wait ] [ --url url ]

    --help     Flag. Optional. Display this help.
    --ignore   Flag. Optional. Ignore any invalid URLs found.
    --wait     Flag. Optional. Display this help.
    --url url  URL. Optional. URL to download.

Open a URL using the operating system
Usage urlOpen [ --help ]

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
line:URL

Writes to stdout:
none
'
