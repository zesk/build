#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/identical.sh"
argument="--prefix prefix - Required. A text prefix to search for to identify identical sections (e.g. \`# {identical}}\`) (may specify more than one)"$'\n'"token - String. Required. The token to repair."$'\n'"source -  File. Required. The token file source. First occurrence is used."$'\n'"destination -  File. Required. The token file to repair. Can be same as \`source\`."$'\n'"--stdout -  Flag. Optional.Output changed file to \`stdout\`"$'\n'""
base="identical.sh"
description="Repair an identical \`token\` in \`destination\` from \`source\`"$'\n'""
file="bin/build/tools/identical.sh"
fn="identicalRepair"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/identical.sh"
sourceModified="1768683999"
summary="Repair an identical \`token\` in \`destination\` from \`source\`"
usage="identicalRepair --prefix prefix token source destination [ --stdout ]"
