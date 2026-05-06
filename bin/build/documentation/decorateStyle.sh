#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="style - String. Required. The style to fetch or replace."$'\n'"newFormat - String. Optional. The new style formatting options as a string in the form \`escapeCodes label\`"$'\n'""
base="style.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="When \`newFormat\` is blank, retrieves the format style."$'\n'"Otherwise sets the new style."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/decorate/style.sh"
fn="decorateStyle"
fnMarker="decoratestyle"
foundNames=([0]="summary" [1]="argument")
line="11"
rawComment="Summary: Get or modify a decoration style"$'\n'"When \`newFormat\` is blank, retrieves the format style."$'\n'"Otherwise sets the new style."$'\n'"Argument: style - String. Required. The style to fetch or replace."$'\n'"Argument: newFormat - String. Optional. The new style formatting options as a string in the form \`escapeCodes label\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate/style.sh"
sourceHash="7e1bc39ef7ab83d3d3fc659a5a00cd2280aa7413"
sourceLine="11"
summary="Get or modify a decoration style"
summaryComputed=""
usage="decorateStyle style [ newFormat ]"
