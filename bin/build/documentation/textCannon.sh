#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\n--path cannonPath - Directory. Optional. Run textCannon operation starting in this directory.\nfromText - Required. String of text to search for.\ntoText - Required. String of text to replace.\nfindArgs ... - Arguments. Optional. Any additional arguments are meant to filter files.\n'
base="map.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Replace text `fromText` with `toText` in files, using `findArgs` to filter files if needed.\n\nThis can break your files so use with caution. Blank `searchText` is **not allowed**.\nThe term `textCannon` is not a mistake - it will break something at some point.\n\n'
descriptionLineCount="5"
example=$'    textCannon master main ! -path \'*/old-version/*\')\n'
file="bin/build/tools/map.sh"
fn="textCannon"
fnMarker="textcannon"
foundNames=([0]="summary" [1]="example" [2]="argument" [3]="return_code")
line="478"
rawComment=$'Summary: Replace text `fromText` with `toText` in files\nReplace text `fromText` with `toText` in files, using `findArgs` to filter files if needed.\nThis can break your files so use with caution. Blank `searchText` is **not allowed**.\nThe term `textCannon` is not a mistake - it will break something at some point.\nExample:     {fn} master main ! -path \'*/old-version/*\')\nArgument: --help - Flag. Optional. Display this help.\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\nArgument: --path cannonPath - Directory. Optional. Run textCannon operation starting in this directory.\nArgument: fromText - Required. String of text to search for.\nArgument: toText - Required. String of text to replace.\nArgument: findArgs ... - Arguments. Optional. Any additional arguments are meant to filter files.\nReturn Code: 0 - Success, no files changed\nReturn Code: 3 - At least one or more files were modified successfully\nReturn Code: 1 - --path is not a directory\nReturn Code: 1 - searchText is not blank\nReturn Code: 1 - `fileTemporaryName` failed\nReturn Code: 2 - Arguments are identical\n\n'
return_code=$'0 - Success, no files changed\n3 - At least one or more files were modified successfully\n1 - --path is not a directory\n1 - searchText is not blank\n1 - `fileTemporaryName` failed\n2 - Arguments are identical\n'
sourceFile="bin/build/tools/map.sh"
sourceHash="ad239b6bc25f5b8d6c7ef606feeaa9161fae799e"
sourceLine="478"
summary="Replace text \`fromText\` with \`toText\` in files"
summaryComputed=""
usage="textCannon [ --help ] [ --handler handler ] [ --path cannonPath ] fromText toText [ findArgs ... ]"
