#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="coverage.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Is bash coverage currently running?\n\n'
descriptionLineCount="2"
file="bin/build/tools/coverage.sh"
fn="bashCoverageEnabled"
fnMarker="bashcoverageenabled"
foundNames=([0]="argument" [1]="return_code")
line="114"
rawComment=$'Is bash coverage currently running?\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - Yes, it\'s running.\nReturn Code: 1 - No, it is not running.=\nReturn Code: 2 - Argument error\n\n'
return_code=$'0 - Yes, it\'s running.\n1 - No, it is not running.=\n2 - Argument error\n'
sourceFile="bin/build/tools/coverage.sh"
sourceHash="722f16e9f75d68a68128649b36bf97f3eec00345"
sourceLine="114"
summary="Is bash coverage currently running?"
summaryComputed="true"
usage="bashCoverageEnabled [ --help ]"
