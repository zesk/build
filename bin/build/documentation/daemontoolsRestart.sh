#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="daemontools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Restart the daemontools processes from scratch."$'\n'"Dangerous. Stops any running services and restarts them."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/daemontools.sh"
fn="daemontoolsRestart"
fnMarker="daemontoolsrestart"
foundNames=()
line="393"
rawComment="Restart the daemontools processes from scratch."$'\n'"Dangerous. Stops any running services and restarts them."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="f448dbffaa1f7e767bd20c8f8728f0f9e0597de0"
sourceLine="393"
summary="Restart the daemontools processes from scratch."
summaryComputed="true"
usage="daemontoolsRestart"
