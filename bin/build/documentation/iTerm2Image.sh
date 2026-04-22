#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="--width width - PositiveInteger. Width in columns to display image."$'\n'"--height height - PositiveInteger. Height in rows to display image."$'\n'"--preserve-aspect-ratio - Flag. Preserve the aspect ratio."$'\n'"--scale - Flag. Do not preserve the aspect ratio, scale the image."$'\n'"--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'""
base="iterm2.sh"
description="Output an image to the console"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2Image"
foundNames=([0]="argument" [1]="stdout")
line="266"
lowerFn="iterm2image"
rawComment="Output an image to the console"$'\n'"Argument: --width width - PositiveInteger. Width in columns to display image."$'\n'"Argument: --height height - PositiveInteger. Height in rows to display image."$'\n'"Argument: --preserve-aspect-ratio - Flag. Preserve the aspect ratio."$'\n'"Argument: --scale - Flag. Do not preserve the aspect ratio, scale the image."$'\n'"Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"stdout: No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="0527ba47f537e4e6b5039d1b56e7d23b8233bcae"
sourceLine="266"
stdout="No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position"$'\n'""
summary="Output an image to the console"
summaryComputed="true"
usage="iTerm2Image [ --width width ] [ --height height ] [ --preserve-aspect-ratio ] [ --scale ] [ --ignore | -i ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]miTerm2Image'$'\e''[0m '$'\e''[[(blue)]m[ --width width ]'$'\e''[0m '$'\e''[[(blue)]m[ --height height ]'$'\e''[0m '$'\e''[[(blue)]m[ --preserve-aspect-ratio ]'$'\e''[0m '$'\e''[[(blue)]m[ --scale ]'$'\e''[0m '$'\e''[[(blue)]m[ --ignore | -i ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--width width            '$'\e''[[(value)]mPositiveInteger. Width in columns to display image.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--height height          '$'\e''[[(value)]mPositiveInteger. Height in rows to display image.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--preserve-aspect-ratio  '$'\e''[[(value)]mFlag. Preserve the aspect ratio.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--scale                  '$'\e''[[(value)]mFlag. Do not preserve the aspect ratio, scale the image.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--ignore | -i            '$'\e''[[(value)]mFlag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\e''[[(reset)]m'$'\n'''$'\n''Output an image to the console'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Image [ --width width ] [ --height height ] [ --preserve-aspect-ratio ] [ --scale ] [ --ignore | -i ]'$'\n'''$'\n''    --width width            PositiveInteger. Width in columns to display image.'$'\n''    --height height          PositiveInteger. Height in rows to display image.'$'\n''    --preserve-aspect-ratio  Flag. Preserve the aspect ratio.'$'\n''    --scale                  Flag. Do not preserve the aspect ratio, scale the image.'$'\n''    --ignore | -i            Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.'$'\n'''$'\n''Output an image to the console'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position'$'\n'''
documentationPath="documentation/source/tools/iterm2.md"
