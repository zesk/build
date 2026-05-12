#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n... - Arguments. Passed directly to `grep`.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'`grep` but returns 0 when nothing matches\n\nAllow blank files or no matches:\n\n- `grep` - returns 1 - no lines selected\n- `grep` - returns 0 - lines selected\n\n'
descriptionLineCount="7"
file="bin/build/tools/text.sh"
fn="grepSafe"
fnMarker="grepsafe"
foundNames=([0]="return_code" [1]="argument" [2]="see" [3]="requires")
line="75"
rawComment=$'`grep` but returns 0 when nothing matches\nAllow blank files or no matches:\n- `grep` - returns 1 - no lines selected\n- `grep` - returns 0 - lines selected\nReturn Code: 0 - Normal operation\nArgument: --help - Flag. Optional. Display this help.\nArgument: ... - Arguments. Passed directly to `grep`.\nSee: grep\nRequires: grep returnMap\n\n'
requires=$'grep returnMap\n'
return_code=$'0 - Normal operation\n'
see=$'grep\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="75"
summary="\`grep\` but returns 0 when nothing matches"
summaryComputed="true"
usage="grepSafe [ --help ] [ ... ]"
