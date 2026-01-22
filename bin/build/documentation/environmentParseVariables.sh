#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="none"
base="environment.sh"
description="Parse variables from an environment variable stream"$'\n'"Extracts lines with \`NAME=value\`"$'\n'"Details:"$'\n'"- Remove \`export \` from lines"$'\n'"- Skip lines containing \`read -r\`"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentParseVariables"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769063211"
stdin="Environment File"$'\n'""
stdout="EnvironmentVariable. One per line."$'\n'""
summary="Parse variables from an environment variable stream"
usage="environmentParseVariables"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentParseVariables[0m

Parse variables from an environment variable stream
Extracts lines with [38;2;0;255;0;48;2;0;0;0mNAME=value[0m
Details:
- Remove [38;2;0;255;0;48;2;0;0;0mexport [0m from lines
- Skip lines containing [38;2;0;255;0;48;2;0;0;0mread -r[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
Environment File

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
EnvironmentVariable. One per line.
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentParseVariables

Parse variables from an environment variable stream
Extracts lines with NAME=value
Details:
- Remove export  from lines
- Skip lines containing read -r

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
Environment File

Writes to stdout:
EnvironmentVariable. One per line.
'
