#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'haystack - String. Required. String to search.\nneedle ... - String. Optional. One or more strings to find as the "start" of `haystack`.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Does needle exist as a substring of haystack?\n\n'
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="stringBegins"
fnMarker="stringbegins"
foundNames=([0]="argument" [1]="return_code" [2]="summary")
line="525"
rawComment=$'Argument: haystack - String. Required. String to search.\nArgument: needle ... - String. Optional. One or more strings to find as the "start" of `haystack`.\nReturn Code: 0 - IFF ANY needle matches as a substring of haystack\nReturn Code: 1 - No needles found in haystack\nSummary: Find whether a substring exists as teh beginning of one or more strings\nDoes needle exist as a substring of haystack?\n\n'
return_code=$'0 - IFF ANY needle matches as a substring of haystack\n1 - No needles found in haystack\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="525"
summary="Find whether a substring exists as teh beginning of one or more strings"
summaryComputed=""
usage="stringBegins haystack [ needle ... ]"
