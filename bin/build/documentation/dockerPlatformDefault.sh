#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="docker.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Fetch the default platform for docker"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/docker.sh"
fn="dockerPlatformDefault"
fnMarker="dockerplatformdefault"
foundNames=([0]="outputs_one_of")
line="22"
outputs_one_of="\`linux/arm64\`, \`linux/mips64\`, \`linux/amd64\`"$'\n'""
rawComment="Fetch the default platform for docker"$'\n'"Outputs one of: \`linux/arm64\`, \`linux/mips64\`, \`linux/amd64\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceHash="7ff1d9ef9d41486d9537ae6db40de4176c5794ab"
sourceLine="22"
summary="Fetch the default platform for docker"
summaryComputed="true"
usage="dockerPlatformDefault"
