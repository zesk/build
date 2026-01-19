#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/php-composer.sh"
argument="--version - String. Use this version instead of current version."$'\n'"--home - Directory. Optional. Use this directory for the location of \`composer.json\`."$'\n'"--status - Flag. Optional. When set, returns 0 when te version was updated successfully and \$(returnCode identical) when the files are the same"$'\n'"--quiet - Flag. Optional. Do not output anything to stdout and just do the action and exit."$'\n'""
base="php-composer.sh"
description="For any project, ensures the \`version\` field in \`composer.json\` matches \`runHook version-current\`"$'\n'""$'\n'"Run as a commit hook for any PHP project or as part of your build or development process"$'\n'""$'\n'"Typically the version is copied in without the leading \`v\`."$'\n'""$'\n'"Return Code: 0 - File was updated successfully."$'\n'"Return Code: 1 - Environment error"$'\n'"Return Code: 2 - Argument error"$'\n'"Return Code: 105 - Identical files (only when --status is passed)"$'\n'""
file="bin/build/tools/php-composer.sh"
fn="phpComposerSetVersion"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/php-composer.sh"
summary="For any project, ensures the \`version\` field in \`composer.json\` matches"
usage="phpComposerSetVersion [ --version ] [ --home ] [ --status ] [ --quiet ]"
