#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deploy.sh"
argument="applicationLinkPath - Path. Required. Path where the link is created."$'\n'"applicationPath - Path. Optional. Path where the link will point to. If not supplied uses current working directory."$'\n'""
base="deploy.sh"
description="Link new version of application."$'\n'""$'\n'"When called, current directory is the **new** application and the \`applicationLinkPath\` which is"$'\n'"passed as an argument is the place where the **new** application should be linked to"$'\n'"in order to activate it."$'\n'""$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Environment error"$'\n'"Return Code: 2 - Argument error"$'\n'""
environment="PWD"$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployLink"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceModified="1769063211"
summary="Link deployment to new version of the application"$'\n'""
usage="deployLink applicationLinkPath [ applicationPath ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeployLink[0m [38;2;255;255;0m[35;48;2;0;0;0mapplicationLinkPath[0m[0m [94m[ applicationPath ][0m

    [31mapplicationLinkPath  [1;97mPath. Required. Path where the link is created.[0m
    [94mapplicationPath      [1;97mPath. Optional. Path where the link will point to. If not supplied uses current working directory.[0m

Link new version of application.

When called, current directory is the [31mnew[0m application and the [38;2;0;255;0;48;2;0;0;0mapplicationLinkPath[0m which is
passed as an argument is the place where the [31mnew[0m application should be linked to
in order to activate it.

Return Code: 0 - Success
Return Code: 1 - Environment error
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- PWD
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: deployLink applicationLinkPath [ applicationPath ]

    applicationLinkPath  Path. Required. Path where the link is created.
    applicationPath      Path. Optional. Path where the link will point to. If not supplied uses current working directory.

Link new version of application.

When called, current directory is the new application and the applicationLinkPath which is
passed as an argument is the place where the new application should be linked to
in order to activate it.

Return Code: 0 - Success
Return Code: 1 - Environment error
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- PWD
- 
'
