#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="item - String. Optional. Thing to classify"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="file.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Better type handling of shell objects"$'\n'""$'\n'"Outputs one of \`type\` output or enhancements:"$'\n'"- \`builtin\`, \`function\`, \`alias\`, \`file\`"$'\n'"- \`link-directory\`, \`link-file\`, \`link-dead\`, \`directory\`, \`integer\`, \`unknown\`"$'\n'""$'\n'""
descriptionLineCount="6"
file="bin/build/tools/file.sh"
fn="fileType"
fnMarker="filetype"
foundNames=([0]="argument")
line="403"
rawComment="Argument: item - String. Optional. Thing to classify"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Better type handling of shell objects"$'\n'"Outputs one of \`type\` output or enhancements:"$'\n'"- \`builtin\`, \`function\`, \`alias\`, \`file\`"$'\n'"- \`link-directory\`, \`link-file\`, \`link-dead\`, \`directory\`, \`integer\`, \`unknown\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceHash="73b29d210ecf88a33b1e7505591e6705abf5b5c9"
sourceLine="403"
summary="Better type handling of shell objects"
summaryComputed="true"
usage="fileType [ item ] [ --help ]"
