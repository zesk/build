#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="host.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Get the full hostname on the current platform."$'\n'"Formerly \`hostname\`\`Full\`."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/host.sh"
fn="networkNameFull"
fnMarker="networknamefull"
foundNames=([0]="summary" [1]="requires")
line="12"
rawComment="Summary: Platform-agnostic host name"$'\n'"Get the full hostname on the current platform."$'\n'"Formerly \`hostname\`\`Full\`."$'\n'"Requires: helpArgument __hostname executableRequire catchEnvironment"$'\n'""$'\n'""
requires="helpArgument __hostname executableRequire catchEnvironment"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/host.sh"
sourceHash="55e0d52d59741be253eaa9e27281e65fb946ab3b"
sourceLine="12"
summary="Platform-agnostic host name"
summaryComputed=""
usage="networkNameFull"
