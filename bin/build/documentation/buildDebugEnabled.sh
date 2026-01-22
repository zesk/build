#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/debug.sh"
argument="moduleName - String. Optional. If \`BUILD_DEBUG\` contains any token passed, debugging is enabled."$'\n'""
base="debug.sh"
description="Is build debugging enabled?"$'\n'""$'\n'"Return Code: 1 - Debugging is not enabled (for any module)"$'\n'"Return Code: 0 - Debugging is enabled"$'\n'""
environment="BUILD_DEBUG - Set to non-blank to enable debugging, blank to disable. \`BUILD_DEBUG\` may be a comma-separated list of modules to target debugging."$'\n'""
example="    BUILD_DEBUG=false # All debugging disabled"$'\n'"    BUILD_DEBUG= # All debugging disabled"$'\n'"    unset BUILD_DEBUG # All debugging is disabled"$'\n'"    BUILD_DEBUG=true # All debugging is enabled"$'\n'"    BUILD_DEBUG=handler,bashPrompt # Debug \`handler\` and \`bashPrompt\` calls"$'\n'""
file="bin/build/tools/debug.sh"
fn="buildDebugEnabled"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceModified="1769054493"
summary="Is build debugging enabled?"
usage="buildDebugEnabled [ moduleName ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbuildDebugEnabled[0m [94m[ moduleName ][0m

    [94mmoduleName  [1;97mString. Optional. If [38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m contains any token passed, debugging is enabled.[0m

Is build debugging enabled?

Return Code: 1 - Debugging is not enabled (for any module)
Return Code: 0 - Debugging is enabled

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_DEBUG - Set to non-blank to enable debugging, blank to disable. [38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m may be a comma-separated list of modules to target debugging.
- 

Example:
    BUILD_DEBUG=false # All debugging disabled
    BUILD_DEBUG= # All debugging disabled
    unset BUILD_DEBUG # All debugging is disabled
    BUILD_DEBUG=true # All debugging is enabled
    BUILD_DEBUG=handler,bashPrompt # Debug [38;2;0;255;0;48;2;0;0;0mhandler[0m and [38;2;0;255;0;48;2;0;0;0mbashPrompt[0m calls
'
# shellcheck disable=SC2016
helpPlain='Usage: buildDebugEnabled [ moduleName ]

    moduleName  String. Optional. If BUILD_DEBUG contains any token passed, debugging is enabled.

Is build debugging enabled?

Return Code: 1 - Debugging is not enabled (for any module)
Return Code: 0 - Debugging is enabled

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_DEBUG - Set to non-blank to enable debugging, blank to disable. BUILD_DEBUG may be a comma-separated list of modules to target debugging.
- 

Example:
    BUILD_DEBUG=false # All debugging disabled
    BUILD_DEBUG= # All debugging disabled
    unset BUILD_DEBUG # All debugging is disabled
    BUILD_DEBUG=true # All debugging is enabled
    BUILD_DEBUG=handler,bashPrompt # Debug handler and bashPrompt calls
'
