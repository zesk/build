#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/version.sh"
argument="--application application - Directory. Optional. Application home directory."$'\n'"version - String. Optional. Version for the release notes path. If not specified uses the current version."$'\n'""
base="version.sh"
description="Output path to current release notes"$'\n'"If this fails it outputs an error to stderr"$'\n'"When this tool succeeds it outputs the path to the current release notes file"$'\n'"shellcheck disable=SC2120"$'\n'""
environment="BUILD_RELEASE_NOTES"$'\n'""
example="    open \$(bin/build/release-notes.sh)"$'\n'"    vim \$(releaseNotes)"$'\n'""
exitCode="0"
file="bin/build/tools/version.sh"
foundNames=([0]="summary" [1]="environment" [2]="argument" [3]="output" [4]="hook" [5]="example")
hook="version-current"$'\n'""
output="docs/release/version.md"$'\n'""
rawComment="Summary: Output path to current release notes"$'\n'"Output path to current release notes"$'\n'"If this fails it outputs an error to stderr"$'\n'"When this tool succeeds it outputs the path to the current release notes file"$'\n'"Environment: BUILD_RELEASE_NOTES"$'\n'"Argument: --application application - Directory. Optional. Application home directory."$'\n'"Argument: version - String. Optional. Version for the release notes path. If not specified uses the current version."$'\n'"Output: docs/release/version.md"$'\n'"Hook: version-current"$'\n'"Example:     open \$(bin/build/release-notes.sh)"$'\n'"Example:     vim \$(releaseNotes)"$'\n'"shellcheck disable=SC2120"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769063211"
summary="Output path to current release notes"$'\n'""
usage="releaseNotes [ --application application ] [ version ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mreleaseNotes'$'\e''[0m '$'\e''[[blue]m[ --application application ]'$'\e''[0m '$'\e''[[blue]m[ version ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--application application  '$'\e''[[value]mDirectory. Optional. Application home directory.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mversion                    '$'\e''[[value]mString. Optional. Version for the release notes path. If not specified uses the current version.'$'\e''[[reset]m'$'\n'''$'\n''Output path to current release notes'$'\n''If this fails it outputs an error to stderr'$'\n''When this tool succeeds it outputs the path to the current release notes file'$'\n''shellcheck disable=SC2120'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_RELEASE_NOTES'$'\n'''$'\n''Example:'$'\n''    open $(bin/build/release-notes.sh)'$'\n''    vim $(releaseNotes)'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: releaseNotes [ --application application ] [ version ]'$'\n'''$'\n''    --application application  Directory. Optional. Application home directory.'$'\n''    version                    String. Optional. Version for the release notes path. If not specified uses the current version.'$'\n'''$'\n''Output path to current release notes'$'\n''If this fails it outputs an error to stderr'$'\n''When this tool succeeds it outputs the path to the current release notes file'$'\n''shellcheck disable=SC2120'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_RELEASE_NOTES'$'\n'''$'\n''Example:'$'\n''    open $(bin/build/release-notes.sh)'$'\n''    vim $(releaseNotes)'$'\n'''
