#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/version.sh"
argument="--non-interactive - Flag. Optional. If new version is needed, use default version"$'\n'"versionName - Optional. Set the new version name to this - must be after live version in version order"$'\n'""
base="version.sh"
description="Return Code: 0 - Release generated or has already been generated"$'\n'"Return Code: 1 - If new version needs to be created and \`--non-interactive\`"$'\n'"**New release** - generates files in system for a new release."$'\n'""$'\n'"*Requires* hook \`version-current\`, optionally \`version-live\`"$'\n'""$'\n'"Uses semantic versioning \`MAJOR.MINOR.PATCH\`"$'\n'""$'\n'"Checks the live version versus the version in code and prompts to"$'\n'"generate a new release file if needed."$'\n'""$'\n'"A release notes template file is added at \`./documentation/source/release/\`. This file is"$'\n'"also added to \`git\` the first time."$'\n'""$'\n'""
file="bin/build/tools/version.sh"
fn="releaseNew"
foundNames=([0]="argument" [1]="summary" [2]="hook")
hook="version-current"$'\n'"version-live"$'\n'"version-created"$'\n'"version-already"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/version.sh"
sourceModified="1768759818"
summary="Generate a new release notes and bump the version"$'\n'""
usage="releaseNew [ --non-interactive ] [ versionName ]"
