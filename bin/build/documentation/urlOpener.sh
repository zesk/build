#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/url.sh"
argument="--exec - Executable. Optional. If not supplied uses \`urlOpen\`."$'\n'""
base="url.sh"
description="Open URLs which appear in a stream"$'\n'"(but continue to output the stream)"$'\n'""
file="bin/build/tools/url.sh"
fn="urlOpener"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceModified="1768721470"
stdin="text"$'\n'""
stdout="text"$'\n'""
summary="Open URLs which appear in a stream"
usage="urlOpener [ --exec ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255murlOpener[0m [94m[ --exec ][0m

    [94m--exec  [1;97mExecutable. Optional. If not supplied uses [38;2;0;255;0;48;2;0;0;0murlOpen[0m.[0m

Open URLs which appear in a stream
(but continue to output the stream)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
text

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
text
'
# shellcheck disable=SC2016
helpPlain='Usage: urlOpener [ --exec ]

    --exec  Executable. Optional. If not supplied uses urlOpen.

Open URLs which appear in a stream
(but continue to output the stream)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
text

Writes to stdout:
text
'
