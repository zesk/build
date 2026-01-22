#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="extension - String. Optional. Extension to check. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'""
base="git.sh"
description="Does this commit have the following file extensions?"$'\n'"Return code: 0 - if all extensions are present"$'\n'"Return code: 1 - if any extension is not present"$'\n'""
file="bin/build/tools/git.sh"
fn="gitPreCommitHasExtension"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1769063211"
summary="Does this commit have the following file extensions?"
usage="gitPreCommitHasExtension [ extension ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitPreCommitHasExtension[0m [94m[ extension ][0m

    [94mextension  [1;97mString. Optional. Extension to check. Use [38;2;0;255;0;48;2;0;0;0m![0m for blank extension and [38;2;0;255;0;48;2;0;0;0m@[0m for all extensions. Can specify one or more.[0m

Does this commit have the following file extensions?
Return code: 0 - if all extensions are present
Return code: 1 - if any extension is not present

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitPreCommitHasExtension [ extension ]

    extension  String. Optional. Extension to check. Use ! for blank extension and @ for all extensions. Can specify one or more.

Does this commit have the following file extensions?
Return code: 0 - if all extensions are present
Return code: 1 - if any extension is not present

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
