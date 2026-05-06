#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="core.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is the decorate color system initialized yet?"$'\n'"Useful to set our global color environment at the top level of a script if it hasn't been initialized already."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/decorate/core.sh"
fn="decorateInitialized"
fnMarker="decorateinitialized"
foundNames=([0]="argument" [1]="requires")
line="124"
rawComment="Is the decorate color system initialized yet?"$'\n'"Useful to set our global color environment at the top level of a script if it hasn't been initialized already."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: helpArgument"$'\n'""$'\n'""
requires="helpArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate/core.sh"
sourceHash="4288b1b5dd74b1f4240bb03c3728be0a51c51aa6"
sourceLine="124"
summary="Is the decorate color system initialized yet?"
summaryComputed="true"
usage="decorateInitialized [ --help ]"
