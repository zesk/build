#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="example.sh"
description="Return passed in integer return code and output message to \`stderr\` (non-zero) or \`stdout\` (zero)"$'\n'"Argument: exitCode - UnsignedInteger. Required. Exit code to return. Default is 1."$'\n'"Argument: message ... - String. Optional. Message to output"$'\n'"Return Code: exitCode"$'\n'"Requires: isUnsignedInteger printf returnMessage"$'\n'""
file="bin/build/tools/example.sh"
foundNames=()
rawComment="Return passed in integer return code and output message to \`stderr\` (non-zero) or \`stdout\` (zero)"$'\n'"Argument: exitCode - UnsignedInteger. Required. Exit code to return. Default is 1."$'\n'"Argument: message ... - String. Optional. Message to output"$'\n'"Return Code: exitCode"$'\n'"Requires: isUnsignedInteger printf returnMessage"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/example.sh"
sourceHash="d31910f0251ea4404646f765659549c358927e01"
summary="Return passed in integer return code and output message to"
usage="returnMessage"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnMessage'$'\e''[0m'$'\n'''$'\n''Return passed in integer return code and output message to '$'\e''[[(code)]mstderr'$'\e''[[(reset)]m (non-zero) or '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m (zero)'$'\n''Argument: exitCode - UnsignedInteger. Required. Exit code to return. Default is 1.'$'\n''Argument: message ... - String. Optional. Message to output'$'\n''Return Code: exitCode'$'\n''Requires: isUnsignedInteger printf returnMessage'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: returnMessage'$'\n'''$'\n''Return passed in integer return code and output message to stderr (non-zero) or stdout (zero)'$'\n''Argument: exitCode - UnsignedInteger. Required. Exit code to return. Default is 1.'$'\n''Argument: message ... - String. Optional. Message to output'$'\n''Return Code: exitCode'$'\n''Requires: isUnsignedInteger printf returnMessage'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.507
