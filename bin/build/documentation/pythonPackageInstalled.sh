#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="pipPackage ... - String. Required. Package name(s) to check."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--any - Flag. Optional. When specified changes the behavior such that if it returns return code 0 IFF any single package is installed."$'\n'""
base="python.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is a package installed for python?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/python.sh"
fn="pythonPackageInstalled"
fnMarker="pythonpackageinstalled"
foundNames=([0]="argument" [1]="return_code")
line="252"
rawComment="Is a package installed for python?"$'\n'"Argument: pipPackage ... - String. Required. Package name(s) to check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --any - Flag. Optional. When specified changes the behavior such that if it returns return code 0 IFF any single package is installed."$'\n'"Return Code: 0 - All packages are installed (or at least one package with \`--any\`)"$'\n'"Return Code: 1 - All packages are not installed (or NO packages are installed with \`--any\`)"$'\n'""$'\n'""
return_code="0 - All packages are installed (or at least one package with \`--any\`)"$'\n'"1 - All packages are not installed (or NO packages are installed with \`--any\`)"$'\n'""
sourceFile="bin/build/tools/python.sh"
sourceHash="c5956e3d32ee75e52908b4d36d8cfde5928066e8"
sourceLine="252"
summary="Is a package installed for python?"
summaryComputed="true"
usage="pythonPackageInstalled pipPackage ... [ --help ] [ --handler handler ] [ --any ]"
