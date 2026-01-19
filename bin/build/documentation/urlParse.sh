#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/url.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"url - a Uniform Resource Locator"$'\n'"--prefix prefix - String. Optional. Prefix variable names with this string."$'\n'"--uppercase - Flag. Optional. Output variable names in uppercase, not lowercase (the default)."$'\n'""
base="url.sh"
description="Simple URL parsing. Converts a \`url\` into values which can be parsed or evaluated:"$'\n'""$'\n'"- \`url\` - URL"$'\n'"- \`host\` - Host"$'\n'"- \`user\` - User"$'\n'"- \`password\` - Password"$'\n'"- \`port\` - Connection port"$'\n'"- \`name\` - Path with the first slash removed"$'\n'"- \`path\` - Path"$'\n'""$'\n'"Does little to no validation of any characters so best used for well-formed input."$'\n'""$'\n'"Now works on multiple URLs, output is separated by a blank line for new entries"$'\n'""$'\n'"Return Code: 0 - If parsing succeeds"$'\n'"Return Code: 1 - If parsing fails"$'\n'""
example="    eval \"\$(urlParse scheme://user:password@host:port/path)\""$'\n'"    echo \$name"$'\n'""
file="bin/build/tools/url.sh"
fn="urlParse"
foundNames=([0]="summary" [1]="argument" [2]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/url.sh"
summary="Simple URL Parsing"$'\n'""
usage="urlParse [ --help ] [ url ] [ --prefix prefix ] [ --uppercase ]"
