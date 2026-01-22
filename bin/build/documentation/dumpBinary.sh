#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/test.sh"
argument="none"
base="test.sh"
depends="xxd"$'\n'""
description="Dumps output as hex"$'\n'"apt-get: xxd"$'\n'""
file="bin/build/tools/test.sh"
fn="dumpBinary"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceModified="1769063211"
stdin="binary"$'\n'""
stdout="formatted output set to ideal \`consoleColumns\`"$'\n'""
summary="Dumps output as hex"
usage="dumpBinary"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdumpBinary[0m

Dumps output as hex
apt-get: xxd

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
binary

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
formatted output set to ideal [38;2;0;255;0;48;2;0;0;0mconsoleColumns[0m
'
# shellcheck disable=SC2016
helpPlain='Usage: dumpBinary

Dumps output as hex
apt-get: xxd

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
binary

Writes to stdout:
formatted output set to ideal consoleColumns
'
