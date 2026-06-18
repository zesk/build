#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-17
# shellcheck disable=SC2034
argument=$'--tags tagList - CommaDelimitedList. Optional. Tags for notification. e.g. `warning,production`\n--priority priority - String. Optional. Priority of the notification. `low`, or `high`\n--title title - String. Optional. Title of the notification.\n--handler handler - Function. Optional. Use this error handler instead of the default error handler.\n--help - Flag. Optional. Display this help.\n'
base="notify.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Send a notification by submitting data to a URL"
descriptionLineCount=""
environment=$'NOTIFY_URL\nNOTIFY_URL_AUTHORIZATION\n'
file="bin/build/tools/notify.sh"
fn="notifyURL"
fnMarker="notifyurl"
foundNames=([0]="summary" [1]="argument" [2]="environment")
line="19"
rawComment=$'Summary: Send a notification by submitting data to a URL\nArgument: --tags tagList - CommaDelimitedList. Optional. Tags for notification. e.g. `warning,production`\nArgument: --priority priority - String. Optional. Priority of the notification. `low`, or `high`\nArgument: --title title - String. Optional. Title of the notification.\nArgument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.\nArgument: --help - Flag. Optional. Display this help.\nEnvironment: NOTIFY_URL\nEnvironment: NOTIFY_URL_AUTHORIZATION\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/notify.sh"
sourceHash="b014a67ada88e47512c0509c99147e345f80ebcf"
sourceLine="19"
summary="Send a notification by submitting data to a URL"
summaryComputed=""
usage="notifyURL [ --tags tagList ] [ --priority priority ] [ --title title ] [ --handler handler ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mnotifyURL'$'\e''[0m '$'\e''[[(blue)]m[ --tags tagList ]'$'\e''[0m '$'\e''[[(blue)]m[ --priority priority ]'$'\e''[0m '$'\e''[[(blue)]m[ --title title ]'$'\e''[0m '$'\e''[[(blue)]m[ --handler handler ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--tags tagList       '$'\e''[[(value)]mCommaDelimitedList. Optional. Tags for notification. e.g. '$'\e''[[(code)]mwarning,production'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--priority priority  '$'\e''[[(value)]mString. Optional. Priority of the notification. '$'\e''[[(code)]mlow'$'\e''[[(reset)]m, or '$'\e''[[(code)]mhigh'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--title title        '$'\e''[[(value)]mString. Optional. Title of the notification.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--handler handler    '$'\e''[[(value)]mFunction. Optional. Use this error handler instead of the default error handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help               '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Send a notification by submitting data to a URL'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- NOTIFY_URL'$'\n''- NOTIFY_URL_AUTHORIZATION'
# shellcheck disable=SC2016
helpPlain='Usage: notifyURL [ --tags tagList ] [ --priority priority ] [ --title title ] [ --handler handler ] [ --help ]'$'\n'''$'\n''    --tags tagList       CommaDelimitedList. Optional. Tags for notification. e.g. warning,production'$'\n''    --priority priority  String. Optional. Priority of the notification. low, or high'$'\n''    --title title        String. Optional. Title of the notification.'$'\n''    --handler handler    Function. Optional. Use this error handler instead of the default error handler.'$'\n''    --help               Flag. Optional. Display this help.'$'\n'''$'\n''Send a notification by submitting data to a URL'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- NOTIFY_URL'$'\n''- NOTIFY_URL_AUTHORIZATION'
documentationPath="documentation/source/tools/notify.md"
