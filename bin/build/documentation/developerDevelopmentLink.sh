#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--copy - Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization."$'\n'"--reset - Flag. Optional. Revert the link and reinstall using the original binary."$'\n'"--development-path developmentPath- Directory. Optional. Path in the target development directory to link (or copy) to the path."$'\n'"--version-json jsonFile - ApplicationFile. Required. The library JSON file to check."$'\n'"--version-selector jsonFile - String. Optional. Query to extract version from JSON file (defaults to \`.version\`). API."$'\n'"--variable variableNameValue - EnvironmentVariable. Required. The environment variable which represents the local path of the library to link to. API."$'\n'"--binary - String. Optional. The binary to install the library remotely if needed to revert back. API."$'\n'"--composer composerPackage - String. Optional. The composer package to convert to a link (or copy.). API."$'\n'"--path applicationPath - ApplicationDirectory. Required. The library path to convert to a link (or copy). API."$'\n'""
base="developer.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Link a current library with another version being developed nearby using a link"$'\n'"Does not work inside docker containers unless you explicitly do some magic with paths (maybe we will add this)"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/developer.sh"
fn="developerDevelopmentLink"
fnMarker="developerdevelopmentlink"
foundNames=([0]="argument" [1]="see" [2]="test")
line="223"
rawComment="Link a current library with another version being developed nearby using a link"$'\n'"Does not work inside docker containers unless you explicitly do some magic with paths (maybe we will add this)"$'\n'"Argument: --copy - Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization."$'\n'"Argument: --reset - Flag. Optional. Revert the link and reinstall using the original binary."$'\n'"Argument: --development-path developmentPath- Directory. Optional. Path in the target development directory to link (or copy) to the path."$'\n'"Argument: --version-json jsonFile - ApplicationFile. Required. The library JSON file to check."$'\n'"Argument: --version-selector jsonFile - String. Optional. Query to extract version from JSON file (defaults to \`.version\`). API."$'\n'"Argument: --variable variableNameValue - EnvironmentVariable. Required. The environment variable which represents the local path of the library to link to. API."$'\n'"Argument: --binary - String. Optional. The binary to install the library remotely if needed to revert back. API."$'\n'"Argument: --composer composerPackage - String. Optional. The composer package to convert to a link (or copy.). API."$'\n'"Argument: --path applicationPath - ApplicationDirectory. Required. The library path to convert to a link (or copy). API."$'\n'"See: buildDevelopmentLink"$'\n'"Test: TODO"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="buildDevelopmentLink"$'\n'""
sourceFile="bin/build/tools/developer.sh"
sourceHash="78a593214724db23edf7c0ae664f15c226343bbd"
sourceLine="223"
summary="Link a current library with another version being developed nearby"
summaryComputed="true"
test="TODO"$'\n'""
usage="developerDevelopmentLink [ --copy ] [ --reset ] [ --development-path developmentPath- Directory. Optional. Path in the target development directory to link (or copy) to the path. ] --version-json jsonFile [ --version-selector jsonFile ] --variable variableNameValue [ --binary ] [ --composer composerPackage ] --path applicationPath"
