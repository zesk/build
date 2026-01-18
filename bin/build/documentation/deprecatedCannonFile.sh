#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
# v0.25.0
# v0.24.0
applicationFile="bin/build/tools/deprecated-tools.sh"
argument="findArgumentFunction - Function. Required. Find arguments (for \`find\`) for cannon."$'\n'"cannonFile - File. Required. One or more files delimited with \`|\` characters, one per line \`search|replace|findArguments|...\`. If not files are supplied then pipe file via stdin."$'\n'""
base="deprecated-tools.sh"
description="Run cannon using a configuration file or files."$'\n'"Comment lines (First character is \`#\`) are considered the current \"state\" (e.g. version) and are displayed during processing."$'\n'""$'\n'"Sample file:"$'\n'""$'\n'"    # v0.25.0"$'\n'"    timingStart|timingStart"$'\n'"    timingReport|timingReport"$'\n'"    bashUserInput|bashUserInput"$'\n'""$'\n'"    # v0.24.0"$'\n'"    listJoin|listJoin"$'\n'"    mapTokens|mapTokens"$'\n'""$'\n'"Return Code: 0 - No changes were made in any files."$'\n'"Return Code: 1 - changes were made in at least one file."$'\n'""
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedCannonFile"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/deprecated-tools.sh"
sourceModified="1768721469"
summary="Run cannon using a configuration file or files."
usage="deprecatedCannonFile findArgumentFunction cannonFile"
