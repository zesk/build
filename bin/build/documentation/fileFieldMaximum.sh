#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="fieldIndex - UnsignedInteger. Required. The field to compute the maximum length for"$'\n'"separatorChar - String. Optional. The separator character to delineate fields. Uses space if not supplied."$'\n'""
base="text.sh"
description="Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields"$'\n'"Defaults to first field (fieldIndex of \`1\`), space separator (separatorChar is \` \`)"$'\n'""
file="bin/build/tools/text.sh"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields"$'\n'"Defaults to first field (fieldIndex of \`1\`), space separator (separatorChar is \` \`)"$'\n'"Argument: fieldIndex - UnsignedInteger. Required. The field to compute the maximum length for"$'\n'"Argument: separatorChar - String. Optional. The separator character to delineate fields. Uses space if not supplied."$'\n'"stdin: Lines are read from standard in and line length is computed for each line"$'\n'"stdout: \`UnsignedInteger\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
stdin="Lines are read from standard in and line length is computed for each line"$'\n'""
stdout="\`UnsignedInteger\`"$'\n'""
summary="Given an input file, determine the maximum length of fieldIndex,"
summaryComputed="true"
usage="fileFieldMaximum fieldIndex [ separatorChar ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileFieldMaximum'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfieldIndex'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ separatorChar ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfieldIndex     '$'\e''[[(value)]mUnsignedInteger. Required. The field to compute the maximum length for'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mseparatorChar  '$'\e''[[(value)]mString. Optional. The separator character to delineate fields. Uses space if not supplied.'$'\e''[[(reset)]m'$'\n'''$'\n''Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields'$'\n''Defaults to first field (fieldIndex of '$'\e''[[(code)]m1'$'\e''[[(reset)]m), space separator (separatorChar is '$'\e''[[(code)]m '$'\e''[[(reset)]m)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''Lines are read from standard in and line length is computed for each line'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n'''$'\e''[[(code)]mUnsignedInteger'$'\e''[[(reset)]m'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileFieldMaximum fieldIndex [ separatorChar ]'$'\n'''$'\n''    fieldIndex     UnsignedInteger. Required. The field to compute the maximum length for'$'\n''    separatorChar  String. Optional. The separator character to delineate fields. Uses space if not supplied.'$'\n'''$'\n''Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields'$'\n''Defaults to first field (fieldIndex of 1), space separator (separatorChar is  )'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''Lines are read from standard in and line length is computed for each line'$'\n'''$'\n''Writes to stdout:'$'\n''UnsignedInteger'$'\n'''
# elapsed 3.352
