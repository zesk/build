#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/version.sh"
argument="none"
base="version.sh"
description="Take one or more versions and strip the leading \`v\`"$'\n'""
file="bin/build/tools/version.sh"
fn="versionNoVee"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/version.sh"
sourceModified="1769063211"
stdin="Versions containing a preceding \`v\` character (optionally)"$'\n'""
stdout="Versions with the initial \`v\` (if it exists) removed"$'\n'""
summary="Take one or more versions and strip the leading \`v\`"
usage="versionNoVee"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mversionNoVee[0m

Take one or more versions and strip the leading [38;2;0;255;0;48;2;0;0;0mv[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
Versions containing a preceding [38;2;0;255;0;48;2;0;0;0mv[0m character (optionally)

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
Versions with the initial [38;2;0;255;0;48;2;0;0;0mv[0m (if it exists) removed
'
# shellcheck disable=SC2016
helpPlain='Usage: versionNoVee

Take one or more versions and strip the leading v

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
Versions containing a preceding v character (optionally)

Writes to stdout:
Versions with the initial v (if it exists) removed
'
