#!/usr/bin/env bash
#
# api-tests.sh
#
# API tests
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
errorEnvironment=1

declare -a tests

tests+=(testTools)
testTools() {
    assertEquals "$(plural 0 singular plural)" "plural" || return $?
    assertEquals "$(plural 1 singular plural)" "singular" || return $?
    assertEquals "$(plural 2 singular plural)" "plural" || return $?
    assertEquals "$(plural -1 singular plural)" "plural" || return $?
    assertExitCode 1 plural X singular plural || return $?

    assertEquals "$(alignRight 20 012345)" "              012345" || return $?
    assertEquals "$(alignRight 5 012345)" "012345" || return $?
    assertEquals "$(alignRight 0 012345)" "012345" || return $?

    assertEquals "$(dateToFormat 2023-04-20 %s)" "1681948800" || return $?
    assertEquals "$(dateToFormat 2023-04-20 %Y-%m-%d)" "2023-04-20" || return $?
    assertEquals "$(dateToTimestamp 2023-04-20)" "1681948800" || return $?
    consoleSuccess testTools OK
}

tests+=(testUrlParse)
testUrlParse() {
    local u url user name password host port

    testSection testUrlParse

    u=foo://user:hard-to-type@identity:4232/dbname

    eval "$(urlParse "$u")" || return $?

    assertEquals "$url" "$u" || return $?
    assertEquals "$user" user || return $?
    assertEquals "$name" dbname || return $?
    assertEquals "$host" identity || return $?
    assertEquals "$port" 4232 || return $?
    assertEquals "$password" hard-to-type || return $?

    u=mysql://user:hard-to-type@identity/dbname

    eval "$(urlParse "$u")" || return $?

    assertEquals "$url" "$u" || return $?
    assertEquals "$user" user || return $?
    assertEquals "$name" dbname || return $?
    assertEquals "$host" identity || return $?
    assertEquals "$port" "" || return $?
    assertEquals "$password" hard-to-type || return $?
    consoleSuccess testUrlParse OK || return $?
}

tests+=(testHooks)
testHooks() {
    for h in deploy-cleanup deploy-confirm make-env version-created version-live; do
        assertExitCode 0 hasHook $h || return $?
    done
    for h in misspelled-deployed-cleanup not-rude-confirm; do
        assertNotExitCode 0 hasHook $h || return $?
    done
    consoleSuccess testHooks OK
}

tests+=(testEnvironmentVariables)
testEnvironmentVariables() {
    assertOutputContains PWD environmentVariables || return $?
    assertOutputContains SHLVL environmentVariables || return $?
    assertOutputContains PATH environmentVariables || return $?
    assertOutputContains HOME environmentVariables || return $?
    assertOutputContains LANG environmentVariables || return $?
    assertOutputContains PWD environmentVariables || return $?
    consoleSuccess testEnvironmentVariables OK || return $?
}

tests+=(testDates)
testDates() {
    local t y
    assertEquals "$(timestampToDate 1697666075 %F)" "2023-10-18" || return $?
    assertEquals "$(todayDate)" "$(date +%F)" || return $?
    t="$(todayDate)"
    y="$(yesterdayDate)"
    assertEquals "${#t}" "${#y}" || return $?

    if [[ "$y" < "$t" ]]; then
        consoleSuccess testDates OK
    else
        consoleError "$y \< $t" failed
        return $errorEnvironment
    fi
}

tests+=(testMapPrefixSuffix)
testMapPrefixSuffix() {
    local assertItem=1
    assertEquals "Hello, world." "$(echo "[NAME], [PLACE]." | NAME=Hello PLACE=world bin/build/map.sh --prefix '[' --suffix ']')" "#$assertItem failed" || return $?
    assertItem=$((assertItem + 1))
    assertEquals "Hello, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh)" "#$assertItem failed" || return $?
    assertItem=$((assertItem + 1))
    assertEquals "Hello, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh NAME PLACE)" "#$assertItem failed" || return $?
    assertItem=$((assertItem + 1))
    assertEquals "Hello, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh NAME)" "#$assertItem failed" || return $?
    assertItem=$((assertItem + 1))
    assertEquals "{NAME}, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh PLACE)" "#$assertItem failed" || return $?
    assertItem=$((assertItem + 1))
    assertEquals "{NAME}, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh NAM PLAC)" "#$assertItem failed" || return $?
    assertItem=$((assertItem + 1))
    assertEquals "{NAME}, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/map.sh AME LACE)" "#$assertItem failed" || return $?
    assertItem=$((assertItem + 1))
    consoleSuccess testMapPrefixSuffix OK
}
