#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/fingerprint.sh"
argument="--help - Flag. Optional.Display this help."$'\n'"--handler handler - Function. Optional.Use this error handler instead of the default error handler."$'\n'"--verbose - Flag. Optional. Be verbose. Default based on value of \`fingerprint\` in \`BUILD_DEBUG\`."$'\n'"--quiet - Flag. Optional. Be quiet (turns verbose off)."$'\n'"--check - Flag. Optional. Check if the fingerprint is up to date and output the current value."$'\n'"--key - String. Optional. Update this key in the JSON file."$'\n'""
base="fingerprint.sh"
build_debug="fingerprint - By default be verbose even if the flag is not specified. (Use \`--quiet\` to silence if needed)"$'\n'""
description="Update file from \`APPLICATION_JSON\` with application fingerprint."$'\n'""$'\n'""
environment="BUILD_DEBUG"$'\n'""
file="bin/build/tools/fingerprint.sh"
fn="fingerprint"
foundNames=([0]="argument" [1]="build_debug" [2]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/fingerprint.sh"
sourceModified="1768695708"
summary="Update file from \`APPLICATION_JSON\` with application fingerprint."
usage="fingerprint [ --help ] [ --handler handler ] [ --verbose ] [ --quiet ] [ --check ] [ --key ]"
