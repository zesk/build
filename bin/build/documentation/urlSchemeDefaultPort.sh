#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"scheme ... - String. Required. Scheme to look up the default port used for that scheme."$'\n'""
base="url.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output the port for the given scheme"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/url.sh"
fn="urlSchemeDefaultPort"
fnMarker="urlschemedefaultport"
foundNames=([0]="argument")
line="28"
rawComment="Output the port for the given scheme"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: scheme ... - String. Required. Scheme to look up the default port used for that scheme."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceHash="8a95c52ce8bb5cc766609fdc6a03daab47743e41"
sourceLine="28"
summary="Output the port for the given scheme"
summaryComputed="true"
usage="urlSchemeDefaultPort [ --help ] [ --handler handler ] scheme ..."
