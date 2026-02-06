#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-06
# shellcheck disable=SC2034
argument="goAlias - String. Alias for \`applicationHome --go\`. Default is \`g\`."$'\n'"setAlias - String. Alias for \`applicationHome\`. Default is \`G\`."$'\n'""
base="application.sh"
description="Set aliases \`G\` and \`g\` default for \`applicationHome\`"$'\n'"Localize as you wish for your own shell"$'\n'""
file="bin/build/tools/application.sh"
foundNames=([0]="argument")
rawComment="Set aliases \`G\` and \`g\` default for \`applicationHome\`"$'\n'"Localize as you wish for your own shell"$'\n'"Argument: goAlias - String. Alias for \`applicationHome --go\`. Default is \`g\`."$'\n'"Argument: setAlias - String. Alias for \`applicationHome\`. Default is \`G\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/application.sh"
sourceHash="54b4eb9e0d145543e5bd274e1ecdbeb246547778"
summary="Set aliases \`G\` and \`g\` default for \`applicationHome\`"
summaryComputed="true"
usage="applicationHomeAliases [ goAlias ] [ setAlias ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mapplicationHomeAliases'$'\e''[0m '$'\e''[[(blue)]m[ goAlias ]'$'\e''[0m '$'\e''[[(blue)]m[ setAlias ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mgoAlias   '$'\e''[[(value)]mString. Alias for '$'\e''[[(code)]mapplicationHome --go'$'\e''[[(reset)]m. Default is '$'\e''[[(code)]mg'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]msetAlias  '$'\e''[[(value)]mString. Alias for '$'\e''[[(code)]mapplicationHome'$'\e''[[(reset)]m. Default is '$'\e''[[(code)]mG'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n'''$'\n''Set aliases '$'\e''[[(code)]mG'$'\e''[[(reset)]m and '$'\e''[[(code)]mg'$'\e''[[(reset)]m default for '$'\e''[[(code)]mapplicationHome'$'\e''[[(reset)]m'$'\n''Localize as you wish for your own shell'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: applicationHomeAliases [ goAlias ] [ setAlias ]'$'\n'''$'\n''    goAlias   String. Alias for applicationHome --go. Default is g.'$'\n''    setAlias  String. Alias for applicationHome. Default is G.'$'\n'''$'\n''Set aliases G and g default for applicationHome'$'\n''Localize as you wish for your own shell'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
