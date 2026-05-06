#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--delta deltaMilliseconds - PositiveInteger. Optional. Default is 60000."$'\n'"--mark - Flag. Optional. Write the marker which says the"$'\n'"--verbose - Flag. Optional. Be chatty."$'\n'"name - EnvironmentVariable. Required. The global codename for this interaction."$'\n'""
base="interactive.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Do something the first time and then only occasionally thereafter."$'\n'"This manages a state file compared to the current time and triggers after \`delta\` seconds."$'\n'"Think of it like something that only returns 0 like once every \`delta\` seconds but it's going to happen at minimum \`delta\` seconds, or the next time after that. And the first time as well."$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/interactive.sh"
fn="interactiveOccasionally"
fnMarker="interactiveoccasionally"
foundNames=([0]="argument" [1]="return_code")
line="245"
rawComment="Do something the first time and then only occasionally thereafter."$'\n'"This manages a state file compared to the current time and triggers after \`delta\` seconds."$'\n'"Think of it like something that only returns 0 like once every \`delta\` seconds but it's going to happen at minimum \`delta\` seconds, or the next time after that. And the first time as well."$'\n'"Argument: --delta deltaMilliseconds - PositiveInteger. Optional. Default is 60000."$'\n'"Argument: --mark - Flag. Optional. Write the marker which says the"$'\n'"Argument: --verbose - Flag. Optional. Be chatty."$'\n'"Argument: name - EnvironmentVariable. Required. The global codename for this interaction."$'\n'"Return Code: 0 - Do the thing"$'\n'"Return Code: 1 - Do not do the thing"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="0 - Do the thing"$'\n'"1 - Do not do the thing"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceHash="378aca49779b1c4a5f70a0c419c2a078d3e0d369"
sourceLine="245"
summary="Do something the first time and then only occasionally thereafter."
summaryComputed="true"
usage="interactiveOccasionally [ --delta deltaMilliseconds ] [ --mark ] [ --verbose ] name"
