#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="deprecated-tools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output a list of tokens for \`find\` to ignore in deprecated calls"$'\n'"Skips dot directories and release notes by default and any file named \`deprecated.sh\` \`deprecated.txt\` or \`deprecated.md\`."$'\n'""$'\n'""
descriptionLineCount="3"
environment="BUILD_RELEASE_NOTES"$'\n'""
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedIgnore"
fnMarker="deprecatedignore"
foundNames=([0]="environment")
line="56"
rawComment="Output a list of tokens for \`find\` to ignore in deprecated calls"$'\n'"Skips dot directories and release notes by default and any file named \`deprecated.sh\` \`deprecated.txt\` or \`deprecated.md\`."$'\n'"Environment: BUILD_RELEASE_NOTES"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceHash="1121098df87cee32b55dc85263f73f68977219d8"
sourceLine="56"
summary="Output a list of tokens for \`find\` to ignore in"
summaryComputed="true"
usage="deprecatedIgnore"
