#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="daemontools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="List any processes associated with daemontools supervisors"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/daemontools.sh"
fn="daemontoolsProcessIds"
fnMarker="daemontoolsprocessids"
foundNames=([0]="requires")
line="310"
rawComment="List any processes associated with daemontools supervisors"$'\n'"Requires: pgrep read printf"$'\n'""$'\n'""
requires="pgrep read printf"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="f448dbffaa1f7e767bd20c8f8728f0f9e0597de0"
sourceLine="310"
summary="List any processes associated with daemontools supervisors"
summaryComputed="true"
usage="daemontoolsProcessIds"
