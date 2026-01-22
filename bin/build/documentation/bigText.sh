#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="text - String. Required. Text to output"$'\n'"--bigger - Flag. Optional. Text font size is bigger."$'\n'""
base="decoration.sh"
description="Display large text in the console for banners and important messages"$'\n'""$'\n'"\`BUILD_TEXT_BINARY\` can be \`figlet\` or \`toilet\`"$'\n'""$'\n'""$'\n'"standard (figlet)"$'\n'""$'\n'"     _     _      _____         _"$'\n'"    | |__ (_) __ |_   _|____  _| |_"$'\n'"    | '_ \\| |/ _\` || |/ _ \\ \\/ / __|"$'\n'"    | |_) | | (_| || |  __/>  <| |_"$'\n'"    |_.__/|_|\\__, ||_|\\___/_/\\_\\\\__|"$'\n'"             |___/"$'\n'""$'\n'"--bigger (figlet)"$'\n'""$'\n'"     _     _    _______        _"$'\n'"    | |   (_)  |__   __|      | |"$'\n'"    | |__  _  __ _| | _____  _| |_"$'\n'"    | '_ \\| |/ _\` | |/ _ \\ \\/ / __|"$'\n'"    | |_) | | (_| | |  __/>  <| |_"$'\n'"    |_.__/|_|\\__, |_|\\___/_/\\_\\\\__|"$'\n'"              __/ |"$'\n'"             |___/"$'\n'""$'\n'"smblock (regular) toilet"$'\n'""$'\n'"    ▌  ▗   ▀▛▘     ▐"$'\n'"    ▛▀▖▄ ▞▀▌▌▞▀▖▚▗▘▜▀"$'\n'"    ▌ ▌▐ ▚▄▌▌▛▀ ▗▚ ▐ ▖"$'\n'"    ▀▀ ▀▘▗▄▘▘▝▀▘▘ ▘ ▀"$'\n'""$'\n'"smmono12 (--bigger) toilet"$'\n'""$'\n'"    ▗▖     █       ▗▄▄▄▖"$'\n'"    ▐▌     ▀       ▝▀█▀▘           ▐▌"$'\n'"    ▐▙█▙  ██   ▟█▟▌  █   ▟█▙ ▝█ █▘▐███"$'\n'"    ▐▛ ▜▌  █  ▐▛ ▜▌  █  ▐▙▄▟▌ ▐█▌  ▐▌"$'\n'"    ▐▌ ▐▌  █  ▐▌ ▐▌  █  ▐▛▀▀▘ ▗█▖  ▐▌"$'\n'"    ▐█▄█▘▗▄█▄▖▝█▄█▌  █  ▝█▄▄▌ ▟▀▙  ▐▙▄"$'\n'"    ▝▘▀▘ ▝▀▀▀▘ ▞▀▐▌  ▀   ▝▀▀ ▝▀ ▀▘  ▀▀"$'\n'"               ▜█▛▘"$'\n'""
environment="BUILD_TEXT_BINARY"$'\n'""
file="bin/build/tools/decoration.sh"
fn="bigText"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decoration.sh"
sourceModified="1768721469"
summary="Display large text in the console for banners and important"
usage="bigText text [ --bigger ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbigText[0m [38;2;255;255;0m[35;48;2;0;0;0mtext[0m[0m [94m[ --bigger ][0m

    [31mtext      [1;97mString. Required. Text to output[0m
    [94m--bigger  [1;97mFlag. Optional. Text font size is bigger.[0m

Display large text in the console for banners and important messages

[38;2;0;255;0;48;2;0;0;0mBUILD_TEXT_BINARY[0m can be [38;2;0;255;0;48;2;0;0;0mfiglet[0m or [38;2;0;255;0;48;2;0;0;0mtoilet[0m


standard (figlet)

     _     _      _____         _
    | |__ (_) __ |_   _|____  _| |_
    | '\''_ \| |/ _[38;2;0;255;0;48;2;0;0;0m || |/ _ \ \/ / __|[0m
    | |_) | | (_| || |  __/>  <| |_
    |_.__/|_|\__, ||_|\___/_/\_\\__|
             |___/

--bigger (figlet)

     _     _    _______        _
    | |   (_)  |__   __|      | |
    | |__  _  __ _| | _____  _| |_
    | '\''_ \| |/ _[38;2;0;255;0;48;2;0;0;0m | |/ _ \ \/ / __|[0m
    | |_) | | (_| | |  __/>  <| |_
    |_.__/|_|\__, |_|\___/_/\_\\__|
              __/ |
             |___/

smblock (regular) toilet

    ▌  ▗   ▀▛▘     ▐
    ▛▀▖▄ ▞▀▌▌▞▀▖▚▗▘▜▀
    ▌ ▌▐ ▚▄▌▌▛▀ ▗▚ ▐ ▖
    ▀▀ ▀▘▗▄▘▘▝▀▘▘ ▘ ▀

smmono12 (--bigger) toilet

    ▗▖     █       ▗▄▄▄▖
    ▐▌     ▀       ▝▀█▀▘           ▐▌
    ▐▙█▙  ██   ▟█▟▌  █   ▟█▙ ▝█ █▘▐███
    ▐▛ ▜▌  █  ▐▛ ▜▌  █  ▐▙▄▟▌ ▐█▌  ▐▌
    ▐▌ ▐▌  █  ▐▌ ▐▌  █  ▐▛▀▀▘ ▗█▖  ▐▌
    ▐█▄█▘▗▄█▄▖▝█▄█▌  █  ▝█▄▄▌ ▟▀▙  ▐▙▄
    ▝▘▀▘ ▝▀▀▀▘ ▞▀▐▌  ▀   ▝▀▀ ▝▀ ▀▘  ▀▀
               ▜█▛▘

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_TEXT_BINARY
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bigText text [ --bigger ]

    text      String. Required. Text to output
    --bigger  Flag. Optional. Text font size is bigger.

Display large text in the console for banners and important messages

BUILD_TEXT_BINARY can be figlet or toilet


standard (figlet)

     _     _      _____         _
    | |__ (_) __ |_   _|____  _| |_
    | '\''_ \| |/ _ || |/ _ \ \/ / __|
    | |_) | | (_| || |  __/>  <| |_
    |_.__/|_|\__, ||_|\___/_/\_\\__|
             |___/

--bigger (figlet)

     _     _    _______        _
    | |   (_)  |__   __|      | |
    | |__  _  __ _| | _____  _| |_
    | '\''_ \| |/ _ | |/ _ \ \/ / __|
    | |_) | | (_| | |  __/>  <| |_
    |_.__/|_|\__, |_|\___/_/\_\\__|
              __/ |
             |___/

smblock (regular) toilet

    ▌  ▗   ▀▛▘     ▐
    ▛▀▖▄ ▞▀▌▌▞▀▖▚▗▘▜▀
    ▌ ▌▐ ▚▄▌▌▛▀ ▗▚ ▐ ▖
    ▀▀ ▀▘▗▄▘▘▝▀▘▘ ▘ ▀

smmono12 (--bigger) toilet

    ▗▖     █       ▗▄▄▄▖
    ▐▌     ▀       ▝▀█▀▘           ▐▌
    ▐▙█▙  ██   ▟█▟▌  █   ▟█▙ ▝█ █▘▐███
    ▐▛ ▜▌  █  ▐▛ ▜▌  █  ▐▙▄▟▌ ▐█▌  ▐▌
    ▐▌ ▐▌  █  ▐▌ ▐▌  █  ▐▛▀▀▘ ▗█▖  ▐▌
    ▐█▄█▘▗▄█▄▖▝█▄█▌  █  ▝█▄▄▌ ▟▀▙  ▐▙▄
    ▝▘▀▘ ▝▀▀▀▘ ▞▀▐▌  ▀   ▝▀▀ ▝▀ ▀▘  ▀▀
               ▜█▛▘

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_TEXT_BINARY
- 
'
