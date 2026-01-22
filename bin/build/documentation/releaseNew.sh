#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/version.sh"
argument="--non-interactive - Flag. Optional. If new version is needed, use default version"$'\n'"versionName - Optional. Set the new version name to this - must be after live version in version order"$'\n'""
base="version.sh"
description="Return Code: 0 - Release generated or has already been generated"$'\n'"Return Code: 1 - If new version needs to be created and \`--non-interactive\`"$'\n'"**New release** - generates files in system for a new release."$'\n'""$'\n'"*Requires* hook \`version-current\`, optionally \`version-live\`"$'\n'""$'\n'"Uses semantic versioning \`MAJOR.MINOR.PATCH\`"$'\n'""$'\n'"Checks the live version versus the version in code and prompts to"$'\n'"generate a new release file if needed."$'\n'""$'\n'"A release notes template file is added at \`./documentation/source/release/\`. This file is"$'\n'"also added to \`git\` the first time."$'\n'""$'\n'""
file="bin/build/tools/version.sh"
fn="releaseNew"
hook="version-current"$'\n'"version-live"$'\n'"version-created"$'\n'"version-already"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/version.sh"
sourceModified="1768759818"
summary="Generate a new release notes and bump the version"$'\n'""
usage="releaseNew [ --non-interactive ] [ versionName ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mreleaseNew[0m [94m[ --non-interactive ][0m [94m[ versionName ][0m

    [94m--non-interactive  [1;97mFlag. Optional. If new version is needed, use default version[0m
    [94mversionName        [1;97mOptional. Set the new version name to this - must be after live version in version order[0m

Return Code: 0 - Release generated or has already been generated
Return Code: 1 - If new version needs to be created and [38;2;0;255;0;48;2;0;0;0m--non-interactive[0m
[31mNew release[0m - generates files in system for a new release.

[36mRequires[0m hook [38;2;0;255;0;48;2;0;0;0mversion-current[0m, optionally [38;2;0;255;0;48;2;0;0;0mversion-live[0m

Uses semantic versioning [38;2;0;255;0;48;2;0;0;0mMAJOR.MINOR.PATCH[0m

Checks the live version versus the version in code and prompts to
generate a new release file if needed.

A release notes template file is added at [38;2;0;255;0;48;2;0;0;0m./documentation/source/release/[0m. This file is
also added to [38;2;0;255;0;48;2;0;0;0mgit[0m the first time.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: releaseNew [ --non-interactive ] [ versionName ]

    --non-interactive  Flag. Optional. If new version is needed, use default version
    versionName        Optional. Set the new version name to this - must be after live version in version order

Return Code: 0 - Release generated or has already been generated
Return Code: 1 - If new version needs to be created and --non-interactive
New release - generates files in system for a new release.

Requires hook version-current, optionally version-live

Uses semantic versioning MAJOR.MINOR.PATCH

Checks the live version versus the version in code and prompts to
generate a new release file if needed.

A release notes template file is added at ./documentation/source/release/. This file is
also added to git the first time.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
