#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--underscore - Flag. Optional. Include environment variables which begin with underscore \`_\`."$'\n'"--secure - Flag. Optional. Include environment variables which are in \`environmentSecureVariables\`"$'\n'"--keep-comments - Flag. Keep all comments in the source"$'\n'"--variables - CommaDelimitedList. Optional. Always output the value of these variables."$'\n'"--parse - Flag. Optional. Parse the file for things which look like variables to output (basically \`^foo=\`)"$'\n'"environmentFile - File. Required. Environment file to load, evaluate, and output in raw form (Bash-compatible)."$'\n'""
base="environment.sh"
description="Load an environment file and evaluate it using bash and output the changed environment variables after running"$'\n'"Do not perform this operation on files which are untrusted."$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentCompile"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
security="source"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceModified="1769061401"
summary="Load an environment file and evaluate it using bash and"
usage="environmentCompile [ --underscore ] [ --secure ] [ --keep-comments ] [ --variables ] [ --parse ] environmentFile"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255menvironmentCompile[0m [94m[ --underscore ][0m [94m[ --secure ][0m [94m[ --keep-comments ][0m [94m[ --variables ][0m [94m[ --parse ][0m [38;2;255;255;0m[35;48;2;0;0;0menvironmentFile[0m[0m

    [94m--underscore     [1;97mFlag. Optional. Include environment variables which begin with underscore [38;2;0;255;0;48;2;0;0;0m_[0m.[0m
    [94m--secure         [1;97mFlag. Optional. Include environment variables which are in [38;2;0;255;0;48;2;0;0;0menvironmentSecureVariables[0m[0m
    [94m--keep-comments  [1;97mFlag. Keep all comments in the source[0m
    [94m--variables      [1;97mCommaDelimitedList. Optional. Always output the value of these variables.[0m
    [94m--parse          [1;97mFlag. Optional. Parse the file for things which look like variables to output (basically [38;2;0;255;0;48;2;0;0;0m^foo=[0m)[0m
    [31menvironmentFile  [1;97mFile. Required. Environment file to load, evaluate, and output in raw form (Bash-compatible).[0m

Load an environment file and evaluate it using bash and output the changed environment variables after running
Do not perform this operation on files which are untrusted.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: environmentCompile [ --underscore ] [ --secure ] [ --keep-comments ] [ --variables ] [ --parse ] environmentFile

    --underscore     Flag. Optional. Include environment variables which begin with underscore _.
    --secure         Flag. Optional. Include environment variables which are in environmentSecureVariables
    --keep-comments  Flag. Keep all comments in the source
    --variables      CommaDelimitedList. Optional. Always output the value of these variables.
    --parse          Flag. Optional. Parse the file for things which look like variables to output (basically ^foo=)
    environmentFile  File. Required. Environment file to load, evaluate, and output in raw form (Bash-compatible).

Load an environment file and evaluate it using bash and output the changed environment variables after running
Do not perform this operation on files which are untrusted.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
