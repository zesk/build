#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="_sugar.sh"
description="Boolean test"$'\n'"If you want \"true-ish\" use \`isTrue\`."$'\n'"Returns 0 if \`value\` is boolean \`false\` or \`true\`."$'\n'"Is this a boolean? (\`true\` or \`false\`)"$'\n'"Return Code: 0 - if value is a boolean"$'\n'"Return Code: 1 - if value is not a boolean"$'\n'"See: isTrue parseBoolean"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: value - String. Optional. Value to check if it is a boolean."$'\n'"Requires: usageDocument printf"$'\n'""
file="bin/build/tools/_sugar.sh"
foundNames=()
rawComment="Boolean test"$'\n'"If you want \"true-ish\" use \`isTrue\`."$'\n'"Returns 0 if \`value\` is boolean \`false\` or \`true\`."$'\n'"Is this a boolean? (\`true\` or \`false\`)"$'\n'"Return Code: 0 - if value is a boolean"$'\n'"Return Code: 1 - if value is not a boolean"$'\n'"See: isTrue parseBoolean"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: value - String. Optional. Value to check if it is a boolean."$'\n'"Requires: usageDocument printf"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="4bce6d8a22071b1c44a64aadb33672fc47a840f1"
summary="Boolean test"
usage="isBoolean"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misBoolean'$'\e''[0m'$'\n'''$'\n''Boolean test'$'\n''If you want "true-ish" use '$'\e''[[(code)]misTrue'$'\e''[[(reset)]m.'$'\n''Returns 0 if '$'\e''[[(code)]mvalue'$'\e''[[(reset)]m is boolean '$'\e''[[(code)]mfalse'$'\e''[[(reset)]m or '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m.'$'\n''Is this a boolean? ('$'\e''[[(code)]mtrue'$'\e''[[(reset)]m or '$'\e''[[(code)]mfalse'$'\e''[[(reset)]m)'$'\n''Return Code: 0 - if value is a boolean'$'\n''Return Code: 1 - if value is not a boolean'$'\n''See: isTrue parseBoolean'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: value - String. Optional. Value to check if it is a boolean.'$'\n''Requires: usageDocument printf'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isBoolean'$'\n'''$'\n''Boolean test'$'\n''If you want "true-ish" use isTrue.'$'\n''Returns 0 if value is boolean false or true.'$'\n''Is this a boolean? (true or false)'$'\n''Return Code: 0 - if value is a boolean'$'\n''Return Code: 1 - if value is not a boolean'$'\n''See: isTrue parseBoolean'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: value - String. Optional. Value to check if it is a boolean.'$'\n''Requires: usageDocument printf'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.562
