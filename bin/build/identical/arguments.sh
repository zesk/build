#!/bin/bash
#
# Arguments used throughout Zesk Build
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.

# DOC TEMPLATE: assert-common 11
# Argument: --help - Optional. Flag. Display this help.
# Argument: --line lineNumber - Optional. Integer. Line number of calling function.
# Argument: --debug - Optional. Flag. Debugging
# Argument: --display - Optional. String. Display name for the condition.
# Argument: --success - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
# Argument: --stderr-match - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
# Argument: --stdout-no-match - Optional. String. One or more strings which must match stderr.
# Argument: --stdout-match - Optional. String. One or more strings which must match stdout.
# Argument: --stdout-no-match - Optional. String. One or more strings which must match stdout.
# Argument: --stderr-ok - Optional. Flag. Output to stderr will not cause the test to fail.
# Argument: --dump - Optional. Flag. Output stderr and stdout after test regardless.
# Argument: --leak globalName - Zero or more. String. Allow global leaks for these globals.
