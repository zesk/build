#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--suffix versionSuffix - String. Optional. word to use between version and index as: \`{current}rc{nextIndex}\`"$'\n'""
base="git.sh"
default_is="\`--suffix rc\` **release candidate**"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Generates a git tag for a build version, so \`v1.0d1\`, \`v1.0d2\`, for version \`v1.0\`."$'\n'"Tag a version of the software in git and push tags to origin."$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the git repository contains a tag with the suffix and an index which represents the build index."$'\n'""$'\n'"- \`d\` - for **development**"$'\n'"- \`s\` - for **staging**"$'\n'"- \`rc\` - for **release candidate**"$'\n'""$'\n'""
descriptionLineCount="9"
environment="BUILD_VERSION_SUFFIX - String. Version suffix to use as a default. If not specified the default is \`rc\`."$'\n'"BUILD_MAXIMUM_TAGS_PER_VERSION - Integer. Number of integers to attempt to look for when incrementing."$'\n'""
file="bin/build/tools/git.sh"
fn="gitTagVersion"
fnMarker="gittagversion"
foundNames=([0]="default_is" [1]="argument" [2]="hook" [3]="environment")
hook="version-current"$'\n'""
line="336"
rawComment="Generates a git tag for a build version, so \`v1.0d1\`, \`v1.0d2\`, for version \`v1.0\`."$'\n'"Tag a version of the software in git and push tags to origin."$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the git repository contains a tag with the suffix and an index which represents the build index."$'\n'"Default is: \`--suffix rc\` **release candidate**"$'\n'"- \`d\` - for **development**"$'\n'"- \`s\` - for **staging**"$'\n'"- \`rc\` - for **release candidate**"$'\n'"Argument: --suffix versionSuffix - String. Optional. word to use between version and index as: \`{current}rc{nextIndex}\`"$'\n'"Hook: version-current"$'\n'"Environment: BUILD_VERSION_SUFFIX - String. Version suffix to use as a default. If not specified the default is \`rc\`."$'\n'"Environment: BUILD_MAXIMUM_TAGS_PER_VERSION - Integer. Number of integers to attempt to look for when incrementing."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="336"
summary="Generates a git tag for a build version, so \`v1.0d1\`,"
summaryComputed="true"
usage="gitTagVersion [ --suffix versionSuffix ]"
