#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--suffix versionSuffix - String. Optional. word to use between version and index as: \`{current}rc{nextIndex}\`"$'\n'""
base="git.sh"
description="Generates a git tag for a build version, so \`v1.0d1\`, \`v1.0d2\`, for version \`v1.0\`."$'\n'"Tag a version of the software in git and push tags to origin."$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the git repository contains a tag with the suffix and an index which represents the build index."$'\n'""$'\n'"Default is: \`--suffix rc\` **release candidate**"$'\n'""$'\n'"- \`d\` - for **development**"$'\n'"- \`s\` - for **staging**"$'\n'"- \`rc\` - for **release candidate**"$'\n'""$'\n'""
environment="BUILD_VERSION_SUFFIX - String. Version suffix to use as a default. If not specified the default is \`rc\`."$'\n'"BUILD_MAXIMUM_TAGS_PER_VERSION - Integer. Number of integers to attempt to look for when incrementing."$'\n'""
file="bin/build/tools/git.sh"
fn="gitTagVersion"
foundNames=""
hook="version-current"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Generates a git tag for a build version, so \`v1.0d1\`,"
usage="gitTagVersion [ --suffix versionSuffix ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitTagVersion[0m [94m[ --suffix versionSuffix ][0m

    [94m--suffix versionSuffix  [1;97mString. Optional. word to use between version and index as: [38;2;0;255;0;48;2;0;0;0m{current}rc{nextIndex}[0m[0m

Generates a git tag for a build version, so [38;2;0;255;0;48;2;0;0;0mv1.0d1[0m, [38;2;0;255;0;48;2;0;0;0mv1.0d2[0m, for version [38;2;0;255;0;48;2;0;0;0mv1.0[0m.
Tag a version of the software in git and push tags to origin.
If this fails it will output the installation log.
When this tool succeeds the git repository contains a tag with the suffix and an index which represents the build index.

Default is: [38;2;0;255;0;48;2;0;0;0m--suffix rc[0m [31mrelease candidate[0m

- [38;2;0;255;0;48;2;0;0;0md[0m - for [31mdevelopment[0m
- [38;2;0;255;0;48;2;0;0;0ms[0m - for [31mstaging[0m
- [38;2;0;255;0;48;2;0;0;0mrc[0m - for [31mrelease candidate[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_VERSION_SUFFIX - String. Version suffix to use as a default. If not specified the default is [38;2;0;255;0;48;2;0;0;0mrc[0m.
- BUILD_MAXIMUM_TAGS_PER_VERSION - Integer. Number of integers to attempt to look for when incrementing.
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitTagVersion [ --suffix versionSuffix ]

    --suffix versionSuffix  String. Optional. word to use between version and index as: {current}rc{nextIndex}

Generates a git tag for a build version, so v1.0d1, v1.0d2, for version v1.0.
Tag a version of the software in git and push tags to origin.
If this fails it will output the installation log.
When this tool succeeds the git repository contains a tag with the suffix and an index which represents the build index.

Default is: --suffix rc release candidate

- d - for development
- s - for staging
- rc - for release candidate

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_VERSION_SUFFIX - String. Version suffix to use as a default. If not specified the default is rc.
- BUILD_MAXIMUM_TAGS_PER_VERSION - Integer. Number of integers to attempt to look for when incrementing.
- 
'
