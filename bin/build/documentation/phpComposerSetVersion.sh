#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/php-composer.sh"
argument="--version - String. Use this version instead of current version."$'\n'"--home - Directory. Optional. Use this directory for the location of \`composer.json\`."$'\n'"--status - Flag. Optional. When set, returns 0 when te version was updated successfully and \$(returnCode identical) when the files are the same"$'\n'"--quiet - Flag. Optional. Do not output anything to stdout and just do the action and exit."$'\n'""
base="php-composer.sh"
description="For any project, ensures the \`version\` field in \`composer.json\` matches \`runHook version-current\`"$'\n'""$'\n'"Run as a commit hook for any PHP project or as part of your build or development process"$'\n'""$'\n'"Typically the version is copied in without the leading \`v\`."$'\n'""$'\n'"Return Code: 0 - File was updated successfully."$'\n'"Return Code: 1 - Environment error"$'\n'"Return Code: 2 - Argument error"$'\n'"Return Code: 105 - Identical files (only when --status is passed)"$'\n'""
file="bin/build/tools/php-composer.sh"
fn="phpComposerSetVersion"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/php-composer.sh"
sourceModified="1769063211"
summary="For any project, ensures the \`version\` field in \`composer.json\` matches"
usage="phpComposerSetVersion [ --version ] [ --home ] [ --status ] [ --quiet ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mphpComposerSetVersion[0m [94m[ --version ][0m [94m[ --home ][0m [94m[ --status ][0m [94m[ --quiet ][0m

    [94m--version  [1;97mString. Use this version instead of current version.[0m
    [94m--home     [1;97mDirectory. Optional. Use this directory for the location of [38;2;0;255;0;48;2;0;0;0mcomposer.json[0m.[0m
    [94m--status   [1;97mFlag. Optional. When set, returns 0 when te version was updated successfully and $(returnCode identical) when the files are the same[0m
    [94m--quiet    [1;97mFlag. Optional. Do not output anything to stdout and just do the action and exit.[0m

For any project, ensures the [38;2;0;255;0;48;2;0;0;0mversion[0m field in [38;2;0;255;0;48;2;0;0;0mcomposer.json[0m matches [38;2;0;255;0;48;2;0;0;0mrunHook version-current[0m

Run as a commit hook for any PHP project or as part of your build or development process

Typically the version is copied in without the leading [38;2;0;255;0;48;2;0;0;0mv[0m.

Return Code: 0 - File was updated successfully.
Return Code: 1 - Environment error
Return Code: 2 - Argument error
Return Code: 105 - Identical files (only when --status is passed)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: phpComposerSetVersion [ --version ] [ --home ] [ --status ] [ --quiet ]

    --version  String. Use this version instead of current version.
    --home     Directory. Optional. Use this directory for the location of composer.json.
    --status   Flag. Optional. When set, returns 0 when te version was updated successfully and $(returnCode identical) when the files are the same
    --quiet    Flag. Optional. Do not output anything to stdout and just do the action and exit.

For any project, ensures the version field in composer.json matches runHook version-current

Run as a commit hook for any PHP project or as part of your build or development process

Typically the version is copied in without the leading v.

Return Code: 0 - File was updated successfully.
Return Code: 1 - Environment error
Return Code: 2 - Argument error
Return Code: 105 - Identical files (only when --status is passed)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
