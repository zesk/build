#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="iterm2.sh"
description="Output an image to the console"$'\n'"Argument: --width width - PositiveInteger. Width in columns to display image."$'\n'"Argument: --height height - PositiveInteger. Height in rows to display image."$'\n'"Argument: --preserve-aspect-ratio - Flag. Preserve the aspect ratio."$'\n'"Argument: --scale - Flag. Do not preserve the aspect ratio, scale the image."$'\n'"Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"stdout: No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position"$'\n'""
file="bin/build/tools/iterm2.sh"
foundNames=()
rawComment="Output an image to the console"$'\n'"Argument: --width width - PositiveInteger. Width in columns to display image."$'\n'"Argument: --height height - PositiveInteger. Height in rows to display image."$'\n'"Argument: --preserve-aspect-ratio - Flag. Preserve the aspect ratio."$'\n'"Argument: --scale - Flag. Do not preserve the aspect ratio, scale the image."$'\n'"Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"stdout: No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="b59a38e93b87dfec07eac18e712111781b8a471f"
summary="Output an image to the console"
usage="iTerm2Image"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]miTerm2Image'$'\e''[0m'$'\n'''$'\n''Output an image to the console'$'\n''Argument: --width width - PositiveInteger. Width in columns to display image.'$'\n''Argument: --height height - PositiveInteger. Height in rows to display image.'$'\n''Argument: --preserve-aspect-ratio - Flag. Preserve the aspect ratio.'$'\n''Argument: --scale - Flag. Do not preserve the aspect ratio, scale the image.'$'\n''Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\n''stdout: No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Image'$'\n'''$'\n''Output an image to the console'$'\n''Argument: --width width - PositiveInteger. Width in columns to display image.'$'\n''Argument: --height height - PositiveInteger. Height in rows to display image.'$'\n''Argument: --preserve-aspect-ratio - Flag. Preserve the aspect ratio.'$'\n''Argument: --scale - Flag. Do not preserve the aspect ratio, scale the image.'$'\n''Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\n''stdout: No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.469
