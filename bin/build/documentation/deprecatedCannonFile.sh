#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deprecated-tools.sh"
argument="findArgumentFunction - Function. Required. Find arguments (for \`find\`) for cannon."$'\n'"cannonFile - File. Required. One or more files delimited with \`|\` characters, one per line \`search|replace|findArguments|...\`. If not files are supplied then pipe file via stdin."$'\n'""
base="deprecated-tools.sh"
description="Run cannon using a configuration file or files."$'\n'"Comment lines (First character is \`#\`) are considered the current \"state\" (e.g. version) and are displayed during processing."$'\n'""$'\n'"Sample file:"$'\n'""$'\n'"    # v0.25.0"$'\n'"    timingStart|timingStart"$'\n'"    timingReport|timingReport"$'\n'"    bashUserInput|bashUserInput"$'\n'""$'\n'"    # v0.24.0"$'\n'"    listJoin|listJoin"$'\n'"    mapTokens|mapTokens"$'\n'""$'\n'"Return Code: 0 - No changes were made in any files."$'\n'"Return Code: 1 - changes were made in at least one file."$'\n'""
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedCannonFile"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceModified="1769063211"
summary="Run cannon using a configuration file or files."
usage="deprecatedCannonFile findArgumentFunction cannonFile"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeprecatedCannonFile[0m [38;2;255;255;0m[35;48;2;0;0;0mfindArgumentFunction[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mcannonFile[0m[0m

    [31mfindArgumentFunction  [1;97mFunction. Required. Find arguments (for [38;2;0;255;0;48;2;0;0;0mfind[0m) for cannon.[0m
    [31mcannonFile            [1;97mFile. Required. One or more files delimited with [38;2;0;255;0;48;2;0;0;0m|[0m characters, one per line [38;2;0;255;0;48;2;0;0;0msearch|replace|findArguments|...[0m. If not files are supplied then pipe file via stdin.[0m

Run cannon using a configuration file or files.
Comment lines (First character is [38;2;0;255;0;48;2;0;0;0m#[0m) are considered the current "state" (e.g. version) and are displayed during processing.

Sample file:

    # v0.25.0
    timingStart|timingStart
    timingReport|timingReport
    bashUserInput|bashUserInput

    # v0.24.0
    listJoin|listJoin
    mapTokens|mapTokens

Return Code: 0 - No changes were made in any files.
Return Code: 1 - changes were made in at least one file.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: deprecatedCannonFile findArgumentFunction cannonFile

    findArgumentFunction  Function. Required. Find arguments (for find) for cannon.
    cannonFile            File. Required. One or more files delimited with | characters, one per line search|replace|findArguments|.... If not files are supplied then pipe file via stdin.

Run cannon using a configuration file or files.
Comment lines (First character is #) are considered the current "state" (e.g. version) and are displayed during processing.

Sample file:

    # v0.25.0
    timingStart|timingStart
    timingReport|timingReport
    bashUserInput|bashUserInput

    # v0.24.0
    listJoin|listJoin
    mapTokens|mapTokens

Return Code: 0 - No changes were made in any files.
Return Code: 1 - changes were made in at least one file.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
