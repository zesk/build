#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.\n--verbose | -v - Flag. Optional. Verbose mode. Show what you are doing.\naction. String. Action to attract attention: `true`, `false` or `!`\n'
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Attract the operator\nActions:\n- `true` - start making dock icon bounce\n- `false` - stop making dock icon bounce\n- `!` - Show fireworks at cursor\n- `fireworks` - Show fireworks at cursor\n\n'
descriptionLineCount="7"
file="bin/build/tools/iterm2.sh"
fn="iTerm2Attention"
fnMarker="iterm2attention"
foundNames=([0]="argument")
line="588"
rawComment=$'Attract the operator\nArgument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.\nArgument: --verbose | -v - Flag. Optional. Verbose mode. Show what you are doing.\nArgument: action. String. Action to attract attention: `true`, `false` or `!`\nActions:\n- `true` - start making dock icon bounce\n- `false` - stop making dock icon bounce\n- `!` - Show fireworks at cursor\n- `fireworks` - Show fireworks at cursor\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="13698f5ecbedc059696bbffbebc13f8cf7096e44"
sourceLine="588"
summary="Attract the operator"
summaryComputed="true"
usage="iTerm2Attention [ --ignore | -i ] [ --verbose | -v ] [ action. String. Action to attract attention: \`true\`, \`false\` or \`!\` ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]miTerm2Attention'$'\e''[0m '$'\e''[[(blue)]m[ --ignore | -i ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose | -v ]'$'\e''[0m '$'\e''[[(blue)]m[ action. String. Action to attract attention: `true`, `false` or `!` ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--ignore | -i                                                        '$'\e''[[(value)]mFlag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose | -v                                                       '$'\e''[[(value)]mFlag. Optional. Verbose mode. Show what you are doing.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]maction. String. Action to attract attention: '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m, '$'\e''[[(code)]mfalse'$'\e''[[(reset)]m or '$'\e''[[(code)]m!'$'\e''[[(reset)]m  '$'\e''[[(value)]maction. String. Action to attract attention: '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m, '$'\e''[[(code)]mfalse'$'\e''[[(reset)]m or '$'\e''[[(code)]m!'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Attract the operator'$'\n''Actions:'$'\n''- '$'\e''[[(code)]mtrue'$'\e''[[(reset)]m - start making dock icon bounce'$'\n''- '$'\e''[[(code)]mfalse'$'\e''[[(reset)]m - stop making dock icon bounce'$'\n''- '$'\e''[[(code)]m!'$'\e''[[(reset)]m - Show fireworks at cursor'$'\n''- '$'\e''[[(code)]mfireworks'$'\e''[[(reset)]m - Show fireworks at cursor'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Attention [ --ignore | -i ] [ --verbose | -v ] [ action. String. Action to attract attention: `true`, `false` or `!` ]'$'\n'''$'\n''    --ignore | -i                                                        Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\n''    --verbose | -v                                                       Flag. Optional. Verbose mode. Show what you are doing.'$'\n''    action. String. Action to attract attention: true, false or !  action. String. Action to attract attention: true, false or !'$'\n'''$'\n''Attract the operator'$'\n''Actions:'$'\n''- true - start making dock icon bounce'$'\n''- false - stop making dock icon bounce'$'\n''- ! - Show fireworks at cursor'$'\n''- fireworks - Show fireworks at cursor'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/iterm2.md"
