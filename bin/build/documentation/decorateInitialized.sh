#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="core.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Is the decorate color system initialized yet?\nUseful to set our global color environment at the top level of a script if it hasn\'t been initialized already.\n\n'
descriptionLineCount="3"
file="bin/build/tools/decorate/core.sh"
fn="decorateInitialized"
fnMarker="decorateinitialized"
foundNames=([0]="argument" [1]="requires")
line="124"
rawComment=$'Is the decorate color system initialized yet?\nUseful to set our global color environment at the top level of a script if it hasn\'t been initialized already.\nArgument: --help - Flag. Optional. Display this help.\nRequires: helpArgument\n\n'
requires=$'helpArgument\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/decorate/core.sh"
sourceHash="e4cbe4eab5673d871026d759c95b8accc63d09fa"
sourceLine="124"
summary="Is the decorate color system initialized yet?"
summaryComputed="true"
usage="decorateInitialized [ --help ]"
