#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/iterm2.sh"
argument="--width width - PositiveInteger. Width in columns to display image."$'\n'"--height height - PositiveInteger. Height in rows to display image."$'\n'"--preserve-aspect-ratio - Flag. Preserve the aspect ratio."$'\n'"--scale - Flag. Do not preserve the aspect ratio, scale the image."$'\n'"--ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing."$'\n'""
base="iterm2.sh"
description="Output an image to the console"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2Image"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceModified="1768759385"
stdout="No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position"$'\n'""
summary="Output an image to the console"
usage="iTerm2Image [ --width width ] [ --height height ] [ --preserve-aspect-ratio ] [ --scale ] [ --ignore | -i ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255miTerm2Image[0m [94m[ --width width ][0m [94m[ --height height ][0m [94m[ --preserve-aspect-ratio ][0m [94m[ --scale ][0m [94m[ --ignore | -i ][0m

    [94m--width width            [1;97mPositiveInteger. Width in columns to display image.[0m
    [94m--height height          [1;97mPositiveInteger. Height in rows to display image.[0m
    [94m--preserve-aspect-ratio  [1;97mFlag. Preserve the aspect ratio.[0m
    [94m--scale                  [1;97mFlag. Do not preserve the aspect ratio, scale the image.[0m
    [94m--ignore | -i            [1;97mFlag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.[0m

Output an image to the console

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position
'
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Image [ --width width ] [ --height height ] [ --preserve-aspect-ratio ] [ --scale ] [ --ignore | -i ]

    --width width            PositiveInteger. Width in columns to display image.
    --height height          PositiveInteger. Height in rows to display image.
    --preserve-aspect-ratio  Flag. Preserve the aspect ratio.
    --scale                  Flag. Do not preserve the aspect ratio, scale the image.
    --ignore | -i            Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.

Output an image to the console

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position
'
