#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/iterm2.sh"
argument="--width width - PositiveInteger. Width in columns to display image."$'\n'"--height height - PositiveInteger. Height in rows to display image."$'\n'"--preserve-aspect-ratio - Flag. Preserve the aspect ratio."$'\n'"--scale - Flag. Do not preserve the aspect ratio, scale the image."$'\n'"--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'""
base="iterm2.sh"
description="Output an image to the console"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2Image"
foundNames=([0]="argument" [1]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/iterm2.sh"
sourceModified="1768683751"
stdout="No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position"$'\n'""
summary="Output an image to the console"
usage="iTerm2Image [ --width width ] [ --height height ] [ --preserve-aspect-ratio ] [ --scale ] [ --ignore | -i ]"
