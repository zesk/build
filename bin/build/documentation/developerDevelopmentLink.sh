#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/developer.sh"
argument="--copy - Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization."$'\n'"--reset - Flag. Optional. Revert the link and reinstall using the original binary."$'\n'"--development-path developmentPath- Directory. Optional. Path in the target development directory to link (or copy) to the path."$'\n'"--version-json jsonFile - ApplicationFile. Required. The library JSON file to check."$'\n'"--version-selector jsonFile - String. Optional. Query to extract version from JSON file (defaults to \`.version\`). API."$'\n'"--variable variableNameValue - EnvironmentVariable. Required. The environment variable which represents the local path of the library to link to. API."$'\n'"--binary - String. Optional. The binary to install the library remotely if needed to revert back. API."$'\n'"--composer composerPackage - String. Optional. The composer package to convert to a link (or copy.). API."$'\n'"--path applicationPath - ApplicationDirectory. Required. The library path to convert to a link (or copy). API."$'\n'""
base="developer.sh"
description="Link a current library with another version being developed nearby using a link"$'\n'"Does not work inside docker containers unless you explicitly do some magic with paths (maybe we will add this)"$'\n'""
file="bin/build/tools/developer.sh"
fn="developerDevelopmentLink"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="buildDevelopmentLink"$'\n'""
sourceFile="bin/build/tools/developer.sh"
sourceModified="1768588589"
summary="Link a current library with another version being developed nearby"
test="TODO"$'\n'""
usage="developerDevelopmentLink [ --copy ] [ --reset ] [ --development-path developmentPath- Directory. Optional. Path in the target development directory to link (or copy) to the path. ] --version-json jsonFile [ --version-selector jsonFile ] --variable variableNameValue [ --binary ] [ --composer composerPackage ] --path applicationPath"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeveloperDevelopmentLink[0m [94m[ --copy ][0m [94m[ --reset ][0m [94m[ --development-path developmentPath- Directory. Optional. Path in the target development directory to link (or copy) to the path. ][0m [38;2;255;255;0m[35;48;2;0;0;0m--version-json jsonFile[0m[0m [94m[ --version-selector jsonFile ][0m [38;2;255;255;0m[35;48;2;0;0;0m--variable variableNameValue[0m[0m [94m[ --binary ][0m [94m[ --composer composerPackage ][0m [38;2;255;255;0m[35;48;2;0;0;0m--path applicationPath[0m[0m

    [94m--copy                                                                                                                            [1;97mFlag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization.[0m
    [94m--reset                                                                                                                           [1;97mFlag. Optional. Revert the link and reinstall using the original binary.[0m
    [94m--development-path developmentPath- Directory. Optional. Path in the target development directory to link (or copy) to the path.  [1;97m--development-path developmentPath- Directory. Optional. Path in the target development directory to link (or copy) to the path.[0m
    [31m--version-json jsonFile                                                                                                           [1;97mApplicationFile. Required. The library JSON file to check.[0m
    [94m--version-selector jsonFile                                                                                                       [1;97mString. Optional. Query to extract version from JSON file (defaults to [38;2;0;255;0;48;2;0;0;0m.version[0m). API.[0m
    [31m--variable variableNameValue                                                                                                      [1;97mEnvironmentVariable. Required. The environment variable which represents the local path of the library to link to. API.[0m
    [94m--binary                                                                                                                          [1;97mString. Optional. The binary to install the library remotely if needed to revert back. API.[0m
    [94m--composer composerPackage                                                                                                        [1;97mString. Optional. The composer package to convert to a link (or copy.). API.[0m
    [31m--path applicationPath                                                                                                            [1;97mApplicationDirectory. Required. The library path to convert to a link (or copy). API.[0m

Link a current library with another version being developed nearby using a link
Does not work inside docker containers unless you explicitly do some magic with paths (maybe we will add this)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: developerDevelopmentLink [ --copy ] [ --reset ] [ --development-path developmentPath- Directory. Optional. Path in the target development directory to link (or copy) to the path. ] --version-json jsonFile [ --version-selector jsonFile ] --variable variableNameValue [ --binary ] [ --composer composerPackage ] --path applicationPath

    --copy                                                                                                                            Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization.
    --reset                                                                                                                           Flag. Optional. Revert the link and reinstall using the original binary.
    --development-path developmentPath- Directory. Optional. Path in the target development directory to link (or copy) to the path.  --development-path developmentPath- Directory. Optional. Path in the target development directory to link (or copy) to the path.
    --version-json jsonFile                                                                                                           ApplicationFile. Required. The library JSON file to check.
    --version-selector jsonFile                                                                                                       String. Optional. Query to extract version from JSON file (defaults to .version). API.
    --variable variableNameValue                                                                                                      EnvironmentVariable. Required. The environment variable which represents the local path of the library to link to. API.
    --binary                                                                                                                          String. Optional. The binary to install the library remotely if needed to revert back. API.
    --composer composerPackage                                                                                                        String. Optional. The composer package to convert to a link (or copy.). API.
    --path applicationPath                                                                                                            ApplicationDirectory. Required. The library path to convert to a link (or copy). API.

Link a current library with another version being developed nearby using a link
Does not work inside docker containers unless you explicitly do some magic with paths (maybe we will add this)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
