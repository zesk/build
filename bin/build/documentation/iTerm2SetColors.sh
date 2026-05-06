#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--verbose | -v - Flag. Optional. Verbose mode. Show what you are doing."$'\n'"--skip-errors - Flag. Optional. Skip errors in color settings and continue - if loading a file containing a color scheme will load most of the file and skip any color settings with errors."$'\n'"--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"colorSetting ... - String. Required. colorName=colorFormat string"$'\n'""
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Set terminal colors"$'\n'""$'\n'"Color names permitted are:"$'\n'"- fg bg bold link selbg selfg curbg curfg underline tab"$'\n'"- black red green yellow blue magenta cyan white"$'\n'"- br_black br_red br_green br_yellow br_blue br_magenta br_cyan br_white"$'\n'""$'\n'"colorFormat is one of:"$'\n'"- \`RGB\` - Three hex [0-9A-F] values (hex3)"$'\n'"- \`RRGGBB\` - Six hex values (like CSS colors) (hex6)"$'\n'"- \`cs:hex3\` or \`cs:hex6\` - Where cs is one of \`srgb\`, \`rgb\`, or \`p3\`"$'\n'""$'\n'"Color spaces:"$'\n'"- \`srgb\` - The default color space"$'\n'"- 1rgb - Apple's device-independent colorspace"$'\n'"- \`p3\` - Apple's large-gamut colorspace"$'\n'"If no arguments are supplied which match a valid color setting values are read one-per-line from stdin."$'\n'""$'\n'""
descriptionLineCount="18"
file="bin/build/tools/iterm2.sh"
fn="iTerm2SetColors"
fnMarker="iterm2setcolors"
foundNames=([0]="argument" [1]="stdin")
line="445"
rawComment="Set terminal colors"$'\n'"Argument: --verbose | -v - Flag. Optional. Verbose mode. Show what you are doing."$'\n'"Argument: --skip-errors - Flag. Optional. Skip errors in color settings and continue - if loading a file containing a color scheme will load most of the file and skip any color settings with errors."$'\n'"Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"Argument: colorSetting ... - String. Required. colorName=colorFormat string"$'\n'"Color names permitted are:"$'\n'"- fg bg bold link selbg selfg curbg curfg underline tab"$'\n'"- black red green yellow blue magenta cyan white"$'\n'"- br_black br_red br_green br_yellow br_blue br_magenta br_cyan br_white"$'\n'"colorFormat is one of:"$'\n'"- \`RGB\` - Three hex [0-9A-F] values (hex3)"$'\n'"- \`RRGGBB\` - Six hex values (like CSS colors) (hex6)"$'\n'"- \`cs:hex3\` or \`cs:hex6\` - Where cs is one of \`srgb\`, \`rgb\`, or \`p3\`"$'\n'"Color spaces:"$'\n'"- \`srgb\` - The default color space"$'\n'"- 1rgb - Apple's device-independent colorspace"$'\n'"- \`p3\` - Apple's large-gamut colorspace"$'\n'"stdin: \`colorName=colorFormat\`. One per line. Only if no arguments passed with \`colorSetting\` format."$'\n'"If no arguments are supplied which match a valid color setting values are read one-per-line from stdin."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="0527ba47f537e4e6b5039d1b56e7d23b8233bcae"
sourceLine="445"
stdin="\`colorName=colorFormat\`. One per line. Only if no arguments passed with \`colorSetting\` format."$'\n'""
summary="Set terminal colors"
summaryComputed="true"
usage="iTerm2SetColors [ --verbose | -v ] [ --skip-errors ] [ --ignore | -i ] colorSetting ..."
