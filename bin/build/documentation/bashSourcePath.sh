#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--exclude pattern - String. Optional. String passed to \`! -path pattern\` in \`find\`"$'\n'"directory ... - Directory. Required. Directory to \`source\` all \`.sh\` files used."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Load a directory of bash scripts, excluding any dot directories (\`*/.*/*\`), and optionally any additional"$'\n'"files if you use \`--exclude\`. But recursively loads scripts in sorted alphabetic order within the directory until one fails."$'\n'"All files must be executable."$'\n'"Load a directory of \`.sh\` files using \`source\` to make the code available."$'\n'"Has security implications. Use with caution and ensure your directory is protected."$'\n'""$'\n'""
descriptionLineCount="6"
file="bin/build/tools/bash.sh"
fn="bashSourcePath"
fnMarker="bashsourcepath"
foundNames=([0]="summary" [1]="argument" [2]="security")
line="215"
rawComment="Summary: Load a directory of bash scripts"$'\n'"Load a directory of bash scripts, excluding any dot directories (\`*/.*/*\`), and optionally any additional"$'\n'"files if you use \`--exclude\`. But recursively loads scripts in sorted alphabetic order within the directory until one fails."$'\n'"All files must be executable."$'\n'"Argument: --exclude pattern - String. Optional. String passed to \`! -path pattern\` in \`find\`"$'\n'"Argument: directory ... - Directory. Required. Directory to \`source\` all \`.sh\` files used."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Security: Loads bash files"$'\n'"Load a directory of \`.sh\` files using \`source\` to make the code available."$'\n'"Has security implications. Use with caution and ensure your directory is protected."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
security="Loads bash files"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="9d7b158a0e679532b85d7d28ad6415566e66b29c"
sourceLine="215"
summary="Load a directory of bash scripts"
summaryComputed=""
usage="bashSourcePath [ --exclude pattern ] directory ... [ --help ]"
