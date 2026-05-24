#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
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
rawComment=$'Argument: findArgumentFunction - Function. Required. Find arguments (for `find`) for cannon.\nArgument: cannonFile - File. Required. One or more files delimited with `|` characters, one per line `search|replace|findArguments|...`. If not files are supplied then pipe file via stdin.\nRun textCannon using a configuration file or files.\nComment lines (First character is `#`) are considered the current "state" (e.g. version) and are displayed during processing.\nSample file:\n    # v0.25.0\n    timingStart|timingStart\n    timingReport|timingReport\n    bashUserInput|bashUserInput\n    # v0.24.0\n    listJoin|listJoin\n    mapTokens|mapTokens\nReturn Code: 0 - No changes were made in any files.\nReturn Code: 1 - changes were made in at least one file.\n\n'
return_code=$'0 - No changes were made in any files.\n1 - changes were made in at least one file.\n'
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceHash="c58292dcfad3a5d9edce856e942a3610ee71cd20"
sourceLine="172"
summary="Run textCannon using a configuration file or files."
summaryComputed="true"
usage="deprecatedCannonFile findArgumentFunction cannonFile"
