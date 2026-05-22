#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-21
# shellcheck disable=SC2034
argument="--env-file envFile - File. Optional. Load this environment file prior to processing input."$'\n'"--default defaultString - String. Optional. Default string for tokens. Can use additional tokens: \`{prefix}\` \`{suffix}\` \`{tokenName}\` and \`{token}\`. Set to \`--\` to output \`token\`."$'\n'"--prefix prefixString - String. Optional. Prefix character for tokens, defaults to \`{\`."$'\n'"--suffix suffixString - String. Optional. Suffix character for tokens, defaults to \`}\`."$'\n'" mapFunction ... - Function. Required. Replacement function with arguments. Called as is with three additional arguments: \`tokenName\` \`offset\` \`total\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="map.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Map tokens in the input stream based on some heuristic."$'\n'""$'\n'"Converts tokens in the form \`{VARIABLE}\` to the associated value."$'\n'""$'\n'"Undefined values are not converted."$'\n'""$'\n'"\`mapFunction\` should return non-zero to have the default behavior occur. If a zero exit code is output then some replacement value is assumed to be written to \`stdout\` by the \`mapFunction\`."$'\n'"The special return code 120 is used to terminate the calling function immediately."$'\n'""$'\n'""
descriptionLineCount="9"
file="bin/build/tools/map.sh"
fn="mapFunction"
fnMarker="mapfunction"
foundNames=([0]="summary" [1]="see" [2]="argument" [3]="return_code" [4]="requires")
line="37"
rawComment="Summary: Convert tokens in input to values"$'\n'"Map tokens in the input stream based on some heuristic."$'\n'"Converts tokens in the form \`{VARIABLE}\` to the associated value."$'\n'"Undefined values are not converted."$'\n'"See: mapValue mapEnvironment"$'\n'"Argument: --env-file envFile - File. Optional. Load this environment file prior to processing input."$'\n'"Argument: --default defaultString - String. Optional. Default string for tokens. Can use additional tokens: \`{prefix}\` \`{suffix}\` \`{tokenName}\` and \`{token}\`. Set to \`--\` to output \`token\`."$'\n'"Argument: --prefix prefixString - String. Optional. Prefix character for tokens, defaults to \`{\`."$'\n'"Argument: --suffix suffixString - String. Optional. Suffix character for tokens, defaults to \`}\`."$'\n'"Argument:  mapFunction ... - Function. Required. Replacement function with arguments. Called as is with three additional arguments: \`tokenName\` \`offset\` \`total\`"$'\n'"\`mapFunction\` should return non-zero to have the default behavior occur. If a zero exit code is output then some replacement value is assumed to be written to \`stdout\` by the \`mapFunction\`."$'\n'"The special return code 120 is used to terminate the calling function immediately."$'\n'"Return Code: 120 - Map function exited early"$'\n'"Return Code: 130 - User interrupt (exits early)"$'\n'"Return Code: 141 - System interrupt (exits early)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: cat throwEnvironment catchEnvironment"$'\n'"Requires: throwArgument decorate validate"$'\n'""$'\n'""
requires="cat throwEnvironment catchEnvironment"$'\n'"throwArgument decorate validate"$'\n'""
return_code="120 - Map function exited early"$'\n'"130 - User interrupt (exits early)"$'\n'"141 - System interrupt (exits early)"$'\n'""
see="mapValue mapEnvironment"$'\n'""
sourceFile="bin/build/tools/map.sh"
sourceHash="28c85a1a2f0604d47009077a23130a3172acf6bf"
sourceLine="37"
summary="Convert tokens in input to values"
summaryComputed=""
usage="mapFunction [ --env-file envFile ] [ --default defaultString ] [ --prefix prefixString ] [ --suffix suffixString ]  mapFunction ... [ --help ]"
