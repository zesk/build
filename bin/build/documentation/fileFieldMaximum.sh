#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields"$'\n'"Defaults to first field (fieldIndex of \`1\`), space separator (separatorChar is \` \`)"$'\n'"Argument: fieldIndex - UnsignedInteger. Required. The field to compute the maximum length for"$'\n'"Argument: separatorChar - String. Optional. The separator character to delineate fields. Uses space if not supplied."$'\n'"stdin: Lines are read from standard in and line length is computed for each line"$'\n'"stdout: \`UnsignedInteger\`"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields"$'\n'"Defaults to first field (fieldIndex of \`1\`), space separator (separatorChar is \` \`)"$'\n'"Argument: fieldIndex - UnsignedInteger. Required. The field to compute the maximum length for"$'\n'"Argument: separatorChar - String. Optional. The separator character to delineate fields. Uses space if not supplied."$'\n'"stdin: Lines are read from standard in and line length is computed for each line"$'\n'"stdout: \`UnsignedInteger\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Given an input file, determine the maximum length of fieldIndex,"
usage="fileFieldMaximum"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileFieldMaximum'$'\e''[0m'$'\n'''$'\n''Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields'$'\n''Defaults to first field (fieldIndex of '$'\e''[[(code)]m1'$'\e''[[(reset)]m), space separator (separatorChar is '$'\e''[[(code)]m '$'\e''[[(reset)]m)'$'\n''Argument: fieldIndex - UnsignedInteger. Required. The field to compute the maximum length for'$'\n''Argument: separatorChar - String. Optional. The separator character to delineate fields. Uses space if not supplied.'$'\n''stdin: Lines are read from standard in and line length is computed for each line'$'\n''stdout: '$'\e''[[(code)]mUnsignedInteger'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileFieldMaximum'$'\n'''$'\n''Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields'$'\n''Defaults to first field (fieldIndex of 1), space separator (separatorChar is  )'$'\n''Argument: fieldIndex - UnsignedInteger. Required. The field to compute the maximum length for'$'\n''Argument: separatorChar - String. Optional. The separator character to delineate fields. Uses space if not supplied.'$'\n''stdin: Lines are read from standard in and line length is computed for each line'$'\n''stdout: UnsignedInteger'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.516
