#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/url.sh"
argument="component - the url component to get: \`url\`, \`path\`, \`name\`, \`scheme\`, \`user\`, \`password\`, \`host\`, \`port\`, \`portDefault\`, \`error\`"$'\n'"url ... - String. URL. Required. A Uniform Resource Locator used to specify a database connection"$'\n'""
base="url.sh"
description="Extract a component from one or more URLs"$'\n'""
example="    decorate info \"Connecting as \$(urlParseItem user \"\$url\")\""$'\n'""
file="bin/build/tools/url.sh"
fn="urlParseItem"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceModified="1769063211"
summary="Get a URL component directly"$'\n'""
usage="urlParseItem [ component ] url ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255murlParseItem[0m [94m[ component ][0m [38;2;255;255;0m[35;48;2;0;0;0murl ...[0m[0m

    [94mcomponent  [1;97mthe url component to get: [38;2;0;255;0;48;2;0;0;0murl[0m, [38;2;0;255;0;48;2;0;0;0mpath[0m, [38;2;0;255;0;48;2;0;0;0mname[0m, [38;2;0;255;0;48;2;0;0;0mscheme[0m, [38;2;0;255;0;48;2;0;0;0muser[0m, [38;2;0;255;0;48;2;0;0;0mpassword[0m, [38;2;0;255;0;48;2;0;0;0mhost[0m, [38;2;0;255;0;48;2;0;0;0mport[0m, [38;2;0;255;0;48;2;0;0;0mportDefault[0m, [38;2;0;255;0;48;2;0;0;0merror[0m[0m
    [31murl ...    [1;97mString. URL. Required. A Uniform Resource Locator used to specify a database connection[0m

Extract a component from one or more URLs

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    decorate info "Connecting as $(urlParseItem user "$url")"
'
# shellcheck disable=SC2016
helpPlain='Usage: urlParseItem [ component ] url ...

    component  the url component to get: url, path, name, scheme, user, password, host, port, portDefault, error
    url ...    String. URL. Required. A Uniform Resource Locator used to specify a database connection

Extract a component from one or more URLs

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    decorate info "Connecting as $(urlParseItem user "$url")"
'
