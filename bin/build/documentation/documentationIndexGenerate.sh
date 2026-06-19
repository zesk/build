#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'codePath ... - Directory. Required. OneOrMore. Path where code (`.sh` files) is stored (should remain identical between invocations)\n--target targetPath - Optional. Location to store the index file, called `code.index`.\n--verbose - Flag. Optional. Talk voluminously.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Generate a function index for bash files.\n\n'
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationIndexGenerate"
fnMarker="documentationindexgenerate"
foundNames=([0]="argument" [1]="see" [2]="requires")
line="365"
rawComment=$'Generate a function index for bash files.\nArgument: codePath ... - Directory. Required. OneOrMore. Path where code (`.sh` files) is stored (should remain identical between invocations)\nArgument: --target targetPath - Optional. Location to store the index file, called `code.index`.\nArgument: --verbose - Flag. Optional. Talk voluminously.\nSee: documentationIndexLookup\nRequires: __pcregrep\n\n'
requires=$'__pcregrep\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'documentationIndexLookup\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="ef3313a629019568fc5c7615c4fd5ee40243187d"
sourceLine="365"
summary="Generate a function index for bash files."
summaryComputed="true"
usage="documentationIndexGenerate codePath ... [ --target targetPath ] [ --verbose ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationIndexGenerate'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcodePath ...'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --target targetPath ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mcodePath ...         '$'\e''[[(value)]mDirectory. Required. OneOrMore. Path where code ('$'\e''[[(code)]m.sh'$'\e''[[(reset)]m files) is stored (should remain identical between invocations)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--target targetPath  '$'\e''[[(value)]mOptional. Location to store the index file, called '$'\e''[[(code)]mcode.index'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose            '$'\e''[[(value)]mFlag. Optional. Talk voluminously.'$'\e''[[(reset)]m'$'\n'''$'\n''Generate a function index for bash files.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: documentationIndexGenerate codePath ... [ --target targetPath ] [ --verbose ]'$'\n'''$'\n''    codePath ...         Directory. Required. OneOrMore. Path where code (.sh files) is stored (should remain identical between invocations)'$'\n''    --target targetPath  Optional. Location to store the index file, called code.index.'$'\n''    --verbose            Flag. Optional. Talk voluminously.'$'\n'''$'\n''Generate a function index for bash files.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/documentation.md"
