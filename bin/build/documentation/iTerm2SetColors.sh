#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--verbose | -v - Flag. Optional. Verbose mode. Show what you are doing.\n--skip-errors - Flag. Optional. Skip errors in color settings and continue - if loading a file containing a color scheme will load most of the file and skip any color settings with errors.\n--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.\ncolorSetting ... - String. Required. colorName=colorFormat string\n'
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Set terminal colors\n\nColor names permitted are:\n- fg bg bold link selbg selfg curbg curfg underline tab\n- black red green yellow blue magenta cyan white\n- br_black br_red br_green br_yellow br_blue br_magenta br_cyan br_white\n\ncolorFormat is one of:\n- `RGB` - Three hex [0-9A-F] values (hex3)\n- `RRGGBB` - Six hex values (like CSS colors) (hex6)\n- `cs:hex3` or `cs:hex6` - Where cs is one of `srgb`, `rgb`, or `p3`\n\nColor spaces:\n- `srgb` - The default color space\n- 1rgb - Apple\'s device-independent colorspace\n- `p3` - Apple\'s large-gamut colorspace\nIf no arguments are supplied which match a valid color setting values are read one-per-line from stdin.\n\n'
descriptionLineCount="18"
file="bin/build/tools/iterm2.sh"
fn="iTerm2SetColors"
fnMarker="iterm2setcolors"
foundNames=([0]="argument" [1]="stdin")
line="444"
rawComment=$'Set terminal colors\nArgument: --verbose | -v - Flag. Optional. Verbose mode. Show what you are doing.\nArgument: --skip-errors - Flag. Optional. Skip errors in color settings and continue - if loading a file containing a color scheme will load most of the file and skip any color settings with errors.\nArgument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.\nArgument: colorSetting ... - String. Required. colorName=colorFormat string\nColor names permitted are:\n- fg bg bold link selbg selfg curbg curfg underline tab\n- black red green yellow blue magenta cyan white\n- br_black br_red br_green br_yellow br_blue br_magenta br_cyan br_white\ncolorFormat is one of:\n- `RGB` - Three hex [0-9A-F] values (hex3)\n- `RRGGBB` - Six hex values (like CSS colors) (hex6)\n- `cs:hex3` or `cs:hex6` - Where cs is one of `srgb`, `rgb`, or `p3`\nColor spaces:\n- `srgb` - The default color space\n- 1rgb - Apple\'s device-independent colorspace\n- `p3` - Apple\'s large-gamut colorspace\nstdin: `colorName=colorFormat`. One per line. Only if no arguments passed with `colorSetting` format.\nIf no arguments are supplied which match a valid color setting values are read one-per-line from stdin.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="13698f5ecbedc059696bbffbebc13f8cf7096e44"
sourceLine="444"
stdin=$'`colorName=colorFormat`. One per line. Only if no arguments passed with `colorSetting` format.\n'
summary="Set terminal colors"
summaryComputed="true"
usage="iTerm2SetColors [ --verbose | -v ] [ --skip-errors ] [ --ignore | -i ] colorSetting ..."
