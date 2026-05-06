#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="goAlias - String. Alias for \`applicationHome --go\`. Default is \`g\`."$'\n'"setAlias - String. Alias for \`applicationHome\`. Default is \`G\`."$'\n'""
base="application.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Set aliases \`G\` and \`g\` (defaults) to aliases of \`applicationHome\`"$'\n'"Localize as you wish for your own shell"$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/application.sh"
fn="applicationHomeAliases"
fnMarker="applicationhomealiases"
foundNames=([0]="summary" [1]="argument")
line="95"
rawComment="Summary: \`applicationHome\` bash aliases setup"$'\n'"Set aliases \`G\` and \`g\` (defaults) to aliases of \`applicationHome\`"$'\n'"Localize as you wish for your own shell"$'\n'"Argument: goAlias - String. Alias for \`applicationHome --go\`. Default is \`g\`."$'\n'"Argument: setAlias - String. Alias for \`applicationHome\`. Default is \`G\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/application.sh"
sourceHash="562d2de8a12e4176ee14a47d79968f58574ee69d"
sourceLine="95"
summary="\`applicationHome\` bash aliases setup"
summaryComputed=""
usage="applicationHomeAliases [ goAlias ] [ setAlias ]"
