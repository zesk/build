#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/dump.sh"
argument="--symbol symbol - String. Optional. Symbol to place before each line. (Blank is ok)."$'\n'"--tail - Flag. Optional. Show the tail of the file and not the head when not enough can be shown."$'\n'"--head - Flag. Optional. Show the head of the file when not enough can be shown. (default)"$'\n'"--lines - UnsignedInteger. Optional. Number of lines to show."$'\n'"--vanish file - UnsignedInteger. Optional. Number of lines to show."$'\n'"name - String. Optional. The item name or title of this output."$'\n'""
base="dump.sh"
description="Dump a pipe with a title and stats"$'\n'""
file="bin/build/tools/dump.sh"
fn="dumpPipe"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceModified="1768721469"
stdin="text"$'\n'""
stdout="formatted text for debugging"$'\n'""
summary="Dump a pipe with a title and stats"
usage="dumpPipe [ --symbol symbol ] [ --tail ] [ --head ] [ --lines ] [ --vanish file ] [ name ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdumpPipe[0m [94m[ --symbol symbol ][0m [94m[ --tail ][0m [94m[ --head ][0m [94m[ --lines ][0m [94m[ --vanish file ][0m [94m[ name ][0m

    [94m--symbol symbol  [1;97mString. Optional. Symbol to place before each line. (Blank is ok).[0m
    [94m--tail           [1;97mFlag. Optional. Show the tail of the file and not the head when not enough can be shown.[0m
    [94m--head           [1;97mFlag. Optional. Show the head of the file when not enough can be shown. (default)[0m
    [94m--lines          [1;97mUnsignedInteger. Optional. Number of lines to show.[0m
    [94m--vanish file    [1;97mUnsignedInteger. Optional. Number of lines to show.[0m
    [94mname             [1;97mString. Optional. The item name or title of this output.[0m

Dump a pipe with a title and stats

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
text

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
formatted text for debugging
'
# shellcheck disable=SC2016
helpPlain='Usage: dumpPipe [ --symbol symbol ] [ --tail ] [ --head ] [ --lines ] [ --vanish file ] [ name ]

    --symbol symbol  String. Optional. Symbol to place before each line. (Blank is ok).
    --tail           Flag. Optional. Show the tail of the file and not the head when not enough can be shown.
    --head           Flag. Optional. Show the head of the file when not enough can be shown. (default)
    --lines          UnsignedInteger. Optional. Number of lines to show.
    --vanish file    UnsignedInteger. Optional. Number of lines to show.
    name             String. Optional. The item name or title of this output.

Dump a pipe with a title and stats

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
text

Writes to stdout:
formatted text for debugging
'
