#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--timeout seconds - Integer. Optional."$'\n'""
base="daemontools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Terminate daemontools as gracefully as possible"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/daemontools.sh"
fn="daemontoolsTerminate"
fnMarker="daemontoolsterminate"
foundNames=([0]="argument" [1]="requires")
line="332"
rawComment="Terminate daemontools as gracefully as possible"$'\n'"Argument: --timeout seconds - Integer. Optional."$'\n'"Requires: throwArgument decorate usageArgumentInteger throwEnvironment catchEnvironment validate statusMessage"$'\n'"Requires: svscanboot id svc svstat"$'\n'""$'\n'""
requires="throwArgument decorate usageArgumentInteger throwEnvironment catchEnvironment validate statusMessage"$'\n'"svscanboot id svc svstat"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="f448dbffaa1f7e767bd20c8f8728f0f9e0597de0"
sourceLine="332"
summary="Terminate daemontools as gracefully as possible"
summaryComputed="true"
usage="daemontoolsTerminate [ --timeout seconds ]"
