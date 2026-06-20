#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'findArgumentFunction - Function. Required. Find arguments (for `find`) for cannon.\ncannonFile - File. Required. One or more files delimited with `|` characters, one per line `search|replace|findArguments|...`. If not files are supplied then pipe file via stdin.\n'
base="deprecated-tools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run textCannon using a configuration file or files.\nComment lines (First character is `#`) are considered the current "state" (e.g. version) and are displayed during processing.\n\nSample file:\n\n    # v0.25.0\n    timingStart|timingStart\n    timingReport|timingReport\n    bashUserInput|bashUserInput\n\n    # v0.24.0\n    listJoin|listJoin\n    mapTokens|mapTokens\n\n'
descriptionLineCount="14"
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedCannonFile"
fnMarker="deprecatedcannonfile"
foundNames=([0]="argument" [1]="return_code")
line="172"
original="deprecatedCannonFile"
rawComment=$'Argument: findArgumentFunction - Function. Required. Find arguments (for `find`) for cannon.\nArgument: cannonFile - File. Required. One or more files delimited with `|` characters, one per line `search|replace|findArguments|...`. If not files are supplied then pipe file via stdin.\nRun textCannon using a configuration file or files.\nComment lines (First character is `#`) are considered the current "state" (e.g. version) and are displayed during processing.\nSample file:\n    # v0.25.0\n    timingStart|timingStart\n    timingReport|timingReport\n    bashUserInput|bashUserInput\n    # v0.24.0\n    listJoin|listJoin\n    mapTokens|mapTokens\nReturn Code: 0 - No changes were made in any files.\nReturn Code: 1 - changes were made in at least one file.\n\n'
return_code=$'0 - No changes were made in any files.\n1 - changes were made in at least one file.\n'
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceHash="db3a69b3802bf02c741786f5456bb2a207a20d8b"
sourceLine="172"
summary="Run textCannon using a configuration file or files."
summaryComputed="true"
usage="deprecatedCannonFile findArgumentFunction cannonFile"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeprecatedCannonFile'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfindArgumentFunction'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcannonFile'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfindArgumentFunction  '$'\e''[[(value)]mFunction. Required. Find arguments (for '$'\e''[[(code)]mfind'$'\e''[[(reset)]m) for cannon.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mcannonFile            '$'\e''[[(value)]mFile. Required. One or more files delimited with '$'\e''[[(code)]m|'$'\e''[[(reset)]m characters, one per line '$'\e''[[(code)]msearch|replace|findArguments|...'$'\e''[[(reset)]m. If not files are supplied then pipe file via stdin.'$'\e''[[(reset)]m'$'\n'''$'\n''Run textCannon using a configuration file or files.'$'\n''Comment lines (First character is '$'\e''[[(code)]m#'$'\e''[[(reset)]m) are considered the current "state" (e.g. version) and are displayed during processing.'$'\n'''$'\n''Sample file:'$'\n'''$'\n''    # v0.25.0'$'\n''    timingStart|timingStart'$'\n''    timingReport|timingReport'$'\n''    bashUserInput|bashUserInput'$'\n'''$'\n''    # v0.24.0'$'\n''    listJoin|listJoin'$'\n''    mapTokens|mapTokens'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - No changes were made in any files.'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - changes were made in at least one file.'
# shellcheck disable=SC2016
helpPlain='Usage: deprecatedCannonFile findArgumentFunction cannonFile'$'\n'''$'\n''    findArgumentFunction  Function. Required. Find arguments (for find) for cannon.'$'\n''    cannonFile            File. Required. One or more files delimited with | characters, one per line search|replace|findArguments|.... If not files are supplied then pipe file via stdin.'$'\n'''$'\n''Run textCannon using a configuration file or files.'$'\n''Comment lines (First character is #) are considered the current "state" (e.g. version) and are displayed during processing.'$'\n'''$'\n''Sample file:'$'\n'''$'\n''    # v0.25.0'$'\n''    timingStart|timingStart'$'\n''    timingReport|timingReport'$'\n''    bashUserInput|bashUserInput'$'\n'''$'\n''    # v0.24.0'$'\n''    listJoin|listJoin'$'\n''    mapTokens|mapTokens'$'\n'''$'\n''Return codes:'$'\n''- 0 - No changes were made in any files.'$'\n''- 1 - changes were made in at least one file.'
documentationPath="documentation/source/tools/deprecated.md"
