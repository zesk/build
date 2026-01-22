#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/tar.sh"
argument="pattern - The file pattern to extract"$'\n'""
base="tar.sh"
description="Platform agnostic tar extract with wildcards"$'\n'""$'\n'"e.g. \`tar -xf '*/file.json'\` or \`tar -xf --wildcards '*/file.json'\` depending on OS"$'\n'""$'\n'"\`tar\` command is not cross-platform so this differentiates between the GNU and BSD command line arguments."$'\n'""$'\n'"Short description: Platform agnostic tar extract"$'\n'""
file="bin/build/tools/tar.sh"
fn="tarExtractPattern"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/tar.sh"
sourceModified="1768513812"
stdin="A gzipped-tar file"$'\n'""
stdout="The desired file"$'\n'""
summary="Platform agnostic tar extract with wildcards"
usage="tarExtractPattern [ pattern ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mtarExtractPattern[0m [94m[ pattern ][0m

    [94mpattern  [1;97mThe file pattern to extract[0m

Platform agnostic tar extract with wildcards

e.g. [38;2;0;255;0;48;2;0;0;0mtar -xf '\''[36m/file.json'\''[0m or [38;2;0;255;0;48;2;0;0;0mtar -xf --wildcards '\''[0m/file.json'\''[0m depending on OS

[38;2;0;255;0;48;2;0;0;0mtar[0m command is not cross-platform so this differentiates between the GNU and BSD command line arguments.

Short description: Platform agnostic tar extract

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
A gzipped-tar file

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
The desired file
'
# shellcheck disable=SC2016
helpPlain='Usage: tarExtractPattern [ pattern ]

    pattern  The file pattern to extract

Platform agnostic tar extract with wildcards

e.g. tar -xf '\''/file.json'\'' or tar -xf --wildcards '\''/file.json'\'' depending on OS

tar command is not cross-platform so this differentiates between the GNU and BSD command line arguments.

Short description: Platform agnostic tar extract

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
A gzipped-tar file

Writes to stdout:
The desired file
'
