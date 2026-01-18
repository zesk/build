#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="text - String. Required. Text to output"$'\n'"--bigger - Flag. Optional. Text font size is bigger."$'\n'""
base="decoration.sh"
description="Display large text in the console for banners and important messages"$'\n'""$'\n'"\`BUILD_TEXT_BINARY\` can be \`figlet\` or \`toilet\`"$'\n'""$'\n'""$'\n'"standard (figlet)"$'\n'""$'\n'"     _     _      _____         _"$'\n'"    | |__ (_) __ |_   _|____  _| |_"$'\n'"    | '_ \\| |/ _\` || |/ _ \\ \\/ / __|"$'\n'"    | |_) | | (_| || |  __/>  <| |_"$'\n'"    |_.__/|_|\\__, ||_|\\___/_/\\_\\\\__|"$'\n'"             |___/"$'\n'""$'\n'"--bigger (figlet)"$'\n'""$'\n'"     _     _    _______        _"$'\n'"    | |   (_)  |__   __|      | |"$'\n'"    | |__  _  __ _| | _____  _| |_"$'\n'"    | '_ \\| |/ _\` | |/ _ \\ \\/ / __|"$'\n'"    | |_) | | (_| | |  __/>  <| |_"$'\n'"    |_.__/|_|\\__, |_|\\___/_/\\_\\\\__|"$'\n'"              __/ |"$'\n'"             |___/"$'\n'""$'\n'"smblock (regular) toilet"$'\n'""$'\n'"    ▌  ▗   ▀▛▘     ▐"$'\n'"    ▛▀▖▄ ▞▀▌▌▞▀▖▚▗▘▜▀"$'\n'"    ▌ ▌▐ ▚▄▌▌▛▀ ▗▚ ▐ ▖"$'\n'"    ▀▀ ▀▘▗▄▘▘▝▀▘▘ ▘ ▀"$'\n'""$'\n'"smmono12 (--bigger) toilet"$'\n'""$'\n'"    ▗▖     █       ▗▄▄▄▖"$'\n'"    ▐▌     ▀       ▝▀█▀▘           ▐▌"$'\n'"    ▐▙█▙  ██   ▟█▟▌  █   ▟█▙ ▝█ █▘▐███"$'\n'"    ▐▛ ▜▌  █  ▐▛ ▜▌  █  ▐▙▄▟▌ ▐█▌  ▐▌"$'\n'"    ▐▌ ▐▌  █  ▐▌ ▐▌  █  ▐▛▀▀▘ ▗█▖  ▐▌"$'\n'"    ▐█▄█▘▗▄█▄▖▝█▄█▌  █  ▝█▄▄▌ ▟▀▙  ▐▙▄"$'\n'"    ▝▘▀▘ ▝▀▀▀▘ ▞▀▐▌  ▀   ▝▀▀ ▝▀ ▀▘  ▀▀"$'\n'"               ▜█▛▘"$'\n'""
environment="BUILD_TEXT_BINARY"$'\n'""
file="bin/build/tools/decoration.sh"
fn="bigText"
foundNames=([0]="argument" [1]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/decoration.sh"
sourceModified="1768695708"
summary="Display large text in the console for banners and important"
usage="bigText text [ --bigger ]"
