#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--top - Flag. Optional. Place label at the top."$'\n'"--bottom - Flag. Optional. Place label at the bottom."$'\n'"--prefix prefixText - String. Optional. Optional prefix on each line."$'\n'"--tween tweenText - String. Optional. Optional between text after label and before \`decorate big\` on each line (allows coloring or other decorations)."$'\n'"--suffix suffixText - String. Optional. Optional suffix on each line."$'\n'"label - String. Required. Label to place on the left of big text."$'\n'"text - String. Required. Text for \`decorate big\`."$'\n'""
base="big.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Outputs a label before a decorate big for output."$'\n'""$'\n'"This function will strip any ANSI from the label to calculate correct string sizes."$'\n'""$'\n'""
descriptionLineCount="4"
example="    > bin/build/tools.sh labeledBigText --top \"Neat: \" Done"$'\n'"    Neat: ▛▀▖"$'\n'"          ▌ ▌▞▀▖▛▀▖▞▀▖"$'\n'"          ▌ ▌▌ ▌▌ ▌▛▀"$'\n'"          ▀▀ ▝▀ ▘ ▘▝▀▘"$'\n'"    > bin/build/tools.sh labeledBigText --bottom \"Neat: \" Done"$'\n'"          ▛▀▖"$'\n'"          ▌ ▌▞▀▖▛▀▖▞▀▖"$'\n'"          ▌ ▌▌ ▌▌ ▌▛▀"$'\n'"    Neat: ▀▀ ▝▀ ▘ ▘▝▀▘"$'\n'""
file="bin/build/tools/decorate/big.sh"
fn="labeledBigText"
fnMarker="labeledbigtext"
foundNames=([0]="argument" [1]="example")
line="182"
rawComment="Argument: --top - Flag. Optional. Place label at the top."$'\n'"Argument: --bottom - Flag. Optional. Place label at the bottom."$'\n'"Argument: --prefix prefixText - String. Optional. Optional prefix on each line."$'\n'"Argument: --tween tweenText - String. Optional. Optional between text after label and before \`decorate big\` on each line (allows coloring or other decorations)."$'\n'"Argument: --suffix suffixText - String. Optional. Optional suffix on each line."$'\n'"Argument: label - String. Required. Label to place on the left of big text."$'\n'"Argument: text - String. Required. Text for \`decorate big\`."$'\n'"Outputs a label before a decorate big for output."$'\n'"This function will strip any ANSI from the label to calculate correct string sizes."$'\n'"Example:     > bin/build/tools.sh labeledBigText --top \"Neat: \" Done"$'\n'"Example:     Neat: ▛▀▖"$'\n'"Example:           ▌ ▌▞▀▖▛▀▖▞▀▖"$'\n'"Example:           ▌ ▌▌ ▌▌ ▌▛▀"$'\n'"Example:           ▀▀ ▝▀ ▘ ▘▝▀▘"$'\n'"Example:     > bin/build/tools.sh labeledBigText --bottom \"Neat: \" Done"$'\n'"Example:           ▛▀▖"$'\n'"Example:           ▌ ▌▞▀▖▛▀▖▞▀▖"$'\n'"Example:           ▌ ▌▌ ▌▌ ▌▛▀"$'\n'"Example:     Neat: ▀▀ ▝▀ ▘ ▘▝▀▘"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate/big.sh"
sourceHash="0aa3ddf3ce6b72a300a030bb9c5c2dea8bad1cfe"
sourceLine="182"
summary="Outputs a label before a decorate big for output."
summaryComputed="true"
usage="labeledBigText [ --top ] [ --bottom ] [ --prefix prefixText ] [ --tween tweenText ] [ --suffix suffixText ] label text"
