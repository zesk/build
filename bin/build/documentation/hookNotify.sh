#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--sound soundName - String. Optional. Sound name to play. Depends on context of notification.\n--tags tagList - CommaDelimitedList. Optional. Tags for notification. e.g. `warning,production`\n--priority priority - String. Optional. Priority of the notification. `low`, or `high`\n--title title - String. Optional. Title of the notification.\n--help - Flag. Optional. Display this help.\n--application application - Directory. Optional. Application home directory.\n'
base="hooks.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Send a notification.\n\nWrapper for the hook `notify`.\n\n'
descriptionLineCount="4"
file="bin/build/tools/hooks.sh"
fn="hookNotify"
fnMarker="hooknotify"
foundNames=([0]="summary" [1]="argument")
line="75"
rawComment=$'Summary: Send a notification\nSend a notification.\nWrapper for the hook `notify`.\nArgument: --sound soundName - String. Optional. Sound name to play. Depends on context of notification.\nArgument: --tags tagList - CommaDelimitedList. Optional. Tags for notification. e.g. `warning,production`\nArgument: --priority priority - String. Optional. Priority of the notification. `low`, or `high`\nArgument: --title title - String. Optional. Title of the notification.\nArgument: --help - Flag. Optional. Display this help.\nArgument: --application application - Directory. Optional. Application home directory.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/hooks.sh"
sourceHash="10965a6a7738505d4ec864bc27c451621f1536bd"
sourceLine="75"
summary="Send a notification"
summaryComputed=""
usage="hookNotify [ --sound soundName ] [ --tags tagList ] [ --priority priority ] [ --title title ] [ --help ] [ --application application ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mhookNotify'$'\e''[0m '$'\e''[[(blue)]m[ --sound soundName ]'$'\e''[0m '$'\e''[[(blue)]m[ --tags tagList ]'$'\e''[0m '$'\e''[[(blue)]m[ --priority priority ]'$'\e''[0m '$'\e''[[(blue)]m[ --title title ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --application application ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--sound soundName          '$'\e''[[(value)]mString. Optional. Sound name to play. Depends on context of notification.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--tags tagList             '$'\e''[[(value)]mCommaDelimitedList. Optional. Tags for notification. e.g. '$'\e''[[(code)]mwarning,production'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--priority priority        '$'\e''[[(value)]mString. Optional. Priority of the notification. '$'\e''[[(code)]mlow'$'\e''[[(reset)]m, or '$'\e''[[(code)]mhigh'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--title title              '$'\e''[[(value)]mString. Optional. Title of the notification.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--application application  '$'\e''[[(value)]mDirectory. Optional. Application home directory.'$'\e''[[(reset)]m'$'\n'''$'\n''Send a notification.'$'\n'''$'\n''Wrapper for the hook '$'\e''[[(code)]mnotify'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: hookNotify [ --sound soundName ] [ --tags tagList ] [ --priority priority ] [ --title title ] [ --help ] [ --application application ]'$'\n'''$'\n''    --sound soundName          String. Optional. Sound name to play. Depends on context of notification.'$'\n''    --tags tagList             CommaDelimitedList. Optional. Tags for notification. e.g. warning,production'$'\n''    --priority priority        String. Optional. Priority of the notification. low, or high'$'\n''    --title title              String. Optional. Title of the notification.'$'\n''    --help                     Flag. Optional. Display this help.'$'\n''    --application application  Directory. Optional. Application home directory.'$'\n'''$'\n''Send a notification.'$'\n'''$'\n''Wrapper for the hook notify.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath=""
