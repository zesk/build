#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/json.sh"
argument="--filter - Function. Optional. Run value through this filter prior to inserting into the JSON file."$'\n'"--status - Flag. Optional. When set, returns \`0\` when the value was updated successfully and \`\$(returnCode identical)\` when the values is the same"$'\n'"--quiet - Flag. Optional. Do not output anything to \`stdout\` and just do the action and exit."$'\n'"--generator - Function. Optional. Function to generate the value. Defaults to \`hookVersionCurrent\`."$'\n'"--value - String. Optional. Value to set in JSON file. (Skips generation)"$'\n'"--key - String. Optional. Key to set in JSON file. Defaults to \`version\`."$'\n'"key - Required. If not specified as \`--key\`, specify it here."$'\n'"file - File. Required. Modify and update this file"$'\n'""
base="json.sh"
description="Sets the value of a variable in a JSON file"$'\n'""$'\n'"Return Code: 0 - File was updated successfully."$'\n'"Return Code: 1 - Environment error"$'\n'"Return Code: 2 - Argument error"$'\n'"Return Code: 105 - Identical files (only when --status is passed)"$'\n'""
file="bin/build/tools/json.sh"
fn="jsonSetValue"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/json.sh"
sourceModified="1768721469"
summary="Sets the value of a variable in a JSON file"
usage="jsonSetValue [ --filter ] [ --status ] [ --quiet ] [ --generator ] [ --value ] [ --key ] key file"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mjsonSetValue[0m [94m[ --filter ][0m [94m[ --status ][0m [94m[ --quiet ][0m [94m[ --generator ][0m [94m[ --value ][0m [94m[ --key ][0m [38;2;255;255;0m[35;48;2;0;0;0mkey[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mfile[0m[0m

    [94m--filter     [1;97mFunction. Optional. Run value through this filter prior to inserting into the JSON file.[0m
    [94m--status     [1;97mFlag. Optional. When set, returns [38;2;0;255;0;48;2;0;0;0m0[0m when the value was updated successfully and [38;2;0;255;0;48;2;0;0;0m$(returnCode identical)[0m when the values is the same[0m
    [94m--quiet      [1;97mFlag. Optional. Do not output anything to [38;2;0;255;0;48;2;0;0;0mstdout[0m and just do the action and exit.[0m
    [94m--generator  [1;97mFunction. Optional. Function to generate the value. Defaults to [38;2;0;255;0;48;2;0;0;0mhookVersionCurrent[0m.[0m
    [94m--value      [1;97mString. Optional. Value to set in JSON file. (Skips generation)[0m
    [94m--key        [1;97mString. Optional. Key to set in JSON file. Defaults to [38;2;0;255;0;48;2;0;0;0mversion[0m.[0m
    [31mkey          [1;97mRequired. If not specified as [38;2;0;255;0;48;2;0;0;0m--key[0m, specify it here.[0m
    [31mfile         [1;97mFile. Required. Modify and update this file[0m

Sets the value of a variable in a JSON file

Return Code: 0 - File was updated successfully.
Return Code: 1 - Environment error
Return Code: 2 - Argument error
Return Code: 105 - Identical files (only when --status is passed)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: jsonSetValue [ --filter ] [ --status ] [ --quiet ] [ --generator ] [ --value ] [ --key ] key file

    --filter     Function. Optional. Run value through this filter prior to inserting into the JSON file.
    --status     Flag. Optional. When set, returns 0 when the value was updated successfully and $(returnCode identical) when the values is the same
    --quiet      Flag. Optional. Do not output anything to stdout and just do the action and exit.
    --generator  Function. Optional. Function to generate the value. Defaults to hookVersionCurrent.
    --value      String. Optional. Value to set in JSON file. (Skips generation)
    --key        String. Optional. Key to set in JSON file. Defaults to version.
    key          Required. If not specified as --key, specify it here.
    file         File. Required. Modify and update this file

Sets the value of a variable in a JSON file

Return Code: 0 - File was updated successfully.
Return Code: 1 - Environment error
Return Code: 2 - Argument error
Return Code: 105 - Identical files (only when --status is passed)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
