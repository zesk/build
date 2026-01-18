#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/url.sh"
argument="component - the url component to get: \`url\`, \`path\`, \`name\`, \`scheme\`, \`user\`, \`password\`, \`host\`, \`port\`, \`portDefault\`, \`error\`"$'\n'"url ... - String. URL. Required. A Uniform Resource Locator used to specify a database connection"$'\n'""
base="url.sh"
description="Extract a component from one or more URLs"$'\n'""
example="    decorate info \"Connecting as \$(urlParseItem user \"\$url\")\""$'\n'""
file="bin/build/tools/url.sh"
fn="urlParseItem"
foundNames=([0]="summary" [1]="argument" [2]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/url.sh"
sourceModified="1768721470"
summary="Get a URL component directly"$'\n'""
usage="urlParseItem [ component ] url ..."
