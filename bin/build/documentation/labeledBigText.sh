#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="--top - Flag. Optional. Place label at the top."$'\n'"--bottom - Flag. Optional. Place label at the bottom."$'\n'"--prefix prefixText - String. Optional. Optional prefix on each line."$'\n'"--tween tweenText - String. Optional. Optional between text after label and before \`bigText\` on each line (allows coloring or other decorations)."$'\n'"--suffix suffixText - String. Optional. Optional suffix on each line."$'\n'"label - String. Required. Label to place on the left of big text."$'\n'"text - String. Required. Text for \`bigText\`."$'\n'""
base="decoration.sh"
description="Outputs a label before a bigText for output."$'\n'""$'\n'"This function will strip any ANSI from the label to calculate correct string sizes."$'\n'""$'\n'""
example="    > bin/build/tools.sh labeledBigText --top \"Neat: \" Done"$'\n'"    Neat: ▛▀▖"$'\n'"          ▌ ▌▞▀▖▛▀▖▞▀▖"$'\n'"          ▌ ▌▌ ▌▌ ▌▛▀"$'\n'"          ▀▀ ▝▀ ▘ ▘▝▀▘"$'\n'"    > bin/build/tools.sh labeledBigText --bottom \"Neat: \" Done"$'\n'"          ▛▀▖"$'\n'"          ▌ ▌▞▀▖▛▀▖▞▀▖"$'\n'"          ▌ ▌▌ ▌▌ ▌▛▀"$'\n'"    Neat: ▀▀ ▝▀ ▘ ▘▝▀▘"$'\n'""
file="bin/build/tools/decoration.sh"
fn="labeledBigText"
foundNames=([0]="argument" [1]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/decoration.sh"
sourceModified="1768721469"
summary="Outputs a label before a bigText for output."
usage="labeledBigText [ --top ] [ --bottom ] [ --prefix prefixText ] [ --tween tweenText ] [ --suffix suffixText ] label text"
