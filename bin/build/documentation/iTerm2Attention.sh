#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="iterm2.sh"
description="Attract the operator"$'\n'"Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"Argument: --verbose | -v - Flag. Optional. Verbose mode. Show what you are doing."$'\n'"Argument: action. String. Action to attract attention: \`true\`, \`false\` or \`!\`"$'\n'"Actions:"$'\n'"- \`true\` - start making dock icon bounce"$'\n'"- \`false\` - stop making dock icon bounce"$'\n'"- \`!\` - Show fireworks at cursor"$'\n'"- \`fireworks\` - Show fireworks at cursor"$'\n'""
file="bin/build/tools/iterm2.sh"
foundNames=()
rawComment="Attract the operator"$'\n'"Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"Argument: --verbose | -v - Flag. Optional. Verbose mode. Show what you are doing."$'\n'"Argument: action. String. Action to attract attention: \`true\`, \`false\` or \`!\`"$'\n'"Actions:"$'\n'"- \`true\` - start making dock icon bounce"$'\n'"- \`false\` - stop making dock icon bounce"$'\n'"- \`!\` - Show fireworks at cursor"$'\n'"- \`fireworks\` - Show fireworks at cursor"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="b59a38e93b87dfec07eac18e712111781b8a471f"
summary="Attract the operator"
usage="iTerm2Attention"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]miTerm2Attention'$'\e''[0m'$'\n'''$'\n''Attract the operator'$'\n''Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\n''Argument: --verbose | -v - Flag. Optional. Verbose mode. Show what you are doing.'$'\n''Argument: action. String. Action to attract attention: '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m, '$'\e''[[(code)]mfalse'$'\e''[[(reset)]m or '$'\e''[[(code)]m!'$'\e''[[(reset)]m'$'\n''Actions:'$'\n''- '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m - start making dock icon bounce'$'\n''- '$'\e''[[(code)]mfalse'$'\e''[[(reset)]m - stop making dock icon bounce'$'\n''- '$'\e''[[(code)]m!'$'\e''[[(reset)]m - Show fireworks at cursor'$'\n''- '$'\e''[[(code)]mfireworks'$'\e''[[(reset)]m - Show fireworks at cursor'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Attention'$'\n'''$'\n''Attract the operator'$'\n''Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\n''Argument: --verbose | -v - Flag. Optional. Verbose mode. Show what you are doing.'$'\n''Argument: action. String. Action to attract attention: true, false or !'$'\n''Actions:'$'\n''- true - start making dock icon bounce'$'\n''- false - stop making dock icon bounce'$'\n''- ! - Show fireworks at cursor'$'\n''- fireworks - Show fireworks at cursor'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.487
