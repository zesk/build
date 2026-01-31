#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Outputs the integer offset of \`needle\` if found as substring in \`haystack\`"$'\n'"If \`haystack\` is not found, -1 is output"$'\n'"Argument: needle - String. Required."$'\n'"Argument: haystack - String. Required."$'\n'"stdout: \`Integer\`. The offset at which the \`needle\` was found in \`haystack\`. Outputs -1 if not found."$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Outputs the integer offset of \`needle\` if found as substring in \`haystack\`"$'\n'"If \`haystack\` is not found, -1 is output"$'\n'"Argument: needle - String. Required."$'\n'"Argument: haystack - String. Required."$'\n'"stdout: \`Integer\`. The offset at which the \`needle\` was found in \`haystack\`. Outputs -1 if not found."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Outputs the integer offset of \`needle\` if found as substring"
usage="stringOffset"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mstringOffset'$'\e''[0m'$'\n'''$'\n''Outputs the integer offset of '$'\e''[[(code)]mneedle'$'\e''[[(reset)]m if found as substring in '$'\e''[[(code)]mhaystack'$'\e''[[(reset)]m'$'\n''If '$'\e''[[(code)]mhaystack'$'\e''[[(reset)]m is not found, -1 is output'$'\n''Argument: needle - String. Required.'$'\n''Argument: haystack - String. Required.'$'\n''stdout: '$'\e''[[(code)]mInteger'$'\e''[[(reset)]m. The offset at which the '$'\e''[[(code)]mneedle'$'\e''[[(reset)]m was found in '$'\e''[[(code)]mhaystack'$'\e''[[(reset)]m. Outputs -1 if not found.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: stringOffset'$'\n'''$'\n''Outputs the integer offset of needle if found as substring in haystack'$'\n''If haystack is not found, -1 is output'$'\n''Argument: needle - String. Required.'$'\n''Argument: haystack - String. Required.'$'\n''stdout: Integer. The offset at which the needle was found in haystack. Outputs -1 if not found.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.672
