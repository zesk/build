#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="nameValue ... - Optional. String. A list of name value pairs (unquoted) to output as XML \`property\` tags."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
assertions=""
base="junit.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Open tag for \`testsuite\`"$'\n'""$'\n'"Attributes:"$'\n'"- \`name=Tests.Registration\`"$'\n'"- \`tests=8\`"$'\n'"- \`failures=1\`"$'\n'"- \`errors=1\`"$'\n'"- \`skipped=1\`"$'\n'"- \`assertions=20\`"$'\n'"- \`time=16.082687\`"$'\n'"- \`timestamp=2021-04-02T15:48:23\`"$'\n'"- \`file=tests/registration.code\`"$'\n'""$'\n'""
descriptionLineCount="13"
example="    <testsuite name=\"Tests.Registration\" tests=\"8\" failures=\"1\" errors=\"1\" skipped=\"1\""$'\n'"         assertions=\"20\" time=\"16.082687\" timestamp=\"2021-04-02T15:48:23\""$'\n'"         file=\"tests/registration.code\">"$'\n'""
file="bin/build/tools/junit.sh"
fn="junitSuiteOpen"
fnMarker="junitsuiteopen"
foundNames=([0]="example" [1]="argument")
line="70"
rawComment="Open tag for \`testsuite\`"$'\n'"Example:     <testsuite name=\"Tests.Registration\" tests=\"8\" failures=\"1\" errors=\"1\" skipped=\"1\""$'\n'"Example:          assertions=\"20\" time=\"16.082687\" timestamp=\"2021-04-02T15:48:23\""$'\n'"Example:          file=\"tests/registration.code\">"$'\n'"Attributes:"$'\n'"- \`name=Tests.Registration\`"$'\n'"- \`tests=8\`"$'\n'"- \`failures=1\`"$'\n'"- \`errors=1\`"$'\n'"- \`skipped=1\`"$'\n'"- \`assertions=20\`"$'\n'"- \`time=16.082687\`"$'\n'"- \`timestamp=2021-04-02T15:48:23\`"$'\n'"- \`file=tests/registration.code\`"$'\n'"Argument: nameValue ... - Optional. String. A list of name value pairs (unquoted) to output as XML \`property\` tags."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/junit.sh"
sourceHash="b434c2cb872c8920849edb82446bed7ed134f6d2"
sourceLine="70"
summary="Open tag for \`testsuite\`"
summaryComputed="true"
usage="junitSuiteOpen [ nameValue ... ] [ --help ]"
