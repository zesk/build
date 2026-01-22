#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/identical.sh"
argument="--prefix prefix - String. Required. A text prefix to search for to identify identical sections (e.g. \`# IDENTICAL\`) (may specify more than one)"$'\n'"file ... - File. Required. A file to search for identical tokens."$'\n'""
base="identical.sh"
description="No documentation for \`identicalFindTokens\`."$'\n'""
file="bin/build/tools/identical.sh"
fn="identicalFindTokens"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/identical.sh"
sourceModified="1768845777"
stdout="tokens, one per line"$'\n'""
summary="undocumented"
usage="identicalFindTokens --prefix prefix file ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255midenticalFindTokens[0m [38;2;255;255;0m[35;48;2;0;0;0m--prefix prefix[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mfile ...[0m[0m

    [31m--prefix prefix  [1;97mString. Required. A text prefix to search for to identify identical sections (e.g. [38;2;0;255;0;48;2;0;0;0m# IDENTICAL[0m) (may specify more than one)[0m
    [31mfile ...         [1;97mFile. Required. A file to search for identical tokens.[0m

No documentation for [38;2;0;255;0;48;2;0;0;0midenticalFindTokens[0m.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
tokens, one per line
'
# shellcheck disable=SC2016
helpPlain='Usage: identicalFindTokens --prefix prefix file ...

    --prefix prefix  String. Required. A text prefix to search for to identify identical sections (e.g. # IDENTICAL) (may specify more than one)
    file ...         File. Required. A file to search for identical tokens.

No documentation for identicalFindTokens.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
tokens, one per line
'
