#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="globalName ... - EnvironmentVariable. Required. Global to restore from the mocked saved value."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="test.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Restore a mocked value. Works solely with the default \`saveGlobalName\` (e.g. \`__MOCK_\${globalName}\`)."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/test.sh"
fn="mockEnvironmentStop"
fnMarker="mockenvironmentstop"
foundNames=([0]="argument")
line="1452"
rawComment="Restore a mocked value. Works solely with the default \`saveGlobalName\` (e.g. \`__MOCK_\${globalName}\`)."$'\n'"Argument: globalName ... - EnvironmentVariable. Required. Global to restore from the mocked saved value."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="78c7da5cbc1777fd8206d96854e19720ad1957a9"
sourceLine="1452"
summary="Restore a mocked value. Works solely with the default \`saveGlobalName\`"
summaryComputed="true"
usage="mockEnvironmentStop globalName ... [ --help ]"
