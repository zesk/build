#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--path pathName=icon - Flag. Optional. Add an additional path mapping to icon.\n--no-app - Flag. Optional. Do not map `BUILD_HOME`.\n--skip-app - Flag. Optional. Synonym for `--no-app`.\npath - String. Path to display and replace matching paths with icons.\n'
base="path.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Replace an absolute path prefix with an icon if it matches `HOME`, `BUILD_HOME` or `TMPDIR`\nIcons used:\n- 💣 - `TMPDIR`\n- 🍎 - `BUILD_HOME`\n- 🏠 - `HOME`\n\n'
descriptionLineCount="6"
environment=$'TMPDIR\nBUILD_HOME\nHOME\n'
file="bin/build/tools/decorate/path.sh"
fn="decoratePath"
fnMarker="decoratepath"
foundNames=([0]="summary" [1]="argument" [2]="environment")
line="21"
rawComment=$'Summary: Display file paths and replace prefixes with icons\nReplace an absolute path prefix with an icon if it matches `HOME`, `BUILD_HOME` or `TMPDIR`\nArgument: --help - Flag. Optional. Display this help.\nArgument: --path pathName=icon - Flag. Optional. Add an additional path mapping to icon.\nArgument: --no-app - Flag. Optional. Do not map `BUILD_HOME`.\nArgument: --skip-app - Flag. Optional. Synonym for `--no-app`.\nArgument: path - String. Path to display and replace matching paths with icons.\nIcons used:\n- 💣 - `TMPDIR`\n- 🍎 - `BUILD_HOME`\n- 🏠 - `HOME`\nEnvironment: TMPDIR\nEnvironment: BUILD_HOME\nEnvironment: HOME\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/decorate/path.sh"
sourceHash="1f959f28b75bd7359b6cfa5f9964fd1324809cdd"
sourceLine="21"
summary="Display file paths and replace prefixes with icons"
summaryComputed=""
usage="decoratePath [ --help ] [ --path pathName=icon ] [ --no-app ] [ --skip-app ] [ path ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecoratePath'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --path pathName=icon ]'$'\e''[0m '$'\e''[[(blue)]m[ --no-app ]'$'\e''[0m '$'\e''[[(blue)]m[ --skip-app ]'$'\e''[0m '$'\e''[[(blue)]m[ path ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help                '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--path pathName=icon  '$'\e''[[(value)]mFlag. Optional. Add an additional path mapping to icon.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--no-app              '$'\e''[[(value)]mFlag. Optional. Do not map '$'\e''[[(code)]mBUILD_HOME'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--skip-app            '$'\e''[[(value)]mFlag. Optional. Synonym for '$'\e''[[(code)]m--no-app'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mpath                  '$'\e''[[(value)]mString. Path to display and replace matching paths with icons.'$'\e''[[(reset)]m'$'\n'''$'\n''Replace an absolute path prefix with an icon if it matches '$'\e''[[(code)]mHOME'$'\e''[[(reset)]m, '$'\e''[[(code)]mBUILD_HOME'$'\e''[[(reset)]m or '$'\e''[[(code)]mTMPDIR'$'\e''[[(reset)]m'$'\n''Icons used:'$'\n''- 💣 - '$'\e''[[(code)]mTMPDIR'$'\e''[[(reset)]m'$'\n''- 🍎 - '$'\e''[[(code)]mBUILD_HOME'$'\e''[[(reset)]m'$'\n''- 🏠 - '$'\e''[[(code)]mHOME'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- TMPDIR'$'\n''- BUILD_HOME'$'\n''- HOME'
# shellcheck disable=SC2016
helpPlain='Usage: decoratePath [ --help ] [ --path pathName=icon ] [ --no-app ] [ --skip-app ] [ path ]'$'\n'''$'\n''    --help                Flag. Optional. Display this help.'$'\n''    --path pathName=icon  Flag. Optional. Add an additional path mapping to icon.'$'\n''    --no-app              Flag. Optional. Do not map BUILD_HOME.'$'\n''    --skip-app            Flag. Optional. Synonym for --no-app.'$'\n''    path                  String. Path to display and replace matching paths with icons.'$'\n'''$'\n''Replace an absolute path prefix with an icon if it matches HOME, BUILD_HOME or TMPDIR'$'\n''Icons used:'$'\n''- 💣 - TMPDIR'$'\n''- 🍎 - BUILD_HOME'$'\n''- 🏠 - HOME'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- TMPDIR'$'\n''- BUILD_HOME'$'\n''- HOME'
documentationPath="documentation/source/tools/decoration.md"
