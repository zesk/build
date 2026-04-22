#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="--exclude pattern - String. Optional. String passed to \`! -path pattern\` in \`find\`"$'\n'"directory ... - Directory. Required. Directory to \`source\` all \`.sh\` files used."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Load a directory of bash scripts, excluding any dot directories (\`*/.*/*\`), and optionally any additional"$'\n'"files if you use \`--exclude\`. But recursively loads scripts in sorted alphabetic order within the directory until one fails."$'\n'"All files must be executable."$'\n'"Load a directory of \`.sh\` files using \`source\` to make the code available."$'\n'"Has security implications. Use with caution and ensure your directory is protected."$'\n'""
file="bin/build/tools/bash.sh"
fn="bashSourcePath"
foundNames=([0]="summary" [1]="argument" [2]="security")
line="215"
lowerFn="bashsourcepath"
rawComment="Summary: Load a directory of bash scripts"$'\n'"Load a directory of bash scripts, excluding any dot directories (\`*/.*/*\`), and optionally any additional"$'\n'"files if you use \`--exclude\`. But recursively loads scripts in sorted alphabetic order within the directory until one fails."$'\n'"All files must be executable."$'\n'"Argument: --exclude pattern - String. Optional. String passed to \`! -path pattern\` in \`find\`"$'\n'"Argument: directory ... - Directory. Required. Directory to \`source\` all \`.sh\` files used."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Security: Loads bash files"$'\n'"Load a directory of \`.sh\` files using \`source\` to make the code available."$'\n'"Has security implications. Use with caution and ensure your directory is protected."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
security="Loads bash files"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="ce103c0a855c85ae7ea74c3b00899b56536cfe79"
sourceLine="215"
summary="Load a directory of bash scripts"$'\n'""
usage="bashSourcePath [ --exclude pattern ] directory ... [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashSourcePath'$'\e''[0m '$'\e''[[(blue)]m[ --exclude pattern ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mdirectory ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--exclude pattern  '$'\e''[[(value)]mString. Optional. String passed to '$'\e''[[(code)]m! -path pattern'$'\e''[[(reset)]m in '$'\e''[[(code)]mfind'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mdirectory ...      '$'\e''[[(value)]mDirectory. Required. Directory to '$'\e''[[(code)]msource'$'\e''[[(reset)]m all '$'\e''[[(code)]m.sh'$'\e''[[(reset)]m files used.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Load a directory of bash scripts, excluding any dot directories ('$'\e''[[(code)]m'$'\e''[[(cyan)]m/.'$'\e''[[(reset)]m/'$'\e''[[(cyan)]m'$'\e''[[(reset)]m), and optionally any additional'$'\e''[[(reset)]m'$'\n''files if you use '$'\e''[[(code)]m--exclude'$'\e''[[(reset)]m. But recursively loads scripts in sorted alphabetic order within the directory until one fails.'$'\n''All files must be executable.'$'\n''Load a directory of '$'\e''[[(code)]m.sh'$'\e''[[(reset)]m files using '$'\e''[[(code)]msource'$'\e''[[(reset)]m to make the code available.'$'\n''Has security implications. Use with caution and ensure your directory is protected.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashSourcePath [ --exclude pattern ] directory ... [ --help ]'$'\n'''$'\n''    --exclude pattern  String. Optional. String passed to ! -path pattern in find'$'\n''    directory ...      Directory. Required. Directory to source all .sh files used.'$'\n''    --help             Flag. Optional. Display this help.'$'\n'''$'\n''Load a directory of bash scripts, excluding any dot directories (/./), and optionally any additional'$'\n''files if you use --exclude. But recursively loads scripts in sorted alphabetic order within the directory until one fails.'$'\n''All files must be executable.'$'\n''Load a directory of .sh files using source to make the code available.'$'\n''Has security implications. Use with caution and ensure your directory is protected.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/bash.md"
