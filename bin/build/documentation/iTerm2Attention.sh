#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"--verbose | -v - Flag. Optional. Verbose mode. Show what you are doing."$'\n'"action. String. Action to attract attention: \`true\`, \`false\` or \`!\`"$'\n'""
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Attract the operator"$'\n'"Actions:"$'\n'"- \`true\` - start making dock icon bounce"$'\n'"- \`false\` - stop making dock icon bounce"$'\n'"- \`!\` - Show fireworks at cursor"$'\n'"- \`fireworks\` - Show fireworks at cursor"$'\n'""$'\n'""
descriptionLineCount="7"
file="bin/build/tools/iterm2.sh"
fn="iTerm2Attention"
fnMarker="iterm2attention"
foundNames=([0]="argument")
line="589"
rawComment="Attract the operator"$'\n'"Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"Argument: --verbose | -v - Flag. Optional. Verbose mode. Show what you are doing."$'\n'"Argument: action. String. Action to attract attention: \`true\`, \`false\` or \`!\`"$'\n'"Actions:"$'\n'"- \`true\` - start making dock icon bounce"$'\n'"- \`false\` - stop making dock icon bounce"$'\n'"- \`!\` - Show fireworks at cursor"$'\n'"- \`fireworks\` - Show fireworks at cursor"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="0527ba47f537e4e6b5039d1b56e7d23b8233bcae"
sourceLine="589"
summary="Attract the operator"
summaryComputed="true"
usage="iTerm2Attention [ --ignore | -i ] [ --verbose | -v ] [ action. String. Action to attract attention: \`true\`, \`false\` or \`!\` ]"
