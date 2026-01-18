#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="fieldIndex - UnsignedInteger. Required. The field to compute the maximum length for"$'\n'"separatorChar - String. Optional. The separator character to delineate fields. Uses space if not supplied."$'\n'""
base="text.sh"
description="Given an input file, determine the maximum length of fieldIndex, using separatorChar as a delimiter between fields"$'\n'""$'\n'"Defaults to first field (fieldIndex of \`1\`), space separator (separatorChar is \` \`)"$'\n'""$'\n'""
file="bin/build/tools/text.sh"
fn="maximumFieldLength"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768759798"
stdin="Lines are read from standard in and line length is computed for each line"$'\n'""
stdout="\`UnsignedInteger\`"$'\n'""
summary="Given an input file, determine the maximum length of fieldIndex,"
usage="maximumFieldLength fieldIndex [ separatorChar ]"
