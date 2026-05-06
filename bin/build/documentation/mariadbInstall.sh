#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="mariadb.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Install \`mariadb\`"$'\n'""$'\n'"When this tool succeeds the \`mariadb\` binary is available in the local operating system."$'\n'""$'\n'""
descriptionLineCount="4"
file="bin/build/tools/mariadb.sh"
fn="mariadbInstall"
fnMarker="mariadbinstall"
foundNames=([0]="return_code")
line="16"
rawComment="Install \`mariadb\`"$'\n'"When this tool succeeds the \`mariadb\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""$'\n'""
return_code="1 - If installation fails"$'\n'"0 - If installation succeeds"$'\n'""
sourceFile="bin/build/tools/mariadb.sh"
sourceHash="77ef44334f6016a24a355c7b6272d8996ef706d2"
sourceLine="16"
summary="Install \`mariadb\`"
summaryComputed="true"
usage="mariadbInstall"
