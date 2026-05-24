#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="core.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output a list of build-in decoration styles, one per line\n\n'
descriptionLineCount="2"
file="bin/build/tools/decorate/core.sh"
fn="decorations"
fnMarker="decorations"
foundNames=([0]="argument" [1]="requires")
line="66"
rawComment=$'Output a list of build-in decoration styles, one per line\nArgument: --help - Flag. Optional. Display this help.\nRequires: helpArgument convertValue\n\n'
requires=$'helpArgument convertValue\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/decorate/core.sh"
sourceHash="e4cbe4eab5673d871026d759c95b8accc63d09fa"
sourceLine="66"
summary="Output a list of build-in decoration styles, one per line"
summaryComputed="true"
usage="decorations [ --help ]"
