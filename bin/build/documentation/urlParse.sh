#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/url.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"url - a Uniform Resource Locator"$'\n'"--prefix prefix - String. Optional. Prefix variable names with this string."$'\n'"--uppercase - Flag. Optional. Output variable names in uppercase, not lowercase (the default)."$'\n'""
base="url.sh"
description="Simple URL parsing. Converts a \`url\` into values which can be parsed or evaluated:"$'\n'""$'\n'"- \`url\` - URL"$'\n'"- \`host\` - Host"$'\n'"- \`user\` - User"$'\n'"- \`password\` - Password"$'\n'"- \`port\` - Connection port"$'\n'"- \`name\` - Path with the first slash removed"$'\n'"- \`path\` - Path"$'\n'""$'\n'"Does little to no validation of any characters so best used for well-formed input."$'\n'""$'\n'"Now works on multiple URLs, output is separated by a blank line for new entries"$'\n'""$'\n'"Return Code: 0 - If parsing succeeds"$'\n'"Return Code: 1 - If parsing fails"$'\n'""
example="    eval \"\$(urlParse scheme://user:password@host:port/path)\""$'\n'"    echo \$name"$'\n'""
file="bin/build/tools/url.sh"
fn="urlParse"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceModified="1768721470"
summary="Simple URL Parsing"$'\n'""
usage="urlParse [ --help ] [ url ] [ --prefix prefix ] [ --uppercase ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255murlParse[0m [94m[ --help ][0m [94m[ url ][0m [94m[ --prefix prefix ][0m [94m[ --uppercase ][0m

    [94m--help           [1;97mFlag. Optional. Display this help.[0m
    [94murl              [1;97ma Uniform Resource Locator[0m
    [94m--prefix prefix  [1;97mString. Optional. Prefix variable names with this string.[0m
    [94m--uppercase      [1;97mFlag. Optional. Output variable names in uppercase, not lowercase (the default).[0m

Simple URL parsing. Converts a [38;2;0;255;0;48;2;0;0;0murl[0m into values which can be parsed or evaluated:

- [38;2;0;255;0;48;2;0;0;0murl[0m - URL
- [38;2;0;255;0;48;2;0;0;0mhost[0m - Host
- [38;2;0;255;0;48;2;0;0;0muser[0m - User
- [38;2;0;255;0;48;2;0;0;0mpassword[0m - Password
- [38;2;0;255;0;48;2;0;0;0mport[0m - Connection port
- [38;2;0;255;0;48;2;0;0;0mname[0m - Path with the first slash removed
- [38;2;0;255;0;48;2;0;0;0mpath[0m - Path

Does little to no validation of any characters so best used for well-formed input.

Now works on multiple URLs, output is separated by a blank line for new entries

Return Code: 0 - If parsing succeeds
Return Code: 1 - If parsing fails

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    eval "$(urlParse scheme://user:password@host:port/path)"
    echo $name
'
# shellcheck disable=SC2016
helpPlain='Usage: urlParse [ --help ] [ url ] [ --prefix prefix ] [ --uppercase ]

    --help           Flag. Optional. Display this help.
    url              a Uniform Resource Locator
    --prefix prefix  String. Optional. Prefix variable names with this string.
    --uppercase      Flag. Optional. Output variable names in uppercase, not lowercase (the default).

Simple URL parsing. Converts a url into values which can be parsed or evaluated:

- url - URL
- host - Host
- user - User
- password - Password
- port - Connection port
- name - Path with the first slash removed
- path - Path

Does little to no validation of any characters so best used for well-formed input.

Now works on multiple URLs, output is separated by a blank line for new entries

Return Code: 0 - If parsing succeeds
Return Code: 1 - If parsing fails

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    eval "$(urlParse scheme://user:password@host:port/path)"
    echo $name
'
