#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/web.sh"
argument="--help - Flag. Optional.Display this help."$'\n'"--handler handler - Function. Optional.Use this error handler instead of the default error handler."$'\n'"url - URL. Required. URL to fetch the Content-Length."$'\n'""
base="web.sh"
depends="curl"$'\n'""
description="Get the size of a remote URL"$'\n'""
file="bin/build/tools/web.sh"
fn="urlContentLength"
foundNames=([0]="depends" [1]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/web.sh"
sourceModified="1768695708"
summary="Get the size of a remote URL"
usage="urlContentLength [ --help ] [ --handler handler ] url"
