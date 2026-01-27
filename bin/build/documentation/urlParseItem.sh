#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/url.sh"
argument="component - the url component to get: \`url\`, \`path\`, \`name\`, \`scheme\`, \`user\`, \`password\`, \`host\`, \`port\`, \`portDefault\`, \`error\`"$'\n'"url ... - String. URL. Required. A Uniform Resource Locator used to specify a database connection"$'\n'""
base="url.sh"
description="Extract a component from one or more URLs"$'\n'""
example="    decorate info \"Connecting as \$(urlParseItem user \"\$url\")\""$'\n'""
file="bin/build/tools/url.sh"
foundNames=([0]="summary" [1]="argument" [2]="example")
rawComment="Extract a component from one or more URLs"$'\n'"Summary: Get a URL component directly"$'\n'"Argument: component - the url component to get: \`url\`, \`path\`, \`name\`, \`scheme\`, \`user\`, \`password\`, \`host\`, \`port\`, \`portDefault\`, \`error\`"$'\n'"Argument: url ... - String. URL. Required. A Uniform Resource Locator used to specify a database connection"$'\n'"Example:     decorate info \"Connecting as \$(urlParseItem user \"\$url\")\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceModified="1769184734"
summary="Get a URL component directly"$'\n'""
usage="urlParseItem [ component ] url ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]murlParseItem'$'\e''[0m '$'\e''[[(blue)]m[ component ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]murl ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mcomponent  '$'\e''[[(value)]mthe url component to get: '$'\e''[[(code)]murl'$'\e''[[(reset)]m, '$'\e''[[(code)]mpath'$'\e''[[(reset)]m, '$'\e''[[(code)]mname'$'\e''[[(reset)]m, '$'\e''[[(code)]mscheme'$'\e''[[(reset)]m, '$'\e''[[(code)]muser'$'\e''[[(reset)]m, '$'\e''[[(code)]mpassword'$'\e''[[(reset)]m, '$'\e''[[(code)]mhost'$'\e''[[(reset)]m, '$'\e''[[(code)]mport'$'\e''[[(reset)]m, '$'\e''[[(code)]mportDefault'$'\e''[[(reset)]m, '$'\e''[[(code)]merror'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]murl ...    '$'\e''[[(value)]mString. URL. Required. A Uniform Resource Locator used to specify a database connection'$'\e''[[(reset)]m'$'\n'''$'\n''Extract a component from one or more URLs'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    decorate info "Connecting as $(urlParseItem user "$url")"'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: urlParseItem [ component ] url ...'$'\n'''$'\n''    component  the url component to get: url, path, name, scheme, user, password, host, port, portDefault, error'$'\n''    url ...    String. URL. Required. A Uniform Resource Locator used to specify a database connection'$'\n'''$'\n''Extract a component from one or more URLs'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    decorate info "Connecting as $(urlParseItem user "$url")"'$'\n'''
# elapsed 0.467
