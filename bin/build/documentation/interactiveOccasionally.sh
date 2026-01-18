#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--delta deltaMilliseconds - PositiveInteger. Optional. Default is 60000."$'\n'"--mark - Flag. Optional. Write the marker which says the"$'\n'"--verbose - Flag. Optional. Be chatty."$'\n'"name - EnvironmentVariable. Required. The global codename for this interaction."$'\n'""
base="interactive.sh"
description="Do something the first time and then only occasionally thereafter."$'\n'"This manages a state file compared to the current time and triggers after \`delta\` seconds."$'\n'"Think of it like something that only returns 0 like once every \`delta\` seconds but it's going to happen at minimum \`delta\` seconds, or the next time after that. And the first time as well."$'\n'"Return Code: 0 - Do the thing"$'\n'"Return Code: 1 - Do not do the thing"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/interactive.sh"
fn="interactiveOccasionally"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/interactive.sh"
sourceModified="1768721469"
summary="Do something the first time and then only occasionally thereafter."
usage="interactiveOccasionally [ --delta deltaMilliseconds ] [ --mark ] [ --verbose ] name"
