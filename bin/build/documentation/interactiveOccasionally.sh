#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--delta deltaMilliseconds - PositiveInteger. Optional. Default is 60000."$'\n'"--mark - Flag. Optional. Write the marker which says the"$'\n'"--verbose - Flag. Optional. Be chatty."$'\n'"name - EnvironmentVariable. Required. The global codename for this interaction."$'\n'""
base="interactive.sh"
description="Do something the first time and then only occasionally thereafter."$'\n'"This manages a state file compared to the current time and triggers after \`delta\` seconds."$'\n'"Think of it like something that only returns 0 like once every \`delta\` seconds but it's going to happen at minimum \`delta\` seconds, or the next time after that. And the first time as well."$'\n'"Return Code: 0 - Do the thing"$'\n'"Return Code: 1 - Do not do the thing"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/interactive.sh"
fn="interactiveOccasionally"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceModified="1768759374"
summary="Do something the first time and then only occasionally thereafter."
usage="interactiveOccasionally [ --delta deltaMilliseconds ] [ --mark ] [ --verbose ] name"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255minteractiveOccasionally[0m [94m[ --delta deltaMilliseconds ][0m [94m[ --mark ][0m [94m[ --verbose ][0m [38;2;255;255;0m[35;48;2;0;0;0mname[0m[0m

    [94m--delta deltaMilliseconds  [1;97mPositiveInteger. Optional. Default is 60000.[0m
    [94m--mark                     [1;97mFlag. Optional. Write the marker which says the[0m
    [94m--verbose                  [1;97mFlag. Optional. Be chatty.[0m
    [31mname                       [1;97mEnvironmentVariable. Required. The global codename for this interaction.[0m

Do something the first time and then only occasionally thereafter.
This manages a state file compared to the current time and triggers after [38;2;0;255;0;48;2;0;0;0mdelta[0m seconds.
Think of it like something that only returns 0 like once every [38;2;0;255;0;48;2;0;0;0mdelta[0m seconds but it'\''s going to happen at minimum [38;2;0;255;0;48;2;0;0;0mdelta[0m seconds, or the next time after that. And the first time as well.
Return Code: 0 - Do the thing
Return Code: 1 - Do not do the thing
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: interactiveOccasionally [ --delta deltaMilliseconds ] [ --mark ] [ --verbose ] name

    --delta deltaMilliseconds  PositiveInteger. Optional. Default is 60000.
    --mark                     Flag. Optional. Write the marker which says the
    --verbose                  Flag. Optional. Be chatty.
    name                       EnvironmentVariable. Required. The global codename for this interaction.

Do something the first time and then only occasionally thereafter.
This manages a state file compared to the current time and triggers after delta seconds.
Think of it like something that only returns 0 like once every delta seconds but it'\''s going to happen at minimum delta seconds, or the next time after that. And the first time as well.
Return Code: 0 - Do the thing
Return Code: 1 - Do not do the thing
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
