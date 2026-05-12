#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
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
line="352"
rawComment=$'Generate a function index for bash files.\nArgument: codePath ... - Directory. Required. OneOrMore. Path where code (`.sh` files) is stored (should remain identical between invocations)\nArgument: --target targetPath - Optional. Location to store the index file, called `code.index`.\nArgument: --verbose - Flag. Optional. Talk voluminously.\nSee: __documentationIndexLookup\nRequires: __pcregrep\n\n'
requires=$'__pcregrep\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'__documentationIndexLookup\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="0134555ea1c32d02fdc40fd9058827a280501390"
sourceLine="352"
summary="Generate a function index for bash files."
summaryComputed="true"
usage="documentationIndexGenerate codePath ... [ --target targetPath ] [ --verbose ]"
