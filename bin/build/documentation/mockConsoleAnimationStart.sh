#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="true | false - Boolean. Force the value of consoleHasAnimation to this value temporarily. Saves the original value."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="test.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Fake \`consoleHasAnimation\` for testing"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/test.sh"
fn="mockConsoleAnimationStart"
fnMarker="mockconsoleanimationstart"
foundNames=([0]="argument")
line="1464"
rawComment="Fake \`consoleHasAnimation\` for testing"$'\n'"Argument: true | false - Boolean. Force the value of consoleHasAnimation to this value temporarily. Saves the original value."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceHash="78c7da5cbc1777fd8206d96854e19720ad1957a9"
sourceLine="1464"
summary="Fake \`consoleHasAnimation\` for testing"
summaryComputed="true"
usage="mockConsoleAnimationStart [ true | false ] [ --help ]"
