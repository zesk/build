#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="package - Additional packages to install"$'\n'""
base="php.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Install \`php\`"$'\n'""$'\n'"If this fails it will output the installation log."$'\n'""$'\n'"When this tool succeeds the \`php\` binary is available in the local operating system."$'\n'""$'\n'""
descriptionLineCount="6"
file="bin/build/tools/php.sh"
fn="phpInstall"
fnMarker="phpinstall"
foundNames=([0]="argument" [1]="summary" [2]="return_code")
line="21"
rawComment="Install \`php\`"$'\n'"If this fails it will output the installation log."$'\n'"Argument: package - Additional packages to install"$'\n'"Summary: Install \`php\`"$'\n'"When this tool succeeds the \`php\` binary is available in the local operating system."$'\n'"Return Code: 1 - If installation fails"$'\n'"Return Code: 0 - If installation succeeds"$'\n'""$'\n'""
return_code="1 - If installation fails"$'\n'"0 - If installation succeeds"$'\n'""
sourceFile="bin/build/tools/php.sh"
sourceHash="cd2691e7c6370ed405b6513e2b412ce1541ca05b"
sourceLine="21"
summary="Install \`php\`"
summaryComputed=""
usage="phpInstall [ package ]"
