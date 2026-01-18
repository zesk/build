#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/json.sh"
argument="--filter - Function. Optional. Run value through this filter prior to inserting into the JSON file."$'\n'"--status - Flag. Optional. When set, returns \`0\` when the value was updated successfully and \`\$(returnCode identical)\` when the values is the same"$'\n'"--quiet - Flag. Optional. Do not output anything to \`stdout\` and just do the action and exit."$'\n'"--generator - Function. Optional. Function to generate the value. Defaults to \`hookVersionCurrent\`."$'\n'"--value - String. Optional. Value to set in JSON file. (Skips generation)"$'\n'"--key - String. Optional. Key to set in JSON file. Defaults to \`version\`."$'\n'"key - Required. If not specified as \`--key\`, specify it here."$'\n'"file - File. Required. Modify and update this file"$'\n'""
base="json.sh"
description="Sets the value of a variable in a JSON file"$'\n'""$'\n'"Return Code: 0 - File was updated successfully."$'\n'"Return Code: 1 - Environment error"$'\n'"Return Code: 2 - Argument error"$'\n'"Return Code: 105 - Identical files (only when --status is passed)"$'\n'""
file="bin/build/tools/json.sh"
fn="jsonSetValue"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/json.sh"
sourceModified="1768695708"
summary="Sets the value of a variable in a JSON file"
usage="jsonSetValue [ --filter ] [ --status ] [ --quiet ] [ --generator ] [ --value ] [ --key ] key file"
