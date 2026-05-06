#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--cached fingerprint - String. Optional. Instead of computing the \`application-fingerprint\` using the hook, use this value."$'\n'"--verbose - Flag. Optional. Be verbose. Default based on value of \`fingerprint\` in \`BUILD_DEBUG\`."$'\n'"--quiet - Flag. Optional. Be quiet (turns verbose off)."$'\n'"--check - Flag. Optional. Check if the fingerprint is up to date and output the current value."$'\n'"--key - String. Optional. Update this key in the JSON file."$'\n'""
base="fingerprint.sh"
build_debug="fingerprint - By default be verbose even if the flag is not specified. (Use \`--quiet\` to silence if needed)"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Update file from \`APPLICATION_JSON\` with application fingerprint."$'\n'""$'\n'""
descriptionLineCount="2"
environment="BUILD_DEBUG"$'\n'""
file="bin/build/tools/fingerprint.sh"
fn="fingerprint"
fnMarker="fingerprint"
foundNames=([0]="argument" [1]="build_debug" [2]="environment")
line="20"
rawComment="Update file from \`APPLICATION_JSON\` with application fingerprint."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --cached fingerprint - String. Optional. Instead of computing the \`application-fingerprint\` using the hook, use this value."$'\n'"Argument: --verbose - Flag. Optional. Be verbose. Default based on value of \`fingerprint\` in \`BUILD_DEBUG\`."$'\n'"Argument: --quiet - Flag. Optional. Be quiet (turns verbose off)."$'\n'"Argument: --check - Flag. Optional. Check if the fingerprint is up to date and output the current value."$'\n'"Argument: --key - String. Optional. Update this key in the JSON file."$'\n'"BUILD_DEBUG: fingerprint - By default be verbose even if the flag is not specified. (Use \`--quiet\` to silence if needed)"$'\n'"Environment: BUILD_DEBUG"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/fingerprint.sh"
sourceHash="49a63199ff174cbed6ab98a90e90c51a476ff1bc"
sourceLine="20"
summary="Update file from \`APPLICATION_JSON\` with application fingerprint."
summaryComputed="true"
usage="fingerprint [ --help ] [ --handler handler ] [ --cached fingerprint ] [ --verbose ] [ --quiet ] [ --check ] [ --key ]"
