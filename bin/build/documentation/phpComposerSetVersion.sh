#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--version - String. Use this version instead of current version."$'\n'"--home - Directory. Optional. Use this directory for the location of \`composer.json\`."$'\n'"--status - Flag. Optional. When set, returns 0 when te version was updated successfully and \$(returnCode identical) when the files are the same"$'\n'"--quiet - Flag. Optional. Do not output anything to stdout and just do the action and exit."$'\n'""
base="php-composer.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="For any project, ensures the \`version\` field in \`composer.json\` matches \`hookRun version-current\`"$'\n'""$'\n'"Run as a commit hook for any PHP project or as part of your build or development process"$'\n'""$'\n'"Typically the version is copied in without the leading \`v\`."$'\n'""$'\n'""
descriptionLineCount="6"
file="bin/build/tools/php-composer.sh"
fn="phpComposerSetVersion"
fnMarker="phpcomposersetversion"
foundNames=([0]="argument" [1]="return_code")
line="134"
rawComment="For any project, ensures the \`version\` field in \`composer.json\` matches \`hookRun version-current\`"$'\n'"Run as a commit hook for any PHP project or as part of your build or development process"$'\n'"Typically the version is copied in without the leading \`v\`."$'\n'"Argument: --version - String. Use this version instead of current version."$'\n'"Argument: --home - Directory. Optional. Use this directory for the location of \`composer.json\`."$'\n'"Argument: --status - Flag. Optional. When set, returns 0 when te version was updated successfully and \$(returnCode identical) when the files are the same"$'\n'"Argument: --quiet - Flag. Optional. Do not output anything to stdout and just do the action and exit."$'\n'"Return Code: 0 - File was updated successfully."$'\n'"Return Code: 1 - Environment error"$'\n'"Return Code: 2 - Argument error"$'\n'"Return Code: 105 - Identical files (only when --status is passed)"$'\n'""$'\n'""
return_code="0 - File was updated successfully."$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'"105 - Identical files (only when --status is passed)"$'\n'""
sourceFile="bin/build/tools/php-composer.sh"
sourceHash="191b88f64f9eb22d42937cc44d2ed155c9750033"
sourceLine="134"
summary="For any project, ensures the \`version\` field in \`composer.json\` matches"
summaryComputed="true"
usage="phpComposerSetVersion [ --version ] [ --home ] [ --status ] [ --quiet ]"
