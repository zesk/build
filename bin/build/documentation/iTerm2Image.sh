#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--width width - PositiveInteger. Width in columns to display image.\n--height height - PositiveInteger. Height in rows to display image.\n--preserve-aspect-ratio - Flag. Preserve the aspect ratio.\n--scale - Flag. Do not preserve the aspect ratio, scale the image.\n--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.\n'
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output an image to the console\n\n'
descriptionLineCount="2"
file="bin/build/tools/iterm2.sh"
fn="iTerm2Image"
fnMarker="iterm2image"
foundNames=([0]="argument" [1]="stdout")
line="265"
rawComment=$'Output an image to the console\nArgument: --width width - PositiveInteger. Width in columns to display image.\nArgument: --height height - PositiveInteger. Height in rows to display image.\nArgument: --preserve-aspect-ratio - Flag. Preserve the aspect ratio.\nArgument: --scale - Flag. Do not preserve the aspect ratio, scale the image.\nArgument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.\nstdout: No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="13698f5ecbedc059696bbffbebc13f8cf7096e44"
sourceLine="265"
stdout=$'No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position\n'
summary="Output an image to the console"
summaryComputed="true"
usage="iTerm2Image [ --width width ] [ --height height ] [ --preserve-aspect-ratio ] [ --scale ] [ --ignore | -i ]"
