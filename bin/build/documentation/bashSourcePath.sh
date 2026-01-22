#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="--exclude pattern - String. Optional. String passed to \`! -path pattern\` in \`find\`"$'\n'"directory ... - Directory. Required. Directory to \`source\` all \`.sh\` files used."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Load a directory of bash scripts, excluding any dot directories (\`*/.*/*\`), and optionally any additional"$'\n'"files if you use \`--exclude\`. But recursively loads scripts in sorted alphabetic order within the directory until one fails."$'\n'"All files must be executable."$'\n'"Load a directory of \`.sh\` files using \`source\` to make the code available."$'\n'"Has security implications. Use with caution and ensure your directory is protected."$'\n'""
file="bin/build/tools/bash.sh"
fn="bashSourcePath"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
security="Loads bash files"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceModified="1769063211"
summary="Load a directory of bash scripts"$'\n'""
usage="bashSourcePath [ --exclude pattern ] directory ... [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashSourcePath[0m [94m[ --exclude pattern ][0m [38;2;255;255;0m[35;48;2;0;0;0mdirectory ...[0m[0m [94m[ --help ][0m

    [94m--exclude pattern  [1;97mString. Optional. String passed to [38;2;0;255;0;48;2;0;0;0m! -path pattern[0m in [38;2;0;255;0;48;2;0;0;0mfind[0m[0m
    [31mdirectory ...      [1;97mDirectory. Required. Directory to [38;2;0;255;0;48;2;0;0;0msource[0m all [38;2;0;255;0;48;2;0;0;0m.sh[0m files used.[0m
    [94m--help             [1;97mFlag. Optional. Display this help.[0m

Load a directory of bash scripts, excluding any dot directories ([38;2;0;255;0;48;2;0;0;0m[36m/.[0m/[36m[0m), and optionally any additional[0m
files if you use [38;2;0;255;0;48;2;0;0;0m--exclude[0m. But recursively loads scripts in sorted alphabetic order within the directory until one fails.
All files must be executable.
Load a directory of [38;2;0;255;0;48;2;0;0;0m.sh[0m files using [38;2;0;255;0;48;2;0;0;0msource[0m to make the code available.
Has security implications. Use with caution and ensure your directory is protected.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashSourcePath [ --exclude pattern ] directory ... [ --help ]

    --exclude pattern  String. Optional. String passed to ! -path pattern in find
    directory ...      Directory. Required. Directory to source all .sh files used.
    --help             Flag. Optional. Display this help.

Load a directory of bash scripts, excluding any dot directories (/./), and optionally any additional
files if you use --exclude. But recursively loads scripts in sorted alphabetic order within the directory until one fails.
All files must be executable.
Load a directory of .sh files using source to make the code available.
Has security implications. Use with caution and ensure your directory is protected.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
