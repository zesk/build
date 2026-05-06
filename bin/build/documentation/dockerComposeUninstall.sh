#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="docker-compose.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Uninstalls \`docker-compose\`"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/docker-compose.sh"
fn="dockerComposeUninstall"
fnMarker="dockercomposeuninstall"
foundNames=([0]="stderr" [1]="summary" [2]="return_code")
line="62"
rawComment="Uninstalls \`docker-compose\`"$'\n'"stderr: Upon failure error log is output"$'\n'"Summary: Uninstall \`docker-compose\`"$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""$'\n'""
return_code="1 - If installation fails"$'\n'"0 - If installation succeeds"$'\n'""
sourceFile="bin/build/tools/docker-compose.sh"
sourceHash="fd46ba45b4bfb981e0a17b3510aa593d2fe8dec6"
sourceLine="62"
stderr="Upon failure error log is output"$'\n'""
summary="Uninstall \`docker-compose\`"
summaryComputed=""
usage="dockerComposeUninstall"
