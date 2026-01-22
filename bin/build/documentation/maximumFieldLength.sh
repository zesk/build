#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="fieldIndex - UnsignedInteger. Required. The field to compute the maximum length for"$'\n'"separatorChar - String. Optional. The separator character to delineate fields. Uses space if not supplied."$'\n'""
base="text.sh"
description="Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields"$'\n'""$'\n'"Defaults to first field (fieldIndex of \`1\`), space separator (separatorChar is \` \`)"$'\n'""$'\n'""
file="bin/build/tools/text.sh"
fn="maximumFieldLength"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
stdin="Lines are read from standard in and line length is computed for each line"$'\n'""
stdout="\`UnsignedInteger\`"$'\n'""
summary="Given an input file, determine the maximum length of fieldIndex,"
usage="maximumFieldLength fieldIndex [ separatorChar ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmaximumFieldLength[0m [38;2;255;255;0m[35;48;2;0;0;0mfieldIndex[0m[0m [94m[ separatorChar ][0m

    [31mfieldIndex     [1;97mUnsignedInteger. Required. The field to compute the maximum length for[0m
    [94mseparatorChar  [1;97mString. Optional. The separator character to delineate fields. Uses space if not supplied.[0m

Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields

Defaults to first field (fieldIndex of [38;2;0;255;0;48;2;0;0;0m1[0m), space separator (separatorChar is [38;2;0;255;0;48;2;0;0;0m [0m)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
Lines are read from standard in and line length is computed for each line

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
[38;2;0;255;0;48;2;0;0;0mUnsignedInteger[0m
'
# shellcheck disable=SC2016
helpPlain='Usage: maximumFieldLength fieldIndex [ separatorChar ]

    fieldIndex     UnsignedInteger. Required. The field to compute the maximum length for
    separatorChar  String. Optional. The separator character to delineate fields. Uses space if not supplied.

Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields

Defaults to first field (fieldIndex of 1), space separator (separatorChar is  )

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
Lines are read from standard in and line length is computed for each line

Writes to stdout:
UnsignedInteger
'
