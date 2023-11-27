#!/bin/bash
#
# Test identical-check.sh script
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

#shellcheck source=/dev/null
. ./bin/build/tools.sh

identicalCheckArgs=(--cd bin/tests/example --extension 'txt')

consoleInfo "same file match"
assertOutputDoesNotContain --stderr 'Token code changed' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# eIDENTICAL'

consoleInfo "same file mismatch"
assertOutputContains --stderr --exit 100 'Token code changed' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# fIDENTICAL'

consoleInfo "overlap failure"
assertOutputContains --stderr --exit 100 'overlap' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# aIDENTICAL'

consoleInfo "bad number failure"
assertOutputContains --stderr --exit 100 'not a number' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# bIDENTICAL'
assertOutputContains --stderr --exit 100 'counts do not match' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# bIDENTICAL'

consoleInfo "single instance failure"
assertOutputContains --stderr --exit 100 'Single instance of token found:' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# cIDENTICAL'
assertOutputContains --stderr --exit 100 'Single instance of token found:' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# xIDENTICAL'

consoleInfo "passing 3 files"
assertExitCode 0 ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '# dIDENTICAL'

consoleInfo "slash slash"
assertOutputContains --stderr --exit 100 'Token code changed' ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '// Alternate heading is identical '

consoleInfo "slash slash prefix mismatch"
assertExitCode 100 ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '// IDENTICAL'

consoleInfo "case match"
assertExitCode 0 ./bin/build/identical-check.sh "${identicalCheckArgs[@]}" --prefix '// Identical'
