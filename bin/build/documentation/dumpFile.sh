#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/dump.sh"
argument="fileName0 - File. Optional. File to dump."$'\n'""
base="dump.sh"
description="Output a file for debugging"$'\n'""$'\n'""
file="bin/build/tools/dump.sh"
fn="dumpFile"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceModified="1769063211"
stdin="text (optional)"$'\n'""
stdout="formatted text (optional)"$'\n'""
summary="Output a file for debugging"
usage="dumpFile [ fileName0 ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdumpFile[0m [94m[ fileName0 ][0m

    [94mfileName0  [1;97mFile. Optional. File to dump.[0m

Output a file for debugging

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
text (optional)

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
formatted text (optional)
'
# shellcheck disable=SC2016
helpPlain='Usage: dumpFile [ fileName0 ]

    fileName0  File. Optional. File to dump.

Output a file for debugging

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
text (optional)

Writes to stdout:
formatted text (optional)
'
