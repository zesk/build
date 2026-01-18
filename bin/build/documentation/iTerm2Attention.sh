#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/iterm2.sh"
argument="--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"--verbose | -v - Flag. Optional. Verbose mode. Show what you are doing."$'\n'"action. String. Action to attract attention: \`true\`, \`false\` or \`!\`"$'\n'""
base="iterm2.sh"
description="Attract the operator"$'\n'"Actions:"$'\n'"- \`true\` - start making dock icon bounce"$'\n'"- \`false\` - stop making dock icon bounce"$'\n'"- \`!\` - Show fireworks at cursor"$'\n'"- \`fireworks\` - Show fireworks at cursor"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2Attention"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/iterm2.sh"
sourceModified="1768721470"
summary="Attract the operator"
usage="iTerm2Attention [ --ignore | -i ] [ --verbose | -v ] [ action. String. Action to attract attention: \`true\`, \`false\` or \`!\` ]"
