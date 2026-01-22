#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--underscore - Flag. Optional. Include environment variables which begin with underscore \`_\`."$'\n'"--skip-prefix prefixString - String. Optional. Skip environment variables which begin with this exact prefix (case-sensitive)."$'\n'"--secure - Flag. Optional. Include environment variables which are in \`environmentSecureVariables\`"$'\n'"variable ... - String. Optional. Output these variables explicitly."$'\n'""
base="environment.sh"
description="Output all exported environment variables, hiding secure ones and ones prefixed with underscore."$'\n'"Any values which contain a newline are also skipped."$'\n'""$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentOutput"
foundNames=""
requires="throwArgument decorate environmentSecureVariables grepSafe env removeFields"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="environmentSecureVariables"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769061401"
summary="Output all exported environment variables, hiding secure ones and ones"
usage="environmentOutput [ --underscore ] [ --skip-prefix prefixString ] [ --secure ] [ variable ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentOutput[0m [94m[ --underscore ][0m [94m[ --skip-prefix prefixString ][0m [94m[ --secure ][0m [94m[ variable ... ][0m

    [94m--underscore                [1;97mFlag. Optional. Include environment variables which begin with underscore [38;2;0;255;0;48;2;0;0;0m_[0m.[0m
    [94m--skip-prefix prefixString  [1;97mString. Optional. Skip environment variables which begin with this exact prefix (case-sensitive).[0m
    [94m--secure                    [1;97mFlag. Optional. Include environment variables which are in [38;2;0;255;0;48;2;0;0;0menvironmentSecureVariables[0m[0m
    [94mvariable ...                [1;97mString. Optional. Output these variables explicitly.[0m

Output all exported environment variables, hiding secure ones and ones prefixed with underscore.
Any values which contain a newline are also skipped.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentOutput [ --underscore ] [ --skip-prefix prefixString ] [ --secure ] [ variable ... ]

    --underscore                Flag. Optional. Include environment variables which begin with underscore _.
    --skip-prefix prefixString  String. Optional. Skip environment variables which begin with this exact prefix (case-sensitive).
    --secure                    Flag. Optional. Include environment variables which are in environmentSecureVariables
    variable ...                String. Optional. Output these variables explicitly.

Output all exported environment variables, hiding secure ones and ones prefixed with underscore.
Any values which contain a newline are also skipped.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
