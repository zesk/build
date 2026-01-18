#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--help - Flag. Optional.Display this help."$'\n'"--handler handler - Function. Optional.Use this error handler instead of the default error handler."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"--title title - String. Optional. Sets the title for the notification."$'\n'"--message message - String. Optional. Display this message (alias is \`-m\`)"$'\n'"--fail failMessage - String. Optional. Display this message in console and dialog upon failure."$'\n'"--sound soundName - String. Optional. Sets the sound played for the notification."$'\n'"--fail-title title - String. Optional. Sets the title for the notification if the binary fails."$'\n'"--fail-sound soundName - String. Optional. Sets the sound played for the notification if the binary fails."$'\n'""
base="interactive.sh"
description="Notify after running a binary. Uses the \`notify\` hook with some handy parameters which are inherited"$'\n'"between \"success\" and \"failure\":"$'\n'""$'\n'"- Upon success uses: \`--message\` \`--title\` \`--sound\`"$'\n'"- Upon failure uses: \`--fail-message\` \`--fail-title\` \`--fail-sound\`"$'\n'""$'\n'"If a value is not specified for failure, it will use the \`success\` value."$'\n'""$'\n'""
file="bin/build/tools/interactive.sh"
fn="notify"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/interactive.sh"
sourceModified="1768695708"
summary="Notify after running a binary. Uses the \`notify\` hook with"
usage="notify [ --help ] [ --handler handler ] [ --verbose ] [ --title title ] [ --message message ] [ --fail failMessage ] [ --sound soundName ] [ --fail-title title ] [ --fail-sound soundName ]"
