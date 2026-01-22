#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/documentation.sh"
argument="handler - Function. Required."$'\n'"function - String. Required."$'\n'"sourceFile - File. Required."$'\n'"--generate - Flag. Optional. Generate cached files."$'\n'"--no-cache - Flag. Optional. Skip any attempt to cache anything."$'\n'"--cache - Flag. Optional. Force use of cache."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
build_debug="usage-cache-skip - Skip caching by default (override with \`--cache\`)"$'\n'""
description="Extract documentation variables from a comment stripped of the '# ' prefixes."$'\n'""$'\n'"A few special values are generated/computed:"$'\n'""$'\n'"- \`description\` - Any line in the comment which is not in variable is appended to the field \`description\`"$'\n'"- \`fn\` - The function name (no parenthesis or anything)"$'\n'"- \`base\` - The basename of the file"$'\n'"- \`file\` - The relative path name of the file from the application root"$'\n'"- \`summary\` - Defaults to first ten words of \`description\`"$'\n'"- \`exit_code\` - Defaults to \`0 - Always succeeds\`"$'\n'"- \`reviewed\`  - Defaults to \`Never\`"$'\n'"- \`environment\"  - Defaults to \`No environment dependencies or modifications.\`"$'\n'""$'\n'"Otherwise the assumed variables (in addition to above) to define functions are:"$'\n'""$'\n'"- \`argument\` - Individual arguments"$'\n'"- \`usage\` - Canonical usage example (code)"$'\n'"- \`example\` - An example of usage (code, many)"$'\n'"- \`depends\` - Any dependencies (list)"$'\n'""$'\n'""
file="bin/build/tools/documentation.sh"
fn="bashDocumentationExtract"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceModified="1769058814"
stdin="Pipe stripped comments to extract information"$'\n'""
summary="Generate a set of name/value pairs to document bash functions"$'\n'""
usage="bashDocumentationExtract handler function sourceFile [ --generate ] [ --no-cache ] [ --cache ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashDocumentationExtract[0m [38;2;255;255;0m[35;48;2;0;0;0mhandler[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mfunction[0m[0m [38;2;255;255;0m[35;48;2;0;0;0msourceFile[0m[0m [94m[ --generate ][0m [94m[ --no-cache ][0m [94m[ --cache ][0m [94m[ --help ][0m

    [31mhandler     [1;97mFunction. Required.[0m
    [31mfunction    [1;97mString. Required.[0m
    [31msourceFile  [1;97mFile. Required.[0m
    [94m--generate  [1;97mFlag. Optional. Generate cached files.[0m
    [94m--no-cache  [1;97mFlag. Optional. Skip any attempt to cache anything.[0m
    [94m--cache     [1;97mFlag. Optional. Force use of cache.[0m
    [94m--help      [1;97mFlag. Optional. Display this help.[0m

Extract documentation variables from a comment stripped of the '\''# '\'' prefixes.

A few special values are generated/computed:

- [38;2;0;255;0;48;2;0;0;0mdescription[0m - Any line in the comment which is not in variable is appended to the field [38;2;0;255;0;48;2;0;0;0mdescription[0m
- [38;2;0;255;0;48;2;0;0;0mfn[0m - The function name (no parenthesis or anything)
- [38;2;0;255;0;48;2;0;0;0mbase[0m - The basename of the file
- [38;2;0;255;0;48;2;0;0;0mfile[0m - The relative path name of the file from the application root
- [38;2;0;255;0;48;2;0;0;0msummary[0m - Defaults to first ten words of [38;2;0;255;0;48;2;0;0;0mdescription[0m
- [38;2;0;255;0;48;2;0;0;0mexit_code[0m - Defaults to [38;2;0;255;0;48;2;0;0;0m0 - Always succeeds[0m
- [38;2;0;255;0;48;2;0;0;0mreviewed[0m  - Defaults to [38;2;0;255;0;48;2;0;0;0mNever[0m
- [38;2;0;255;0;48;2;0;0;0menvironment"  - Defaults to [0mNo environment dependencies or modifications.[38;2;0;255;0;48;2;0;0;0m[0m

Otherwise the assumed variables (in addition to above) to define functions are:

- [38;2;0;255;0;48;2;0;0;0margument[0m - Individual arguments
- [38;2;0;255;0;48;2;0;0;0musage[0m - Canonical usage example (code)
- [38;2;0;255;0;48;2;0;0;0mexample[0m - An example of usage (code, many)
- [38;2;0;255;0;48;2;0;0;0mdepends[0m - Any dependencies (list)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
Pipe stripped comments to extract information

[38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m settings:
- usage-cache-skip - Skip caching by default (override with [38;2;0;255;0;48;2;0;0;0m--cache[0m)
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashDocumentationExtract handler function sourceFile [ --generate ] [ --no-cache ] [ --cache ] [ --help ]

    handler     Function. Required.
    function    String. Required.
    sourceFile  File. Required.
    --generate  Flag. Optional. Generate cached files.
    --no-cache  Flag. Optional. Skip any attempt to cache anything.
    --cache     Flag. Optional. Force use of cache.
    --help      Flag. Optional. Display this help.

Extract documentation variables from a comment stripped of the '\''# '\'' prefixes.

A few special values are generated/computed:

- description - Any line in the comment which is not in variable is appended to the field description
- fn - The function name (no parenthesis or anything)
- base - The basename of the file
- file - The relative path name of the file from the application root
- summary - Defaults to first ten words of description
- exit_code - Defaults to 0 - Always succeeds
- reviewed  - Defaults to Never
- environment"  - Defaults to No environment dependencies or modifications.

Otherwise the assumed variables (in addition to above) to define functions are:

- argument - Individual arguments
- usage - Canonical usage example (code)
- example - An example of usage (code, many)
- depends - Any dependencies (list)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
Pipe stripped comments to extract information

BUILD_DEBUG settings:
- usage-cache-skip - Skip caching by default (override with --cache)
- 
'
