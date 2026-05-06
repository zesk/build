#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="daemontools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Install daemontools and dependencies"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/daemontools.sh"
fn="daemontoolsInstall"
fnMarker="daemontoolsinstall"
foundNames=([0]="platform")
line="12"
platform="\`docker\` containers will not install \`daemontools-run\` as it kills the container"$'\n'""
rawComment="Install daemontools and dependencies"$'\n'"Platform: \`docker\` containers will not install \`daemontools-run\` as it kills the container"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="f448dbffaa1f7e767bd20c8f8728f0f9e0597de0"
sourceLine="12"
summary="Install daemontools and dependencies"
summaryComputed="true"
usage="daemontoolsInstall"
