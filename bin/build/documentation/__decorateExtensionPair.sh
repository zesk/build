#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument="characterWidth - UnsignedInteger. Optional. Number of characters to format the value for spacing. Uses environment variable BUILD_PAIR_WIDTH if not set."$'\n'"name - String. Required. Name to output"$'\n'"value ... - String. Optional. One or more Values to output as values for \`name\` (single line)"$'\n'""
base="pair.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="The name is output left-aligned to the \`characterWidth\` given and colored using \`decorate label\`; the value colored using \`decorate value\`."$'\n'""$'\n'""
descriptionLineCount="2"
environment="BUILD_PAIR_WIDTH"$'\n'""
file="bin/build/tools/decorate/pair.sh"
fn="decorate pair"
fnMarker="__decorateextensionpair"
foundNames=([0]="fn" [1]="summary" [2]="argument" [3]="environment")
line="16"
original="__decorateExtensionPair"
rawComment="fn: decorate pair"$'\n'"Summary: Output a name value pair (decorate extension)"$'\n'"The name is output left-aligned to the \`characterWidth\` given and colored using \`decorate label\`; the value colored using \`decorate value\`."$'\n'"Argument: characterWidth - UnsignedInteger. Optional. Number of characters to format the value for spacing. Uses environment variable BUILD_PAIR_WIDTH if not set."$'\n'"Argument: name - String. Required. Name to output"$'\n'"Argument: value ... - String. Optional. One or more Values to output as values for \`name\` (single line)"$'\n'"Environment: BUILD_PAIR_WIDTH"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate/pair.sh"
sourceHash="a3ef08c1fe370f1225de39c284ed7d6980755261"
sourceLine="16"
summary="Output a name value pair (decorate extension)"
summaryComputed=""
usage="decorate pair [ characterWidth ] name [ value ... ]"
documentationPath=""
