#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="none"
base="git.sh"
description="Given a tag in the form \"1.1.3\" convert it to \"v1.1.3\" so it has a character prefix \"v\""$'\n'"Delete the old tag as well"$'\n'""$'\n'""
file="bin/build/tools/git.sh"
fn="veeGitTag"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1769063211"
summary="Given a tag in the form \"1.1.3\" convert it to"
usage="veeGitTag"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mveeGitTag[0m

Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"
Delete the old tag as well

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: veeGitTag

Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"
Delete the old tag as well

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
