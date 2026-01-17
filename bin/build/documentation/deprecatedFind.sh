#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deprecated-tools.sh"
argument="findArgumentFunction - Function. Required. Find arguments (for \`find\`) for cannon."$'\n'"search - String. Required. String to search for (one or more)"$'\n'"--path cannonPath -  Directory. Optional.Run cannon operation starting in this directory."$'\n'""
base="deprecated-tools.sh"
description="Find files which match a token or tokens"$'\n'"Return Code: 0 - One of the search tokens was found in a file (which matches find arguments)"$'\n'"Return Code: 1 - Search tokens were not found in any file (which matches find arguments)"$'\n'""
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedFind"
foundNames=([0]="argument" [1]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="buildHome"$'\n'""
source="bin/build/tools/deprecated-tools.sh"
sourceModified="1768683751"
summary="Find files which match a token or tokens"
usage="deprecatedFind findArgumentFunction search [ --path cannonPath ]"
