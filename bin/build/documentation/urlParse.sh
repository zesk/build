#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"url - String. Required. a Uniform Resource Locator"$'\n'"--prefix prefix - String. Optional. Prefix variable names with this string."$'\n'"--stringUppercase - Flag. Optional. Output variable names in uppercase, not stringLowercase (the default)."$'\n'""
base="url.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Simple URL parsing. Converts a \`url\` into values which can be parsed or evaluated."$'\n'""$'\n'"Generates output which can be evaluated and separates the URL into components."$'\n'""$'\n'"- \`url\` - URL"$'\n'"- \`host\` - Host"$'\n'"- \`user\` - User"$'\n'"- \`password\` - Password"$'\n'"- \`port\` - Connection port"$'\n'"- \`name\` - Path with the first slash removed"$'\n'"- \`path\` - Path"$'\n'""$'\n'"Does little to no validation of any characters so best used for well-formed input."$'\n'""$'\n'"Now works on multiple URLs, output is separated by a blank line for new entries"$'\n'""$'\n'""
descriptionLineCount="16"
example="    eval \"\$(urlParse scheme://user:password@host:port/path)\""$'\n'"    echo \$name"$'\n'""
file="bin/build/tools/url.sh"
fn="urlParse"
fnMarker="urlparse"
foundNames=([0]="return_code" [1]="summary" [2]="argument" [3]="example")
line="92"
rawComment="Simple URL parsing. Converts a \`url\` into values which can be parsed or evaluated."$'\n'"Generates output which can be evaluated and separates the URL into components."$'\n'"- \`url\` - URL"$'\n'"- \`host\` - Host"$'\n'"- \`user\` - User"$'\n'"- \`password\` - Password"$'\n'"- \`port\` - Connection port"$'\n'"- \`name\` - Path with the first slash removed"$'\n'"- \`path\` - Path"$'\n'"Does little to no validation of any characters so best used for well-formed input."$'\n'"Now works on multiple URLs, output is separated by a blank line for new entries"$'\n'"Return Code: 0 - If parsing succeeds"$'\n'"Return Code: 1 - If parsing fails"$'\n'"Summary: Simple URL Parsing"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: url - String. Required. a Uniform Resource Locator"$'\n'"Argument: --prefix prefix - String. Optional. Prefix variable names with this string."$'\n'"Argument: --stringUppercase - Flag. Optional. Output variable names in uppercase, not stringLowercase (the default)."$'\n'"Example:     eval \"\$(urlParse scheme://user:password@host:port/path)\""$'\n'"Example:     echo \$name"$'\n'""$'\n'""
return_code="0 - If parsing succeeds"$'\n'"1 - If parsing fails"$'\n'""
sourceFile="bin/build/tools/url.sh"
sourceHash="8a95c52ce8bb5cc766609fdc6a03daab47743e41"
sourceLine="92"
summary="Simple URL Parsing"
summaryComputed=""
usage="urlParse [ --help ] url [ --prefix prefix ] [ --stringUppercase ]"
