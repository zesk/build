#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="url.sh"
description="Extract a component from one or more URLs"$'\n'"Summary: Get a URL component directly"$'\n'"Argument: component - the url component to get: \`url\`, \`path\`, \`name\`, \`scheme\`, \`user\`, \`password\`, \`host\`, \`port\`, \`portDefault\`, \`error\`"$'\n'"Argument: url ... - String. URL. Required. A Uniform Resource Locator used to specify a database connection"$'\n'"Example:     decorate info \"Connecting as \$(urlParseItem user \"\$url\")\""$'\n'""
file="bin/build/tools/url.sh"
foundNames=()
rawComment="Extract a component from one or more URLs"$'\n'"Summary: Get a URL component directly"$'\n'"Argument: component - the url component to get: \`url\`, \`path\`, \`name\`, \`scheme\`, \`user\`, \`password\`, \`host\`, \`port\`, \`portDefault\`, \`error\`"$'\n'"Argument: url ... - String. URL. Required. A Uniform Resource Locator used to specify a database connection"$'\n'"Example:     decorate info \"Connecting as \$(urlParseItem user \"\$url\")\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceHash="7a4bdc5b163f1c16b416ea3bac111f15d9a5f6b1"
summary="Extract a component from one or more URLs"
usage="urlParseItem"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]murlParseItem'$'\e''[0m'$'\n'''$'\n''Extract a component from one or more URLs'$'\n''Summary: Get a URL component directly'$'\n''Argument: component - the url component to get: '$'\e''[[(code)]murl'$'\e''[[(reset)]m, '$'\e''[[(code)]mpath'$'\e''[[(reset)]m, '$'\e''[[(code)]mname'$'\e''[[(reset)]m, '$'\e''[[(code)]mscheme'$'\e''[[(reset)]m, '$'\e''[[(code)]muser'$'\e''[[(reset)]m, '$'\e''[[(code)]mpassword'$'\e''[[(reset)]m, '$'\e''[[(code)]mhost'$'\e''[[(reset)]m, '$'\e''[[(code)]mport'$'\e''[[(reset)]m, '$'\e''[[(code)]mportDefault'$'\e''[[(reset)]m, '$'\e''[[(code)]merror'$'\e''[[(reset)]m'$'\n''Argument: url ... - String. URL. Required. A Uniform Resource Locator used to specify a database connection'$'\n''Example:     decorate info "Connecting as $(urlParseItem user "$url")"'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: urlParseItem'$'\n'''$'\n''Extract a component from one or more URLs'$'\n''Summary: Get a URL component directly'$'\n''Argument: component - the url component to get: url, path, name, scheme, user, password, host, port, portDefault, error'$'\n''Argument: url ... - String. URL. Required. A Uniform Resource Locator used to specify a database connection'$'\n''Example:     decorate info "Connecting as $(urlParseItem user "$url")"'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.513
