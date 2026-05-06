#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"directory - Directory. Optional. Set the application home to this directory."$'\n'"--go - Flag. Optional. Change to the current saved application home directory."$'\n'""
base="application.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Set, or cd to current application home directory."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/application.sh"
fn="applicationHome"
fnMarker="applicationhome"
foundNames=([0]="argument")
line="52"
rawComment="Set, or cd to current application home directory."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: directory - Directory. Optional. Set the application home to this directory."$'\n'"Argument: --go - Flag. Optional. Change to the current saved application home directory."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/application.sh"
sourceHash="562d2de8a12e4176ee14a47d79968f58574ee69d"
sourceLine="52"
summary="Set, or cd to current application home directory."
summaryComputed="true"
usage="applicationHome [ --help ] [ directory ] [ --go ]"
