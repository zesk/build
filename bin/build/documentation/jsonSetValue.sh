#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--filter - Function. Optional. Run value through this filter prior to inserting into the JSON file."$'\n'"--status - Flag. Optional. When set, returns \`0\` when the value was updated successfully and \`\$(returnCode identical)\` when the values is the same"$'\n'"--quiet - Flag. Optional. Do not output anything to \`stdout\` and just do the action and exit."$'\n'"--generator - Function. Optional. Function to generate the value. Defaults to \`hookVersionCurrent\`."$'\n'"--value - String. Optional. Value to set in JSON file. (Skips generation)"$'\n'"--key - String. Optional. Key to set in JSON file. Defaults to \`version\`."$'\n'"key - Required. If not specified as \`--key\`, specify it here."$'\n'"file - File. Required. Modify and update this file"$'\n'""
base="json.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Sets the value of a variable in a JSON file"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/json.sh"
fn="jsonSetValue"
fnMarker="jsonsetvalue"
foundNames=([0]="argument" [1]="return_code")
line="158"
rawComment="Sets the value of a variable in a JSON file"$'\n'"Argument: --filter - Function. Optional. Run value through this filter prior to inserting into the JSON file."$'\n'"Argument: --status - Flag. Optional. When set, returns \`0\` when the value was updated successfully and \`\$(returnCode identical)\` when the values is the same"$'\n'"Argument: --quiet - Flag. Optional. Do not output anything to \`stdout\` and just do the action and exit."$'\n'"Argument: --generator - Function. Optional. Function to generate the value. Defaults to \`hookVersionCurrent\`."$'\n'"Argument: --value - String. Optional. Value to set in JSON file. (Skips generation)"$'\n'"Argument: --key - String. Optional. Key to set in JSON file. Defaults to \`version\`."$'\n'"Argument: key - Required. If not specified as \`--key\`, specify it here."$'\n'"Argument: file - File. Required. Modify and update this file"$'\n'"Return Code: 0 - File was updated successfully."$'\n'"Return Code: 1 - Environment error"$'\n'"Return Code: 2 - Argument error"$'\n'"Return Code: 105 - Identical files (only when --status is passed)"$'\n'""$'\n'""
return_code="0 - File was updated successfully."$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'"105 - Identical files (only when --status is passed)"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceHash="e4fa7a237368db1e6a6969ecf3a1c6f05241d727"
sourceLine="158"
summary="Sets the value of a variable in a JSON file"
summaryComputed="true"
usage="jsonSetValue [ --filter ] [ --status ] [ --quiet ] [ --generator ] [ --value ] [ --key ] key file"
