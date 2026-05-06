#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"url - URL. Required. URL to fetch the Content-Length."$'\n'""
base="web.sh"
depends="curl"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Get the size of a remote URL"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/web.sh"
fn="urlContentLength"
fnMarker="urlcontentlength"
foundNames=([0]="depends" [1]="argument")
line="60"
rawComment="Get the size of a remote URL"$'\n'"Depends: curl"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: url - URL. Required. URL to fetch the Content-Length."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/web.sh"
sourceHash="e13b8cb53898482442171ddd6250196c36d71146"
sourceLine="60"
summary="Get the size of a remote URL"
summaryComputed="true"
usage="urlContentLength [ --help ] [ --handler handler ] url"
