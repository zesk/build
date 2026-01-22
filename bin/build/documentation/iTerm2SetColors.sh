#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/iterm2.sh"
argument="--verbose | -v - Flag. Optional. Verbose mode. Show what you are doing."$'\n'"--skip-errors - Flag. Optional. Skip errors in color settings and continue - if loading a file containing a color scheme will load most of the file and skip any color settings with errors."$'\n'"--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"colorSetting ... - String. Required. colorName=colorFormat string"$'\n'""
base="iterm2.sh"
description="Set terminal colors"$'\n'""$'\n'"Color names permitted are:"$'\n'"- fg bg bold link selbg selfg curbg curfg underline tab"$'\n'"- black red green yellow blue magenta cyan white"$'\n'"- br_black br_red br_green br_yellow br_blue br_magenta br_cyan br_white"$'\n'""$'\n'"colorFormat is one of:"$'\n'"- \`RGB\` - Three hex [0-9A-F] values (hex3)"$'\n'"- \`RRGGBB\` - Six hex values (like CSS colors) (hex6)"$'\n'"- \`cs:hex3\` or \`cs:hex6\` - Where cs is one of \`srgb\`, \`rgb\`, or \`p3\`"$'\n'""$'\n'"Color spaces:"$'\n'"- \`srgb\` - The default color space"$'\n'"- 1rgb - Apple's device-independent colorspace"$'\n'"- \`p3\` - Apple's large-gamut colorspace"$'\n'"If no arguments are supplied which match a valid color setting values are read one-per-line from stdin."$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2SetColors"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceModified="1769063211"
stdin="\`colorName=colorFormat\`. One per line. Only if no arguments passed with \`colorSetting\` format."$'\n'""
summary="Set terminal colors"
usage="iTerm2SetColors [ --verbose | -v ] [ --skip-errors ] [ --ignore | -i ] colorSetting ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255miTerm2SetColors[0m [94m[ --verbose | -v ][0m [94m[ --skip-errors ][0m [94m[ --ignore | -i ][0m [38;2;255;255;0m[35;48;2;0;0;0mcolorSetting ...[0m[0m

    [94m--verbose | -v    [1;97mFlag. Optional. Verbose mode. Show what you are doing.[0m
    [94m--skip-errors     [1;97mFlag. Optional. Skip errors in color settings and continue - if loading a file containing a color scheme will load most of the file and skip any color settings with errors.[0m
    [94m--ignore | -i     [1;97mFlag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.[0m
    [31mcolorSetting ...  [1;97mString. Required. colorName=colorFormat string[0m

Set terminal colors

Color names permitted are:
- fg bg bold link selbg selfg curbg curfg underline tab
- black red green yellow blue magenta cyan white
- br_black br_red br_green br_yellow br_blue br_magenta br_cyan br_white

colorFormat is one of:
- [38;2;0;255;0;48;2;0;0;0mRGB[0m - Three hex [0-9A-F] values (hex3)
- [38;2;0;255;0;48;2;0;0;0mRRGGBB[0m - Six hex values (like CSS colors) (hex6)
- [38;2;0;255;0;48;2;0;0;0mcs:hex3[0m or [38;2;0;255;0;48;2;0;0;0mcs:hex6[0m - Where cs is one of [38;2;0;255;0;48;2;0;0;0msrgb[0m, [38;2;0;255;0;48;2;0;0;0mrgb[0m, or [38;2;0;255;0;48;2;0;0;0mp3[0m

Color spaces:
- [38;2;0;255;0;48;2;0;0;0msrgb[0m - The default color space
- 1rgb - Apple'\''s device-independent colorspace
- [38;2;0;255;0;48;2;0;0;0mp3[0m - Apple'\''s large-gamut colorspace
If no arguments are supplied which match a valid color setting values are read one-per-line from stdin.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
[38;2;0;255;0;48;2;0;0;0mcolorName=colorFormat[0m. One per line. Only if no arguments passed with [38;2;0;255;0;48;2;0;0;0mcolorSetting[0m format.
'
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2SetColors [ --verbose | -v ] [ --skip-errors ] [ --ignore | -i ] colorSetting ...

    --verbose | -v    Flag. Optional. Verbose mode. Show what you are doing.
    --skip-errors     Flag. Optional. Skip errors in color settings and continue - if loading a file containing a color scheme will load most of the file and skip any color settings with errors.
    --ignore | -i     Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.
    colorSetting ...  String. Required. colorName=colorFormat string

Set terminal colors

Color names permitted are:
- fg bg bold link selbg selfg curbg curfg underline tab
- black red green yellow blue magenta cyan white
- br_black br_red br_green br_yellow br_blue br_magenta br_cyan br_white

colorFormat is one of:
- RGB - Three hex [0-9A-F] values (hex3)
- RRGGBB - Six hex values (like CSS colors) (hex6)
- cs:hex3 or cs:hex6 - Where cs is one of srgb, rgb, or p3

Color spaces:
- srgb - The default color space
- 1rgb - Apple'\''s device-independent colorspace
- p3 - Apple'\''s large-gamut colorspace
If no arguments are supplied which match a valid color setting values are read one-per-line from stdin.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
colorName=colorFormat. One per line. Only if no arguments passed with colorSetting format.
'
