#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument=$'--target templateTarget - FileDirectory. Required. Create templates here.\n--help - Flag. Optional. Display this help.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Generates the following (with example content):\n- `applicationName.md` - `Zesk Build`\n- `applicationOwner.md` - `Market Acumen, Inc.`\n- `year.md` - `2026`\n- `version.md` - `v0.43.2`\n- `timestamp.md` - `1779910142`\n- `timestampString.md` - `2026-05-27 15:29:15`\n\n'
descriptionLineCount="8"
file="bin/build/tools/documentation.sh"
fn="bashDocumentationDefaults"
fnMarker="bashdocumentationdefaults"
foundNames=([0]="summary" [1]="argument")
line="711"
rawComment=$'Summary: Generate base template files for Bash code documentation.\nGenerates the following (with example content):\n- `applicationName.md` - `Zesk Build`\n- `applicationOwner.md` - `Market Acumen, Inc.`\n- `year.md` - `2026`\n- `version.md` - `v0.43.2`\n- `timestamp.md` - `1779910142`\n- `timestampString.md` - `2026-05-27 15:29:15`\nArgument: --target templateTarget - FileDirectory. Required. Create templates here.\nArgument: --help - Flag. Optional. Display this help.\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="ba0c1b09de9318e5d93a3d83b2f6b1368cb126e4"
sourceLine="711"
summary="Generate base template files for Bash code documentation."
summaryComputed=""
usage="bashDocumentationDefaults --target templateTarget [ --help ] [ --handler handler ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashDocumentationDefaults'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m--target templateTarget'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]m--target templateTarget  '$'\e''[[(value)]mFileDirectory. Required. Create templates here.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler        '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n'''$'\n''Generates the following (with example content):'$'\n''- '$'\e''[[(code)]mapplicationName.md'$'\e''[[(reset)]m - '$'\e''[[(code)]mZesk Build'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mapplicationOwner.md'$'\e''[[(reset)]m - '$'\e''[[(code)]mMarket Acumen, Inc.'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]myear.md'$'\e''[[(reset)]m - '$'\e''[[(code)]m2026'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mversion.md'$'\e''[[(reset)]m - '$'\e''[[(code)]mv0.43.2'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mtimestamp.md'$'\e''[[(reset)]m - '$'\e''[[(code)]m1779910142'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mtimestampString.md'$'\e''[[(reset)]m - '$'\e''[[(code)]m2026-05-27 15:29:15'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashDocumentationDefaults --target templateTarget [ --help ] [ --handler handler ]'$'\n'''$'\n''    --target templateTarget  FileDirectory. Required. Create templates here.'$'\n''    --help                   Flag. Optional. Display this help.'$'\n''    --handler handler        Function. Optional. Use this error handler instead of the default error handler.'$'\n'''$'\n''Generates the following (with example content):'$'\n''- applicationName.md - Zesk Build'$'\n''- applicationOwner.md - Market Acumen, Inc.'$'\n''- year.md - 2026'$'\n''- version.md - v0.43.2'$'\n''- timestamp.md - 1779910142'$'\n''- timestampString.md - 2026-05-27 15:29:15'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/documentation.md"
