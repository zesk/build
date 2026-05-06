#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="component - the url component to get: \`url\`, \`path\`, \`name\`, \`scheme\`, \`user\`, \`password\`, \`host\`, \`port\`, \`portDefault\`, \`error\`"$'\n'"url ... - String. URL. Required. A Uniform Resource Locator used to specify a database connection"$'\n'""
base="url.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Extract a component from one or more URLs"$'\n'""$'\n'""
descriptionLineCount="2"
example="    decorate info \"Connecting as \$(urlParseItem user \"\$url\")\""$'\n'""
file="bin/build/tools/url.sh"
fn="urlParseItem"
fnMarker="urlparseitem"
foundNames=([0]="summary" [1]="argument" [2]="example")
line="187"
rawComment="Extract a component from one or more URLs"$'\n'"Summary: Get a URL component directly"$'\n'"Argument: component - the url component to get: \`url\`, \`path\`, \`name\`, \`scheme\`, \`user\`, \`password\`, \`host\`, \`port\`, \`portDefault\`, \`error\`"$'\n'"Argument: url ... - String. URL. Required. A Uniform Resource Locator used to specify a database connection"$'\n'"Example:     decorate info \"Connecting as \$(urlParseItem user \"\$url\")\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceHash="8a95c52ce8bb5cc766609fdc6a03daab47743e41"
sourceLine="187"
summary="Get a URL component directly"
summaryComputed=""
usage="urlParseItem [ component ] url ..."
