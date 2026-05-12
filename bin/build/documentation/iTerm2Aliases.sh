#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="iterm2.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Installs iTerm2 aliases which are:\n\n- `it2check` - Check compatibility of these scripts (non-zero exit means non-compatible)\n- `imgcat` - Take an image file and output it to the console\n- `imgls` - List a directory and show thumbnails (in the console)\n- `it2attention` - Get attention from the operator\n- `it2getvar` - Get a variable value\n- `it2dl` - Download a file to the operator system\'s configured download folder\n- `it2ul` - Upload a file from the operator system to the remote\n- `it2copy` - Copy to clipboard from file or stdin\n- `it2setcolor` - Set console colors interactively\n- `it2setkeylabel` - Set key labels interactively\n- `it2universion` - Set, push, or pop Unicode version\n\nInternally supported:\n\n- `imgcat` = `iTerm2Image`\n- `it2attention` - `iTerm2Attention`\n- `it2dl` - `iTerm2Download`\n- `it2setcolor` - `iTerm2SetColors`\n\n'
descriptionLineCount="21"
file="bin/build/tools/iterm2.sh"
fn="iTerm2Aliases"
fnMarker="iterm2aliases"
foundNames=([0]="argument")
line="163"
rawComment=$'Installs iTerm2 aliases which are:\n- `it2check` - Check compatibility of these scripts (non-zero exit means non-compatible)\n- `imgcat` - Take an image file and output it to the console\n- `imgls` - List a directory and show thumbnails (in the console)\n- `it2attention` - Get attention from the operator\n- `it2getvar` - Get a variable value\n- `it2dl` - Download a file to the operator system\'s configured download folder\n- `it2ul` - Upload a file from the operator system to the remote\n- `it2copy` - Copy to clipboard from file or stdin\n- `it2setcolor` - Set console colors interactively\n- `it2setkeylabel` - Set key labels interactively\n- `it2universion` - Set, push, or pop Unicode version\nInternally supported:\n- `imgcat` = `iTerm2Image`\n- `it2attention` - `iTerm2Attention`\n- `it2dl` - `iTerm2Download`\n- `it2setcolor` - `iTerm2SetColors`\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/iterm2.sh"
sourceHash="13698f5ecbedc059696bbffbebc13f8cf7096e44"
sourceLine="163"
summary="Installs iTerm2 aliases which are:"
summaryComputed="true"
usage="iTerm2Aliases [ --help ]"
