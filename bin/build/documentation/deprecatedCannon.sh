#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deprecated-tools.sh"
argument="--path cannonPath - Directory. Optional. Run cannon operation starting in this directory."$'\n'"findArgumentFunction - Function. Required. Find arguments (for \`find\`) for cannon."$'\n'"search - String. Required. String to search for"$'\n'"replace - EmptyString. Required. Replacement string."$'\n'"extraCannonArguments - Arguments. Optional. Any additional arguments are passed to \`cannon\`."$'\n'""
base="deprecated-tools.sh"
description="No documentation for \`deprecatedCannon\`."$'\n'""
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedCannon"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceModified="1769063211"
summary="undocumented"
usage="deprecatedCannon [ --path cannonPath ] findArgumentFunction search replace [ extraCannonArguments ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeprecatedCannon[0m [94m[ --path cannonPath ][0m [38;2;255;255;0m[35;48;2;0;0;0mfindArgumentFunction[0m[0m [38;2;255;255;0m[35;48;2;0;0;0msearch[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mreplace[0m[0m [94m[ extraCannonArguments ][0m

    [94m--path cannonPath     [1;97mDirectory. Optional. Run cannon operation starting in this directory.[0m
    [31mfindArgumentFunction  [1;97mFunction. Required. Find arguments (for [38;2;0;255;0;48;2;0;0;0mfind[0m) for cannon.[0m
    [31msearch                [1;97mString. Required. String to search for[0m
    [31mreplace               [1;97mEmptyString. Required. Replacement string.[0m
    [94mextraCannonArguments  [1;97mArguments. Optional. Any additional arguments are passed to [38;2;0;255;0;48;2;0;0;0mcannon[0m.[0m

No documentation for [38;2;0;255;0;48;2;0;0;0mdeprecatedCannon[0m.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: deprecatedCannon [ --path cannonPath ] findArgumentFunction search replace [ extraCannonArguments ]

    --path cannonPath     Directory. Optional. Run cannon operation starting in this directory.
    findArgumentFunction  Function. Required. Find arguments (for find) for cannon.
    search                String. Required. String to search for
    replace               EmptyString. Required. Replacement string.
    extraCannonArguments  Arguments. Optional. Any additional arguments are passed to cannon.

No documentation for deprecatedCannon.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
