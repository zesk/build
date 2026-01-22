#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/pcregrep.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="pcregrep.sh"
description="The name of the \`pcregrep\` binary on this operating system"$'\n'""
file="bin/build/tools/pcregrep.sh"
fn="pcregrepBinary"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/pcregrep.sh"
sourceModified="1769063211"
stdout="String. Name of binary for pcregrep."$'\n'""
summary="The name of the \`pcregrep\` binary on this operating system"
usage="pcregrepBinary [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpcregrepBinary[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

The name of the [38;2;0;255;0;48;2;0;0;0mpcregrep[0m binary on this operating system

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
String. Name of binary for pcregrep.
'
# shellcheck disable=SC2016
helpPlain='Usage: pcregrepBinary [ --help ]

    --help  Flag. Optional. Display this help.

The name of the pcregrep binary on this operating system

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
String. Name of binary for pcregrep.
'
