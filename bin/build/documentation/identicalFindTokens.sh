#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/identical.sh"
argument="--prefix prefix - String. Required. A text prefix to search for to identify identical sections (e.g. \`# IDENTICAL\`) (may specify more than one)"$'\n'"file ... - File. Required. A file to search for identical tokens."$'\n'""
base="identical.sh"
description="No documentation for \`identicalFindTokens\`."$'\n'""
file="bin/build/tools/identical.sh"
fn="identicalFindTokens"
foundNames=([0]="argument" [1]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/identical.sh"
sourceModified="1768759368"
stdout="tokens, one per line"$'\n'""
summary="undocumented"
usage="identicalFindTokens --prefix prefix file ..."
