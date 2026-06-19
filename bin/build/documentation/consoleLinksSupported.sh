#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument="none"
base="console.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Are console links (likely) supported?\nUnfortunately there\'s no way to test for this feature currently\n\n'
descriptionLineCount="3"
file="bin/build/tools/console.sh"
fn="consoleLinksSupported"
fnMarker="consolelinkssupported"
foundNames=()
line="204"
rawComment=$'Are console links (likely) supported?\nUnfortunately there\'s no way to test for this feature currently\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/console.sh"
sourceHash="0e80c2ac41033836c3905696efb51ddeab9575b8"
sourceLine="204"
summary="Are console links (likely) supported?"
summaryComputed="true"
usage="consoleLinksSupported"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mconsoleLinksSupported'$'\e''[0m'$'\n'''$'\n''Are console links (likely) supported?'$'\n''Unfortunately there'\''s no way to test for this feature currently'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: consoleLinksSupported'$'\n'''$'\n''Are console links (likely) supported?'$'\n''Unfortunately there'\''s no way to test for this feature currently'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/console.md"
