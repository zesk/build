#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"url ... - String. URL. Required. A Uniform Resource Locator"$'\n'""
base="url.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Checks if a URL is syntactically valid - solely a text check."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/url.sh"
fn="urlValid"
fnMarker="urlvalid"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
line="234"
rawComment="Summary: Is a URL valid?"$'\n'"Checks if a URL is syntactically valid - solely a text check."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: url ... - String. URL. Required. A Uniform Resource Locator"$'\n'"Return Code: 0 - all URLs passed in are valid"$'\n'"Return Code: 1 - at least one URL passed in is not a valid URL"$'\n'""$'\n'""
return_code="0 - all URLs passed in are valid"$'\n'"1 - at least one URL passed in is not a valid URL"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceHash="8a95c52ce8bb5cc766609fdc6a03daab47743e41"
sourceLine="234"
summary="Is a URL valid?"
summaryComputed=""
usage="urlValid [ --help ] url ..."
