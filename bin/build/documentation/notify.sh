#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"--title title - String. Optional. Sets the title for the notification."$'\n'"--message message - String. Optional. Display this message (alias is \`-m\`)"$'\n'"--fail failMessage - String. Optional. Display this message in console and dialog upon failure."$'\n'"--sound soundName - String. Optional. Sets the sound played for the notification."$'\n'"--fail-title title - String. Optional. Sets the title for the notification if the binary fails."$'\n'"--fail-sound soundName - String. Optional. Sets the sound played for the notification if the binary fails."$'\n'""
base="interactive.sh"
description="Notify after running a binary. Uses the \`notify\` hook with some handy parameters which are inherited"$'\n'"between \"success\" and \"failure\":"$'\n'""$'\n'"- Upon success uses: \`--message\` \`--title\` \`--sound\`"$'\n'"- Upon failure uses: \`--fail-message\` \`--fail-title\` \`--fail-sound\`"$'\n'""$'\n'"If a value is not specified for failure, it will use the \`success\` value."$'\n'""$'\n'""
file="bin/build/tools/interactive.sh"
fn="notify"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceModified="1768759374"
summary="Notify after running a binary. Uses the \`notify\` hook with"
usage="notify [ --help ] [ --handler handler ] [ --verbose ] [ --title title ] [ --message message ] [ --fail failMessage ] [ --sound soundName ] [ --fail-title title ] [ --fail-sound soundName ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mnotify[0m [94m[ --help ][0m [94m[ --handler handler ][0m [94m[ --verbose ][0m [94m[ --title title ][0m [94m[ --message message ][0m [94m[ --fail failMessage ][0m [94m[ --sound soundName ][0m [94m[ --fail-title title ][0m [94m[ --fail-sound soundName ][0m

    [94m--help                  [1;97mFlag. Optional. Display this help.[0m
    [94m--handler handler       [1;97mFunction. Optional. Use this error handler instead of the default error handler.[0m
    [94m--verbose               [1;97mFlag. Optional. Be verbose.[0m
    [94m--title title           [1;97mString. Optional. Sets the title for the notification.[0m
    [94m--message message       [1;97mString. Optional. Display this message (alias is [38;2;0;255;0;48;2;0;0;0m-m[0m)[0m
    [94m--fail failMessage      [1;97mString. Optional. Display this message in console and dialog upon failure.[0m
    [94m--sound soundName       [1;97mString. Optional. Sets the sound played for the notification.[0m
    [94m--fail-title title      [1;97mString. Optional. Sets the title for the notification if the binary fails.[0m
    [94m--fail-sound soundName  [1;97mString. Optional. Sets the sound played for the notification if the binary fails.[0m

Notify after running a binary. Uses the [38;2;0;255;0;48;2;0;0;0mnotify[0m hook with some handy parameters which are inherited
between "success" and "failure":

- Upon success uses: [38;2;0;255;0;48;2;0;0;0m--message[0m [38;2;0;255;0;48;2;0;0;0m--title[0m [38;2;0;255;0;48;2;0;0;0m--sound[0m
- Upon failure uses: [38;2;0;255;0;48;2;0;0;0m--fail-message[0m [38;2;0;255;0;48;2;0;0;0m--fail-title[0m [38;2;0;255;0;48;2;0;0;0m--fail-sound[0m

If a value is not specified for failure, it will use the [38;2;0;255;0;48;2;0;0;0msuccess[0m value.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: notify [ --help ] [ --handler handler ] [ --verbose ] [ --title title ] [ --message message ] [ --fail failMessage ] [ --sound soundName ] [ --fail-title title ] [ --fail-sound soundName ]

    --help                  Flag. Optional. Display this help.
    --handler handler       Function. Optional. Use this error handler instead of the default error handler.
    --verbose               Flag. Optional. Be verbose.
    --title title           String. Optional. Sets the title for the notification.
    --message message       String. Optional. Display this message (alias is -m)
    --fail failMessage      String. Optional. Display this message in console and dialog upon failure.
    --sound soundName       String. Optional. Sets the sound played for the notification.
    --fail-title title      String. Optional. Sets the title for the notification if the binary fails.
    --fail-sound soundName  String. Optional. Sets the sound played for the notification if the binary fails.

Notify after running a binary. Uses the notify hook with some handy parameters which are inherited
between "success" and "failure":

- Upon success uses: --message --title --sound
- Upon failure uses: --fail-message --fail-title --fail-sound

If a value is not specified for failure, it will use the success value.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
