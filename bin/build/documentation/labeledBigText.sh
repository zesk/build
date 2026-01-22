#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="--top - Flag. Optional. Place label at the top."$'\n'"--bottom - Flag. Optional. Place label at the bottom."$'\n'"--prefix prefixText - String. Optional. Optional prefix on each line."$'\n'"--tween tweenText - String. Optional. Optional between text after label and before \`bigText\` on each line (allows coloring or other decorations)."$'\n'"--suffix suffixText - String. Optional. Optional suffix on each line."$'\n'"label - String. Required. Label to place on the left of big text."$'\n'"text - String. Required. Text for \`bigText\`."$'\n'""
base="decoration.sh"
description="Outputs a label before a bigText for output."$'\n'""$'\n'"This function will strip any ANSI from the label to calculate correct string sizes."$'\n'""$'\n'""
example="    > bin/build/tools.sh labeledBigText --top \"Neat: \" Done"$'\n'"    Neat: ▛▀▖"$'\n'"          ▌ ▌▞▀▖▛▀▖▞▀▖"$'\n'"          ▌ ▌▌ ▌▌ ▌▛▀"$'\n'"          ▀▀ ▝▀ ▘ ▘▝▀▘"$'\n'"    > bin/build/tools.sh labeledBigText --bottom \"Neat: \" Done"$'\n'"          ▛▀▖"$'\n'"          ▌ ▌▞▀▖▛▀▖▞▀▖"$'\n'"          ▌ ▌▌ ▌▌ ▌▛▀"$'\n'"    Neat: ▀▀ ▝▀ ▘ ▘▝▀▘"$'\n'""
file="bin/build/tools/decoration.sh"
fn="labeledBigText"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decoration.sh"
sourceModified="1768721469"
summary="Outputs a label before a bigText for output."
usage="labeledBigText [ --top ] [ --bottom ] [ --prefix prefixText ] [ --tween tweenText ] [ --suffix suffixText ] label text"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mlabeledBigText[0m [94m[ --top ][0m [94m[ --bottom ][0m [94m[ --prefix prefixText ][0m [94m[ --tween tweenText ][0m [94m[ --suffix suffixText ][0m [38;2;255;255;0m[35;48;2;0;0;0mlabel[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mtext[0m[0m

    [94m--top                [1;97mFlag. Optional. Place label at the top.[0m
    [94m--bottom             [1;97mFlag. Optional. Place label at the bottom.[0m
    [94m--prefix prefixText  [1;97mString. Optional. Optional prefix on each line.[0m
    [94m--tween tweenText    [1;97mString. Optional. Optional between text after label and before [38;2;0;255;0;48;2;0;0;0mbigText[0m on each line (allows coloring or other decorations).[0m
    [94m--suffix suffixText  [1;97mString. Optional. Optional suffix on each line.[0m
    [31mlabel                [1;97mString. Required. Label to place on the left of big text.[0m
    [31mtext                 [1;97mString. Required. Text for [38;2;0;255;0;48;2;0;0;0mbigText[0m.[0m

Outputs a label before a bigText for output.

This function will strip any ANSI from the label to calculate correct string sizes.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    > bin/build/tools.sh labeledBigText --top "Neat: " Done
    Neat: ▛▀▖
          ▌ ▌▞▀▖▛▀▖▞▀▖
          ▌ ▌▌ ▌▌ ▌▛▀
          ▀▀ ▝▀ ▘ ▘▝▀▘
    > bin/build/tools.sh labeledBigText --bottom "Neat: " Done
          ▛▀▖
          ▌ ▌▞▀▖▛▀▖▞▀▖
          ▌ ▌▌ ▌▌ ▌▛▀
    Neat: ▀▀ ▝▀ ▘ ▘▝▀▘
'
# shellcheck disable=SC2016
helpPlain='Usage: labeledBigText [ --top ] [ --bottom ] [ --prefix prefixText ] [ --tween tweenText ] [ --suffix suffixText ] label text

    --top                Flag. Optional. Place label at the top.
    --bottom             Flag. Optional. Place label at the bottom.
    --prefix prefixText  String. Optional. Optional prefix on each line.
    --tween tweenText    String. Optional. Optional between text after label and before bigText on each line (allows coloring or other decorations).
    --suffix suffixText  String. Optional. Optional suffix on each line.
    label                String. Required. Label to place on the left of big text.
    text                 String. Required. Text for bigText.

Outputs a label before a bigText for output.

This function will strip any ANSI from the label to calculate correct string sizes.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    > bin/build/tools.sh labeledBigText --top "Neat: " Done
    Neat: ▛▀▖
          ▌ ▌▞▀▖▛▀▖▞▀▖
          ▌ ▌▌ ▌▌ ▌▛▀
          ▀▀ ▝▀ ▘ ▘▝▀▘
    > bin/build/tools.sh labeledBigText --bottom "Neat: " Done
          ▛▀▖
          ▌ ▌▞▀▖▛▀▖▞▀▖
          ▌ ▌▌ ▌▌ ▌▛▀
    Neat: ▀▀ ▝▀ ▘ ▘▝▀▘
'
