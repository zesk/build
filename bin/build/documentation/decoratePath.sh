#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--path pathName=icon - Flag. Optional. Add an additional path mapping to icon."$'\n'"--no-app - Flag. Optional. Do not map \`BUILD_HOME\`."$'\n'"--skip-app - Flag. Optional. Synonym for \`--no-app\`."$'\n'"path - String. Path to display and replace matching paths with icons."$'\n'""
base="decoration.sh"
description="Replace an absolute path prefix with an icon if it matches \`HOME\`, \`BUILD_HOME\` or \`TMPDIR\`"$'\n'"Icons used:"$'\n'"- 💣 - \`TMPDIR\`"$'\n'"- 🍎 - \`BUILD_HOME\`"$'\n'"- 🏠 - \`HOME\`"$'\n'""
environment="TMPDIR"$'\n'"BUILD_HOME"$'\n'"HOME"$'\n'""
file="bin/build/tools/decoration.sh"
fn="decoratePath"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decoration.sh"
sourceModified="1768721469"
summary="Display file paths and replace prefixes with icons"$'\n'""
usage="decoratePath [ --help ] [ --path pathName=icon ] [ --no-app ] [ --skip-app ] [ path ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdecoratePath[0m [94m[ --help ][0m [94m[ --path pathName=icon ][0m [94m[ --no-app ][0m [94m[ --skip-app ][0m [94m[ path ][0m

    [94m--help                [1;97mFlag. Optional. Display this help.[0m
    [94m--path pathName=icon  [1;97mFlag. Optional. Add an additional path mapping to icon.[0m
    [94m--no-app              [1;97mFlag. Optional. Do not map [38;2;0;255;0;48;2;0;0;0mBUILD_HOME[0m.[0m
    [94m--skip-app            [1;97mFlag. Optional. Synonym for [38;2;0;255;0;48;2;0;0;0m--no-app[0m.[0m
    [94mpath                  [1;97mString. Path to display and replace matching paths with icons.[0m

Replace an absolute path prefix with an icon if it matches [38;2;0;255;0;48;2;0;0;0mHOME[0m, [38;2;0;255;0;48;2;0;0;0mBUILD_HOME[0m or [38;2;0;255;0;48;2;0;0;0mTMPDIR[0m
Icons used:
- 💣 - [38;2;0;255;0;48;2;0;0;0mTMPDIR[0m
- 🍎 - [38;2;0;255;0;48;2;0;0;0mBUILD_HOME[0m
- 🏠 - [38;2;0;255;0;48;2;0;0;0mHOME[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- TMPDIR
- BUILD_HOME
- HOME
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: decoratePath [ --help ] [ --path pathName=icon ] [ --no-app ] [ --skip-app ] [ path ]

    --help                Flag. Optional. Display this help.
    --path pathName=icon  Flag. Optional. Add an additional path mapping to icon.
    --no-app              Flag. Optional. Do not map BUILD_HOME.
    --skip-app            Flag. Optional. Synonym for --no-app.
    path                  String. Path to display and replace matching paths with icons.

Replace an absolute path prefix with an icon if it matches HOME, BUILD_HOME or TMPDIR
Icons used:
- 💣 - TMPDIR
- 🍎 - BUILD_HOME
- 🏠 - HOME

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- TMPDIR
- BUILD_HOME
- HOME
- 
'
