#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument=$'--non-interactive - Flag. Optional. If new version is needed, use default version\nversionName - Optional. Set the new version name to this - must be after live version in version order\n'
base="version.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'**New release** - generates files in system for a new release.\n\n*Requires* hook `version-current`, optionally `version-live`\n\nUses semantic versioning `MAJOR.MINOR.PATCH`\n\nChecks the live version versus the version in code and prompts to\ngenerate a new release file if needed.\n\nA release notes template file is added at `./documentation/source/release/`. This file is\nalso added to `git` the first time.\n\n'
descriptionLineCount="12"
file="bin/build/tools/version.sh"
fn="releaseNew"
fnMarker="releasenew"
foundNames=([0]="argument" [1]="summary" [2]="hook" [3]="return_code")
hook=$'version-current\nversion-live\nversion-created\nversion-already\n'
line="255"
rawComment=$'Argument: --non-interactive - Flag. Optional. If new version is needed, use default version\nArgument: versionName - Optional. Set the new version name to this - must be after live version in version order\nSummary: Generate a new release notes and bump the version\nHook: version-current\nHook: version-live\nHook: version-created\nHook: version-already\nReturn Code: 0 - Release generated or has already been generated\nReturn Code: 1 - If new version needs to be created and `--non-interactive`\n**New release** - generates files in system for a new release.\n*Requires* hook `version-current`, optionally `version-live`\nUses semantic versioning `MAJOR.MINOR.PATCH`\nChecks the live version versus the version in code and prompts to\ngenerate a new release file if needed.\nA release notes template file is added at `./documentation/source/release/`. This file is\nalso added to `git` the first time.\n\n'
return_code=$'0 - Release generated or has already been generated\n1 - If new version needs to be created and `--non-interactive`\n'
sourceFile="bin/build/tools/version.sh"
sourceHash="cb6d9642368b7b2c276fb293b83d8e5124812afb"
sourceLine="255"
summary="Generate a new release notes and bump the version"
summaryComputed=""
usage="releaseNew [ --non-interactive ] [ versionName ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mreleaseNew'$'\e''[0m '$'\e''[[(blue)]m[ --non-interactive ]'$'\e''[0m '$'\e''[[(blue)]m[ versionName ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--non-interactive  '$'\e''[[(value)]mFlag. Optional. If new version is needed, use default version'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mversionName        '$'\e''[[(value)]mOptional. Set the new version name to this - must be after live version in version order'$'\e''[[(reset)]m'$'\n'''$'\n'''$'\e''[[(red)]mNew release'$'\e''[[(reset)]m - generates files in system for a new release.'$'\n'''$'\n'''$'\e''[[(cyan)]mRequires'$'\e''[[(reset)]m hook '$'\e''[[(code)]mversion-current'$'\e''[[(reset)]m, optionally '$'\e''[[(code)]mversion-live'$'\e''[[(reset)]m'$'\n'''$'\n''Uses semantic versioning '$'\e''[[(code)]mMAJOR.MINOR.PATCH'$'\e''[[(reset)]m'$'\n'''$'\n''Checks the live version versus the version in code and prompts to'$'\n''generate a new release file if needed.'$'\n'''$'\n''A release notes template file is added at '$'\e''[[(code)]m./documentation/source/release/'$'\e''[[(reset)]m. This file is'$'\n''also added to '$'\e''[[(code)]mgit'$'\e''[[(reset)]m the first time.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Release generated or has already been generated'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If new version needs to be created and '$'\e''[[(code)]m--non-interactive'$'\e''[[(reset)]m'
# shellcheck disable=SC2016
helpPlain='Usage: releaseNew [ --non-interactive ] [ versionName ]'$'\n'''$'\n''    --non-interactive  Flag. Optional. If new version is needed, use default version'$'\n''    versionName        Optional. Set the new version name to this - must be after live version in version order'$'\n'''$'\n''New release - generates files in system for a new release.'$'\n'''$'\n''Requires hook version-current, optionally version-live'$'\n'''$'\n''Uses semantic versioning MAJOR.MINOR.PATCH'$'\n'''$'\n''Checks the live version versus the version in code and prompts to'$'\n''generate a new release file if needed.'$'\n'''$'\n''A release notes template file is added at ./documentation/source/release/. This file is'$'\n''also added to git the first time.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Release generated or has already been generated'$'\n''- 1 - If new version needs to be created and --non-interactive'
documentationPath="documentation/source/tools/version.md"
