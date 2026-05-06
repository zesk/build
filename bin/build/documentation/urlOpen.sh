#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--ignore - Flag. Optional. Ignore any invalid URLs found."$'\n'"--wait - Flag. Optional. Display this help."$'\n'"--url url - URL. Optional. URL to download."$'\n'""
base="url.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Open a URL using the operating system"$'\n'"Usage {fn} [ --help ]"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/url.sh"
fn="urlOpen"
fnMarker="urlopen"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
line="419"
rawComment="Open a URL using the operating system"$'\n'"Usage {fn} [ --help ]"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --ignore - Flag. Optional. Ignore any invalid URLs found."$'\n'"Argument: --wait - Flag. Optional. Display this help."$'\n'"Argument: --url url - URL. Optional. URL to download."$'\n'"stdin: line:URL"$'\n'"stdout: none"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceHash="8a95c52ce8bb5cc766609fdc6a03daab47743e41"
sourceLine="419"
stdin="line:URL"$'\n'""
stdout="none"$'\n'""
summary="Open a URL using the operating system"
summaryComputed="true"
usage="urlOpen [ --help ] [ --ignore ] [ --wait ] [ --url url ]"
