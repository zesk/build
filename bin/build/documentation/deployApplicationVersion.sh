#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deploy.sh"
argument="applicationHome - Directory. Required. Application home to get the version from."$'\n'""
base="deploy.sh"
description="Extracts version from an application either from \`.deploy\` files or from the the \`.env\` if"$'\n'"that does not exist."$'\n'""$'\n'"Checks \`APPLICATION_ID\` and \`APPLICATION_TAG\` and uses first non-blank value."$'\n'""$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployApplicationVersion"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceModified="1768721469"
summary="Extracts version from an application either from \`.deploy\` files or"
usage="deployApplicationVersion applicationHome"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeployApplicationVersion[0m [38;2;255;255;0m[35;48;2;0;0;0mapplicationHome[0m[0m

    [31mapplicationHome  [1;97mDirectory. Required. Application home to get the version from.[0m

Extracts version from an application either from [38;2;0;255;0;48;2;0;0;0m.deploy[0m files or from the the [38;2;0;255;0;48;2;0;0;0m.env[0m if
that does not exist.

Checks [38;2;0;255;0;48;2;0;0;0mAPPLICATION_ID[0m and [38;2;0;255;0;48;2;0;0;0mAPPLICATION_TAG[0m and uses first non-blank value.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: deployApplicationVersion applicationHome

    applicationHome  Directory. Required. Application home to get the version from.

Extracts version from an application either from .deploy files or from the the .env if
that does not exist.

Checks APPLICATION_ID and APPLICATION_TAG and uses first non-blank value.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
