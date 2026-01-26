#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/example.sh"
argument="exitCode - UnsignedInteger. Required. Exit code to return. Default is 1."$'\n'"message ... - String. Optional. Message to output"$'\n'""
base="example.sh"
description="Return passed in integer return code and output message to \`stderr\` (non-zero) or \`stdout\` (zero)"$'\n'""
file="bin/build/tools/example.sh"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
rawComment="Return passed in integer return code and output message to \`stderr\` (non-zero) or \`stdout\` (zero)"$'\n'"Argument: exitCode - UnsignedInteger. Required. Exit code to return. Default is 1."$'\n'"Argument: message ... - String. Optional. Message to output"$'\n'"Return Code: exitCode"$'\n'"Requires: isUnsignedInteger printf returnMessage"$'\n'""$'\n'""
requires="isUnsignedInteger printf returnMessage"$'\n'""
return_code="exitCode"$'\n'""
sourceFile="bin/build/tools/example.sh"
sourceModified="1769277627"
summary="Return passed in integer return code and output message to"
usage="returnMessage exitCode [ message ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreturnMessage'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mexitCode'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ message ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mexitCode     '$'\e''[[(value)]mUnsignedInteger. Required. Exit code to return. Default is 1.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mmessage ...  '$'\e''[[(value)]mString. Optional. Message to output'$'\e''[[(reset)]m'$'\n'''$'\n''Return passed in integer return code and output message to '$'\e''[[(code)]mstderr'$'\e''[[(reset)]m (non-zero) or '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m (zero)'$'\n'''$'\n''Return codes:'$'\n''- exitCode'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: returnMessage exitCode [ message ... ]'$'\n'''$'\n''    exitCode     UnsignedInteger. Required. Exit code to return. Default is 1.'$'\n''    message ...  String. Optional. Message to output'$'\n'''$'\n''Return passed in integer return code and output message to stderr (non-zero) or stdout (zero)'$'\n'''$'\n''Return codes:'$'\n''- exitCode'$'\n'''
# elapsed 0.675
