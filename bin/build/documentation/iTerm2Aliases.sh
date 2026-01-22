#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/iterm2.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="iterm2.sh"
description="Installs iTerm2 aliases which are:"$'\n'""$'\n'"- \`it2check\` - Check compatibility of these scripts (non-zero exit means non-compatible)"$'\n'"- \`imgcat\` - Take an image file and output it to the console"$'\n'"- \`imgls\` - List a directory and show thumbnails (in the console)"$'\n'"- \`it2attention\` - Get attention from the operator"$'\n'"- \`it2getvar\` - Get a variable value"$'\n'"- \`it2dl\` - Download a file to the operator system's configured download folder"$'\n'"- \`it2ul\` - Upload a file from the operator system to the remote"$'\n'"- \`it2copy\` - Copy to clipboard from file or stdin"$'\n'"- \`it2setcolor\` - Set console colors interactively"$'\n'"- \`it2setkeylabel\` - Set key labels interactively"$'\n'"- \`it2universion\` - Set, push, or pop Unicode version"$'\n'""$'\n'"Internally supported:"$'\n'""$'\n'"- \`imgcat\` = \`iTerm2Image\`"$'\n'"- \`it2attention\` - \`iTerm2Attention\`"$'\n'"- \`it2dl\` - \`iTerm2Download\`"$'\n'"- \`it2setcolor\` - \`iTerm2SetColors\`"$'\n'""
file="bin/build/tools/iterm2.sh"
fn="iTerm2Aliases"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/iterm2.sh"
sourceModified="1768759385"
summary="Installs iTerm2 aliases which are:"
usage="iTerm2Aliases [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255miTerm2Aliases[0m [94m[ --help ][0m

    [94m--help  [1;97mFlag. Optional. Display this help.[0m

Installs iTerm2 aliases which are:

- [38;2;0;255;0;48;2;0;0;0mit2check[0m - Check compatibility of these scripts (non-zero exit means non-compatible)
- [38;2;0;255;0;48;2;0;0;0mimgcat[0m - Take an image file and output it to the console
- [38;2;0;255;0;48;2;0;0;0mimgls[0m - List a directory and show thumbnails (in the console)
- [38;2;0;255;0;48;2;0;0;0mit2attention[0m - Get attention from the operator
- [38;2;0;255;0;48;2;0;0;0mit2getvar[0m - Get a variable value
- [38;2;0;255;0;48;2;0;0;0mit2dl[0m - Download a file to the operator system'\''s configured download folder
- [38;2;0;255;0;48;2;0;0;0mit2ul[0m - Upload a file from the operator system to the remote
- [38;2;0;255;0;48;2;0;0;0mit2copy[0m - Copy to clipboard from file or stdin
- [38;2;0;255;0;48;2;0;0;0mit2setcolor[0m - Set console colors interactively
- [38;2;0;255;0;48;2;0;0;0mit2setkeylabel[0m - Set key labels interactively
- [38;2;0;255;0;48;2;0;0;0mit2universion[0m - Set, push, or pop Unicode version

Internally supported:

- [38;2;0;255;0;48;2;0;0;0mimgcat[0m = [38;2;0;255;0;48;2;0;0;0miTerm2Image[0m
- [38;2;0;255;0;48;2;0;0;0mit2attention[0m - [38;2;0;255;0;48;2;0;0;0miTerm2Attention[0m
- [38;2;0;255;0;48;2;0;0;0mit2dl[0m - [38;2;0;255;0;48;2;0;0;0miTerm2Download[0m
- [38;2;0;255;0;48;2;0;0;0mit2setcolor[0m - [38;2;0;255;0;48;2;0;0;0miTerm2SetColors[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: iTerm2Aliases [ --help ]

    --help  Flag. Optional. Display this help.

Installs iTerm2 aliases which are:

- it2check - Check compatibility of these scripts (non-zero exit means non-compatible)
- imgcat - Take an image file and output it to the console
- imgls - List a directory and show thumbnails (in the console)
- it2attention - Get attention from the operator
- it2getvar - Get a variable value
- it2dl - Download a file to the operator system'\''s configured download folder
- it2ul - Upload a file from the operator system to the remote
- it2copy - Copy to clipboard from file or stdin
- it2setcolor - Set console colors interactively
- it2setkeylabel - Set key labels interactively
- it2universion - Set, push, or pop Unicode version

Internally supported:

- imgcat = iTerm2Image
- it2attention - iTerm2Attention
- it2dl - iTerm2Download
- it2setcolor - iTerm2SetColors

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
