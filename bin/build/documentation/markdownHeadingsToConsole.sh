#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\n--default defaultStyle - String. Optional. Use this style on non-heading lines.\n--headings headingStyleList - ColonDelimitedList. Optional. Styles represent each heading depth with the first being `h1`, `h2, etc.\n'
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Convert Markdown Heading lines to console"
descriptionLineCount=""
file="bin/build/tools/colors.sh"
fn="markdownHeadingsToConsole"
fnMarker="markdownheadingstoconsole"
foundNames=([0]="argument" [1]="summary")
line="490"
original="markdownHeadingsToConsole"
rawComment=$'Argument: --help - Flag. Optional. Display this help.\nSummary: Convert Markdown Heading lines to console\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\nArgument: --default defaultStyle - String. Optional. Use this style on non-heading lines.\nArgument: --headings headingStyleList - ColonDelimitedList. Optional. Styles represent each heading depth with the first being `h1`, `h2, etc.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="480be5db852b12675144ab1e6476bc78bcb875fa"
sourceLine="490"
summary="Convert Markdown Heading lines to console"
summaryComputed=""
usage="markdownHeadingsToConsole [ --help ] [ --handler handler ] [ --default defaultStyle ] [ --headings headingStyleList ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmarkdownHeadingsToConsole'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m '$'\e''[[(blue)]m[ --default defaultStyle ]'$'\e''[0m '$'\e''[[(blue)]m[ --headings headingStyleList ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help                       '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler            '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--default defaultStyle       '$'\e''[[(value)]mString. Optional. Use this style on non-heading lines.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--headings headingStyleList  '$'\e''[[(value)]mColonDelimitedList. Optional. Styles represent each heading depth with the first being '$'\e''[[(code)]mh1'$'\e''[[(reset)]m, '$'\e''[[(code)]mh2, etc.'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''Convert Markdown Heading lines to console'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: markdownHeadingsToConsole [ --help ] [ --handler handler ] [ --default defaultStyle ] [ --headings headingStyleList ]'$'\n'''$'\n''    --help                       Flag. Optional. Display this help.'$'\n''    --handler handler            Function. Optional. Use this error handler instead of the default error handler.'$'\n''    --default defaultStyle       String. Optional. Use this style on non-heading lines.'$'\n''    --headings headingStyleList  ColonDelimitedList. Optional. Styles represent each heading depth with the first being h1, h2, etc.'$'\n'''$'\n''Convert Markdown Heading lines to console'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/markdown.md"
