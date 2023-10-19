#!/usr/bin/env bash
#
# api-tests.sh
#
# API tests
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
errorEnvironment=1

testTools() {
    assertEquals "$(plural 0 singular plural)" "plural"
    assertEquals "$(plural 1 singular plural)" "singular"
    assertEquals "$(plural 2 singular plural)" "plural"
    assertEquals "$(plural -1 singular plural)" "plural"
    assertEquals "$(plural X singular plural)" "plural"

    assertEquals "$(alignRight 20 012345)" "              012345"
    assertEquals "$(alignRight 5 012345)" "012345"
    assertEquals "$(alignRight 0 012345)" "012345"

    assertEquals "$(dateToFormat 2023-04-20 %s)" "1681948800"
    assertEquals "$(dateToFormat 2023-04-20 %Y-%m-%d)" "2023-04-20"
    assertEquals "$(dateToTimestamp 2023-04-20)" "1681948800"
    consoleSuccess testTools OK
}

testUrlParse() {
    local u url user name password host port

    testSection testUrlParse

    u=foo://user:hard-to-type@identity:4232/dbname

    eval "$(urlParse "$u")"

    assertEquals "$url" "$u"
    assertEquals "$user" user
    assertEquals "$name" dbname
    assertEquals "$host" identity
    assertEquals "$port" 4232
    assertEquals "$password" hard-to-type

    u=mysql://user:hard-to-type@identity/dbname

    eval "$(urlParse "$u")"

    assertEquals "$url" "$u"
    assertEquals "$user" user
    assertEquals "$name" dbname
    assertEquals "$host" identity
    assertEquals "$port" ""
    assertEquals "$password" hard-to-type
    consoleSuccess testUrlParse OK
}

testDotEnvConfigure() {
    local tempDir="$$.dotEnvConfig"
    mkdir "$tempDir"
    cd "$tempDir" || exit
    consoleInfo "$(pwd)"
    touch .env
    if ! dotEnvConfigure || [ -n "$(dotEnvConfigure)" ]; then
        consoleError "dotEnvConfigure failed with just .env"
        return "$errorEnvironment"
    fi
    touch .env.local
    if ! dotEnvConfigure || [ -n "$(dotEnvConfigure)" ]; then
        consoleError "dotEnvConfigure failed with both .env"
        return "$errorEnvironment"
    fi
    cd ..
    rm -rf "$tempDir"
    consoleSuccess dotEnvConfigure works AOK
}

testHooks() {
    for h in deploy-cleanup deploy-confirm make-env version-created version-live; do
        assertExitCode 0 hasHook $h
    done
    for h in misspelled-deployed-cleanup not-rude-confirm; do
        assertNotExitCode 0 hasHook $h
    done
    consoleSuccess testHooks OK
}

testEnvironmentVariables() {
    assertOutputContains PWD environmentVariables
    assertOutputContains SHLVL environmentVariables
    assertOutputContains PATH environmentVariables
    assertOutputContains HOME environmentVariables
    assertOutputContains LANG environmentVariables
    assertOutputContains PWD environmentVariables
    consoleSuccess testEnvironmentVariables OK
}

testDates() {
    local t y
    assertEquals "$(timestampToDate 1697666075 %F)" "2023-10-18"
    assertEquals "$(todayDate)" "$(date +%F)"
    t="$(todayDate)"
    y="$(yesterdayDate)"
    assertEquals "${#t}" "${#y}"

    if [[ "$y" < "$t" ]]; then
        consoleSuccess testDates OK
    else
        consoleError "$y \< $t" failed
        return $errorEnvironment
    fi
}

testEnvMap() {
    assertEquals "Hello, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/envmap.sh)"
    assertEquals "Hello, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/envmap.sh NAME PLACE)"
    assertEquals "Hello, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/envmap.sh NAME)"
    assertEquals "{NAME}, world." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/envmap.sh PLACE)"
    assertEquals "{NAME}, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/envmap.sh NAM PLAC)"
    assertEquals "{NAME}, {PLACE}." "$(echo "{NAME}, {PLACE}." | NAME=Hello PLACE=world bin/build/envmap.sh AME LACE)"
    consoleSuccess testEnvMap OK
}
