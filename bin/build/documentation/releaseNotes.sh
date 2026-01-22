#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/version.sh"
argument="--application application - Directory. Optional. Application home directory."$'\n'"version - String. Optional. Version for the release notes path. If not specified uses the current version."$'\n'""
base="version.sh"
description="Output path to current release notes"$'\n'""$'\n'"If this fails it outputs an error to stderr"$'\n'""$'\n'"When this tool succeeds it outputs the path to the current release notes file"$'\n'""$'\n'"shellcheck disable=SC2120"$'\n'""
environment="BUILD_RELEASE_NOTES"$'\n'""
example="    open \$(bin/build/release-notes.sh)"$'\n'"    vim \$(releaseNotes)"$'\n'""
file="bin/build/tools/version.sh"
fn="releaseNotes"
foundNames=""
hook="version-current"$'\n'""
output="docs/release/version.md"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/version.sh"
sourceModified="1769063211"
summary="Output path to current release notes"$'\n'""
usage="releaseNotes [ --application application ] [ version ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mreleaseNotes[0m [94m[ --application application ][0m [94m[ version ][0m

    [94m--application application  [1;97mDirectory. Optional. Application home directory.[0m
    [94mversion                    [1;97mString. Optional. Version for the release notes path. If not specified uses the current version.[0m

Output path to current release notes

If this fails it outputs an error to stderr

When this tool succeeds it outputs the path to the current release notes file

shellcheck disable=SC2120

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_RELEASE_NOTES
- 

Example:
    open $(bin/build/release-notes.sh)
    vim $(releaseNotes)
'
# shellcheck disable=SC2016
helpPlain='Usage: releaseNotes [ --application application ] [ version ]

    --application application  Directory. Optional. Application home directory.
    version                    String. Optional. Version for the release notes path. If not specified uses the current version.

Output path to current release notes

If this fails it outputs an error to stderr

When this tool succeeds it outputs the path to the current release notes file

shellcheck disable=SC2120

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_RELEASE_NOTES
- 

Example:
    open $(bin/build/release-notes.sh)
    vim $(releaseNotes)
'
