#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/application.sh"
argument="goAlias - String. Alias for \`applicationHome --go\`. Default is \`g\`."$'\n'"setAlias - String. Alias for \`applicationHome\`. Default is \`G\`."$'\n'""
base="application.sh"
description="Set aliases \`G\` and \`g\` default for \`applicationHome\`"$'\n'"Localize as you wish for your own shell"$'\n'""
file="bin/build/tools/application.sh"
fn="applicationHomeAliases"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/application.sh"
sourceModified="1769063211"
summary="Set aliases \`G\` and \`g\` default for \`applicationHome\`"
usage="applicationHomeAliases [ goAlias ] [ setAlias ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mapplicationHomeAliases[0m [94m[ goAlias ][0m [94m[ setAlias ][0m

    [94mgoAlias   [1;97mString. Alias for [38;2;0;255;0;48;2;0;0;0mapplicationHome --go[0m. Default is [38;2;0;255;0;48;2;0;0;0mg[0m.[0m
    [94msetAlias  [1;97mString. Alias for [38;2;0;255;0;48;2;0;0;0mapplicationHome[0m. Default is [38;2;0;255;0;48;2;0;0;0mG[0m.[0m

Set aliases [38;2;0;255;0;48;2;0;0;0mG[0m and [38;2;0;255;0;48;2;0;0;0mg[0m default for [38;2;0;255;0;48;2;0;0;0mapplicationHome[0m
Localize as you wish for your own shell

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: applicationHomeAliases [ goAlias ] [ setAlias ]

    goAlias   String. Alias for applicationHome --go. Default is g.
    setAlias  String. Alias for applicationHome. Default is G.

Set aliases G and g default for applicationHome
Localize as you wish for your own shell

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
