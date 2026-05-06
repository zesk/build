#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"--title title - String. Optional. Sets the title for the notification."$'\n'"--message message - String. Optional. Display this message (alias is \`-m\`)"$'\n'"--fail failMessage - String. Optional. Display this message in console and dialog upon failure."$'\n'"--sound soundName - String. Optional. Sets the sound played for the notification."$'\n'"--fail-title title - String. Optional. Sets the title for the notification if the binary fails."$'\n'"--fail-sound soundName - String. Optional. Sets the sound played for the notification if the binary fails."$'\n'""
base="interactive.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Notify after running a binary. Uses the \`notify\` hook with some handy parameters which are inherited"$'\n'"between \"success\" and \"failure\":"$'\n'""$'\n'"If a value is not specified for failure, it will use the \`success\` value."$'\n'""$'\n'""
descriptionLineCount="5"
file="bin/build/tools/interactive.sh"
fn="notify"
fnMarker="notify"
foundNames=([0]="__upon_success_uses" [1]="__upon_failure_uses" [2]="argument")
line="137"
rawComment="Notify after running a binary. Uses the \`notify\` hook with some handy parameters which are inherited"$'\n'"between \"success\" and \"failure\":"$'\n'"- Upon success uses: \`--message\` \`--title\` \`--sound\`"$'\n'"- Upon failure uses: \`--fail-message\` \`--fail-title\` \`--fail-sound\`"$'\n'"If a value is not specified for failure, it will use the \`success\` value."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --verbose - Flag. Optional. Be verbose."$'\n'"Argument: --title title - String. Optional. Sets the title for the notification."$'\n'"Argument: --message message - String. Optional. Display this message (alias is \`-m\`)"$'\n'"Argument: --fail failMessage - String. Optional. Display this message in console and dialog upon failure."$'\n'"Argument: --sound soundName - String. Optional. Sets the sound played for the notification."$'\n'"Argument: --fail-title title - String. Optional. Sets the title for the notification if the binary fails."$'\n'"Argument: --fail-sound soundName - String. Optional. Sets the sound played for the notification if the binary fails."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceHash="378aca49779b1c4a5f70a0c419c2a078d3e0d369"
sourceLine="137"
summary="Notify after running a binary. Uses the \`notify\` hook with"
summaryComputed="true"
usage="notify [ --help ] [ --handler handler ] [ --verbose ] [ --title title ] [ --message message ] [ --fail failMessage ] [ --sound soundName ] [ --fail-title title ] [ --fail-sound soundName ]"
