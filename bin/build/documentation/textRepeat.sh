#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Argument: \`count\` - UnsignedInteger. Required. Count of times to repeat."$'\n'"Argument: \`text\` .. - String. Required. A sequence of characters to repeat."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     textRepeat 80 ="$'\n'"Example:     decorate info Hello world"$'\n'"Example:     textRepeat 80 -"$'\n'"Summary: Repeat a string"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Argument: \`count\` - UnsignedInteger. Required. Count of times to repeat."$'\n'"Argument: \`text\` .. - String. Required. A sequence of characters to repeat."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     textRepeat 80 ="$'\n'"Example:     decorate info Hello world"$'\n'"Example:     textRepeat 80 -"$'\n'"Summary: Repeat a string"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Argument: \`count\` - UnsignedInteger. Required. Count of times to repeat."
usage="textRepeat"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtextRepeat'$'\e''[0m'$'\n'''$'\n''Argument: '$'\e''[[(code)]mcount'$'\e''[[(reset)]m - UnsignedInteger. Required. Count of times to repeat.'$'\n''Argument: '$'\e''[[(code)]mtext'$'\e''[[(reset)]m .. - String. Required. A sequence of characters to repeat.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Example:     textRepeat 80 ='$'\n''Example:     decorate info Hello world'$'\n''Example:     textRepeat 80 -'$'\n''Summary: Repeat a string'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: textRepeat'$'\n'''$'\n''Argument: count - UnsignedInteger. Required. Count of times to repeat.'$'\n''Argument: text .. - String. Required. A sequence of characters to repeat.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Example:     textRepeat 80 ='$'\n''Example:     decorate info Hello world'$'\n''Example:     textRepeat 80 -'$'\n''Summary: Repeat a string'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.465
