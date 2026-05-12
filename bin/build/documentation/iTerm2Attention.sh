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
