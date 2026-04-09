#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="--suffix versionSuffix - String. Optional. word to use between version and index as: \`{current}rc{nextIndex}\`"$'\n'""
base="git.sh"
default_is="\`--suffix rc\` **release candidate**"$'\n'""
description="Generates a git tag for a build version, so \`v1.0d1\`, \`v1.0d2\`, for version \`v1.0\`."$'\n'"Tag a version of the software in git and push tags to origin."$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the git repository contains a tag with the suffix and an index which represents the build index."$'\n'"- \`d\` - for **development**"$'\n'"- \`s\` - for **staging**"$'\n'"- \`rc\` - for **release candidate**"$'\n'""
environment="BUILD_VERSION_SUFFIX - String. Version suffix to use as a default. If not specified the default is \`rc\`."$'\n'"BUILD_MAXIMUM_TAGS_PER_VERSION - Integer. Number of integers to attempt to look for when incrementing."$'\n'""
file="bin/build/tools/git.sh"
fn="gitTagVersion"
foundNames=([0]="default_is" [1]="argument" [2]="hook" [3]="environment")
hook="version-current"$'\n'""
line="336"
lowerFn="gittagversion"
rawComment="Generates a git tag for a build version, so \`v1.0d1\`, \`v1.0d2\`, for version \`v1.0\`."$'\n'"Tag a version of the software in git and push tags to origin."$'\n'"If this fails it will output the installation log."$'\n'"When this tool succeeds the git repository contains a tag with the suffix and an index which represents the build index."$'\n'"Default is: \`--suffix rc\` **release candidate**"$'\n'"- \`d\` - for **development**"$'\n'"- \`s\` - for **staging**"$'\n'"- \`rc\` - for **release candidate**"$'\n'"Argument: --suffix versionSuffix - String. Optional. word to use between version and index as: \`{current}rc{nextIndex}\`"$'\n'"Hook: version-current"$'\n'"Environment: BUILD_VERSION_SUFFIX - String. Version suffix to use as a default. If not specified the default is \`rc\`."$'\n'"Environment: BUILD_MAXIMUM_TAGS_PER_VERSION - Integer. Number of integers to attempt to look for when incrementing."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="ef317634b04a01c8ac47c9c01567340a86b0e4b6"
sourceLine="336"
summary="Generates a git tag for a build version, so \`v1.0d1\`,"
summaryComputed="true"
usage="gitTagVersion [ --suffix versionSuffix ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitTagVersion'$'\e''[0m '$'\e''[[(blue)]m[ --suffix versionSuffix ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--suffix versionSuffix  '$'\e''[[(value)]mString. Optional. word to use between version and index as: '$'\e''[[(code)]m{current}rc{nextIndex}'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Generates a git tag for a build version, so '$'\e''[[(code)]mv1.0d1'$'\e''[[(reset)]m, '$'\e''[[(code)]mv1.0d2'$'\e''[[(reset)]m, for version '$'\e''[[(code)]mv1.0'$'\e''[[(reset)]m.'$'\n''Tag a version of the software in git and push tags to origin.'$'\n''If this fails it will output the installation log.'$'\n''When this tool succeeds the git repository contains a tag with the suffix and an index which represents the build index.'$'\n''- '$'\e''[[(code)]md'$'\e''[[(reset)]m - for '$'\e''[[(red)]mdevelopment'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]ms'$'\e''[[(reset)]m - for '$'\e''[[(red)]mstaging'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]mrc'$'\e''[[(reset)]m - for '$'\e''[[(red)]mrelease candidate'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- '$'\e''[[(code)]mBUILD_VERSION_SUFFIX'$'\e''[[(reset)]m - String. Version suffix to use as a default. If not specified the default is '$'\e''[[(code)]mrc'$'\e''[[(reset)]m.'$'\n''- '$'\e''[[(code)]mBUILD_MAXIMUM_TAGS_PER_VERSION'$'\e''[[(reset)]m - Integer. Number of integers to attempt to look for when incrementing.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitTagVersion [ --suffix versionSuffix ]'$'\n'''$'\n''    --suffix versionSuffix  String. Optional. word to use between version and index as: {current}rc{nextIndex}'$'\n'''$'\n''Generates a git tag for a build version, so v1.0d1, v1.0d2, for version v1.0.'$'\n''Tag a version of the software in git and push tags to origin.'$'\n''If this fails it will output the installation log.'$'\n''When this tool succeeds the git repository contains a tag with the suffix and an index which represents the build index.'$'\n''- d - for development'$'\n''- s - for staging'$'\n''- rc - for release candidate'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_VERSION_SUFFIX - String. Version suffix to use as a default. If not specified the default is rc.'$'\n''- BUILD_MAXIMUM_TAGS_PER_VERSION - Integer. Number of integers to attempt to look for when incrementing.'$'\n'''
documentationPath="documentation/source/tools/git.md"
