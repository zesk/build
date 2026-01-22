#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/iterm2.sh"
argument="--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"--verbose | -v - Flag. Optional. Verbose mode. Show what you are doing."$'\n'"action. String. Action to attract attention: \`true\`, \`false\` or \`!\`"$'\n'""
base="iterm2.sh"
description="Attract the operator"$'\n'"Actions:"$'\n'"- \`true\` - start making dock icon bounce"$'\n'"- \`false\` - stop making dock icon bounce"$'\n'"- \`!\` - Show fireworks at cursor"$'\n'"- \`fireworks\` - Show fireworks at cursor"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2Attention"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceModified="1769063211"
summary="Attract the operator"
usage="iTerm2Attention [ --ignore | -i ] [ --verbose | -v ] [ action. String. Action to attract attention: \`true\`, \`false\` or \`!\` ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255miTerm2Attention[0m [94m[ --ignore | -i ][0m [94m[ --verbose | -v ][0m [94m[ action. String. Action to attract attention: `true`, `false` or `!` ][0m

    [94m--ignore | -i                                                        [1;97mFlag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.[0m
    [94m--verbose | -v                                                       [1;97mFlag. Optional. Verbose mode. Show what you are doing.[0m
    [94maction. String. Action to attract attention: [38;2;0;255;0;48;2;0;0;0mtrue[0m, [38;2;0;255;0;48;2;0;0;0mfalse[0m or [38;2;0;255;0;48;2;0;0;0m![0m  [1;97maction. String. Action to attract attention: [38;2;0;255;0;48;2;0;0;0mtrue[0m, [38;2;0;255;0;48;2;0;0;0mfalse[0m or [38;2;0;255;0;48;2;0;0;0m![0m[0m

Attract the operator
Actions:
- [38;2;0;255;0;48;2;0;0;0mtrue[0m - start making dock icon bounce
- [38;2;0;255;0;48;2;0;0;0mfalse[0m - stop making dock icon bounce
- [38;2;0;255;0;48;2;0;0;0m![0m - Show fireworks at cursor
- [38;2;0;255;0;48;2;0;0;0mfireworks[0m - Show fireworks at cursor

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Attention [ --ignore | -i ] [ --verbose | -v ] [ action. String. Action to attract attention: `true`, `false` or `!` ]

    --ignore | -i                                                        Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.
    --verbose | -v                                                       Flag. Optional. Verbose mode. Show what you are doing.
    action. String. Action to attract attention: true, false or !  action. String. Action to attract attention: true, false or !

Attract the operator
Actions:
- true - start making dock icon bounce
- false - stop making dock icon bounce
- ! - Show fireworks at cursor
- fireworks - Show fireworks at cursor

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
