#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--exclude pattern - String. Optional. String passed to \`! -path pattern\` in \`find\`"$'\n'"directory ... - Directory. Required. Directory to \`source\` all \`.sh\` files used."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Load a directory of bash scripts, excluding any dot directories (\`*/.*/*\`), and optionally any additional"$'\n'"files if you use \`--exclude\`. But recursively loads scripts in sorted alphabetic order within the directory until one fails."$'\n'"All files must be executable."$'\n'"Load a directory of \`.sh\` files using \`source\` to make the code available."$'\n'"Has security implications. Use with caution and ensure your directory is protected."$'\n'""
file="bin/build/tools/bash.sh"
fn="bashSourcePath"
foundNames=([0]="summary" [1]="argument" [2]="security")
rawComment="Summary: Load a directory of bash scripts"$'\n'"Load a directory of bash scripts, excluding any dot directories (\`*/.*/*\`), and optionally any additional"$'\n'"files if you use \`--exclude\`. But recursively loads scripts in sorted alphabetic order within the directory until one fails."$'\n'"All files must be executable."$'\n'"Argument: --exclude pattern - String. Optional. String passed to \`! -path pattern\` in \`find\`"$'\n'"Argument: directory ... - Directory. Required. Directory to \`source\` all \`.sh\` files used."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Security: Loads bash files"$'\n'"Load a directory of \`.sh\` files using \`source\` to make the code available."$'\n'"Has security implications. Use with caution and ensure your directory is protected."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
security="Loads bash files"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="f595398f728c584ee7c7e2255d6ece3e08b0d67d"
summary="Load a directory of bash scripts"$'\n'""
usage="bashSourcePath [ --exclude pattern ] directory ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''
