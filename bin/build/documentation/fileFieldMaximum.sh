#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="fieldIndex - UnsignedInteger. Required. The field to compute the maximum length for"$'\n'"separatorChar - String. Optional. The separator character to delineate fields. Uses space if not supplied."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields"$'\n'""$'\n'"Defaults to first field (fieldIndex of \`1\`), space separator (separatorChar is \` \`)"$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/text.sh"
fn="fileFieldMaximum"
fnMarker="filefieldmaximum"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="654"
rawComment="Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields"$'\n'"Defaults to first field (fieldIndex of \`1\`), space separator (separatorChar is \` \`)"$'\n'"Argument: fieldIndex - UnsignedInteger. Required. The field to compute the maximum length for"$'\n'"Argument: separatorChar - String. Optional. The separator character to delineate fields. Uses space if not supplied."$'\n'"stdin: Lines are read from standard in and line length is computed for each line"$'\n'"stdout: \`UnsignedInteger\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="84b28d822faa71e69bacd5d4867e83d7277ac467"
sourceLine="654"
stdin="Lines are read from standard in and line length is computed for each line"$'\n'""
stdout="\`UnsignedInteger\`"$'\n'""
summary="Given an input file, determine the maximum length of fieldIndex,"
summaryComputed="true"
usage="fileFieldMaximum fieldIndex [ separatorChar ]"
