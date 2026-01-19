#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="--exclude pattern - String. Optional. String passed to \`! -path pattern\` in \`find\`"$'\n'"directory ... - Directory. Required. Directory to \`source\` all \`.sh\` files used."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Load a directory of bash scripts, excluding any dot directories (\`*/.*/*\`), and optionally any additional"$'\n'"files if you use \`--exclude\`. But recursively loads scripts in sorted alphabetic order within the directory until one fails."$'\n'"All files must be executable."$'\n'"Load a directory of \`.sh\` files using \`source\` to make the code available."$'\n'"Has security implications. Use with caution and ensure your directory is protected."$'\n'""
file="bin/build/tools/bash.sh"
fn="bashSourcePath"
foundNames=([0]="summary" [1]="argument" [2]="security")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
security="Loads bash files"$'\n'""
source="bin/build/tools/bash.sh"
sourceModified="1768776883"
summary="Load a directory of bash scripts"$'\n'""
usage="bashSourcePath [ --exclude pattern ] directory ... [ --help ]"
