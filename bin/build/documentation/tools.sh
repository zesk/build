#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--start startDirectory - Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"... - Callable. Optional. Run this command after loading in the current build context."$'\n'""
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run a Zesk Build command or load it"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/build.sh"
fn="tools"
fnMarker="tools"
foundNames=([0]="argument")
line="474"
rawComment="Run a Zesk Build command or load it"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --start startDirectory - Directory. Optional. Start searching for a build installation at this location and searching upwards in the file hierarchy."$'\n'"Argument: --verbose - Flag. Optional. Be verbose."$'\n'"Argument: ... - Callable. Optional. Run this command after loading in the current build context."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceHash="8814c5b6b68b94aa734c4c337d9463150c6d754d"
sourceLine="474"
summary="Run a Zesk Build command or load it"
summaryComputed="true"
usage="tools [ --help ] [ --start startDirectory ] [ --verbose ] [ ... ]"
