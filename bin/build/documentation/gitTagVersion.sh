#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--suffix versionSuffix - String. Optional. word to use between version and index as: \`{current}rc{nextIndex}\`"$'\n'""
base="git.sh"
description="Generates a git tag for a build version, so \`v1.0d1\`, \`v1.0d2\`, for version \`v1.0\`."$'\n'"Tag a version of the software in git and push tags to origin."$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the git repository contains a tag with the suffix and an index which represents the build index."$'\n'""$'\n'"Default is: \`--suffix rc\` **release candidate**"$'\n'""$'\n'"- \`d\` - for **development**"$'\n'"- \`s\` - for **staging**"$'\n'"- \`rc\` - for **release candidate**"$'\n'""$'\n'""
environment="BUILD_VERSION_SUFFIX - String. Version suffix to use as a default. If not specified the default is \`rc\`."$'\n'"BUILD_MAXIMUM_TAGS_PER_VERSION - Integer. Number of integers to attempt to look for when incrementing."$'\n'""
file="bin/build/tools/git.sh"
fn="gitTagVersion"
foundNames=([0]="argument" [1]="hook" [2]="environment")
hook="version-current"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/git.sh"
sourceModified="1768721470"
summary="Generates a git tag for a build version, so \`v1.0d1\`,"
usage="gitTagVersion [ --suffix versionSuffix ]"
