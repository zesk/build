#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--width width - PositiveInteger. Width in columns to display image."$'\n'"--height height - PositiveInteger. Height in rows to display image."$'\n'"--preserve-aspect-ratio - Flag. Preserve the aspect ratio."$'\n'"--scale - Flag. Do not preserve the aspect ratio, scale the image."$'\n'"--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'""
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output an image to the console"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/iterm2.sh"
fn="iTerm2Image"
fnMarker="iterm2image"
foundNames=([0]="argument" [1]="stdout")
line="266"
rawComment="Output an image to the console"$'\n'"Argument: --width width - PositiveInteger. Width in columns to display image."$'\n'"Argument: --height height - PositiveInteger. Height in rows to display image."$'\n'"Argument: --preserve-aspect-ratio - Flag. Preserve the aspect ratio."$'\n'"Argument: --scale - Flag. Do not preserve the aspect ratio, scale the image."$'\n'"Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'"stdout: No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="0527ba47f537e4e6b5039d1b56e7d23b8233bcae"
sourceLine="266"
stdout="No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position"$'\n'""
summary="Output an image to the console"
summaryComputed="true"
usage="iTerm2Image [ --width width ] [ --height height ] [ --preserve-aspect-ratio ] [ --scale ] [ --ignore | -i ]"
