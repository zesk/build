#!/usr/bin/env bash
#
# deploy-tests.sh
#
# Deploy tests
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -e

declare -a tests
tests+=(deployApplicationTest)

deployApplicationTest() {
    local d

    home=$(pwd)
    d=$(mktemp -d)

    cd "$d" || exit
    consoleNameValue 20 "Deploy Root" "$d"
    mkdir live-app
    mkdir -p app/.deploy
    mkdir -p app/bin/build
    echo "Hello, world" >app/index.php
    cp -R "$home/bin/build" "app/bin"
    cd app || exit
    for t in 1a 2b 3c 4d; do
        echo -n "$t" | tee .deploy/APPLICATION_CHECKSUM >.deploy/APPLICATION_TAG
        echo "APPLICATION_CHECKSUM=$t" >.env
        echo "APPLICATION_TAG=$t" >>.env
        mkdir -p "$d/DEPLOY/$t"
        tar cfz "$d/DEPLOY/$t/app.tar.gz" .deploy bin index.php .env
    done
    cd ..
    rm -rf app

    for t in 1a 2b 3c 4d; do
        assertExitCode 0 deployHasVersion "$d/DEPLOY" $t
        assertExitCode 0 deployApplication "$d/DEPLOY" "$t" app.tar.gz "$d/live-app"
        assertEquals "$t" "$(getApplicationDeployVersion "$d/live-app")"
    done

    assertNotExitCode 0 deployHasVersion "$d/DEPLOY" "2a"

    assertEquals "" "$(deployPreviousVersion "$d/DEPLOY" "1a")"
    assertEquals "1a" "$(deployPreviousVersion "$d/DEPLOY" "2b")" deployPreviousVersion "$d/DEPLOY" "2b"
    assertEquals "2b" "$(deployPreviousVersion "$d/DEPLOY" "3c")"
    assertEquals "3c" "$(deployPreviousVersion "$d/DEPLOY" "4d")"

    assertEquals "2b" "$(deployNextVersion "$d/DEPLOY" "1a")" deployNextVersion "$d/DEPLOY" "1a"
    assertEquals "3c" "$(deployNextVersion "$d/DEPLOY" "2b")" deployNextVersion "$d/DEPLOY" "2b"
    assertEquals "4d" "$(deployNextVersion "$d/DEPLOY" "3c")" deployNextVersion "$d/DEPLOY" "3c"
    assertEquals "" "$(deployNextVersion "$d/DEPLOY" "4d")" deployNextVersion "$d/DEPLOY" "4d"

    undoDeployApplication "$d/DEPLOY" "4d" app.tar.gz "$d/live-app"
    deployApplication "$d/DEPLOY" "1a" app.tar.gz "$d/live-app"
    deployApplication "$d/DEPLOY" "3c" app.tar.gz "$d/live-app"

    assertNotExitCode 0 deployApplication "$d/DEPLOY" "3g" app.tar.gz "$d/live-app"

    assertEquals "" "$(deployPreviousVersion "$d/DEPLOY" "1a")"
    assertEquals "1a" "$(deployPreviousVersion "$d/DEPLOY" "2b")"
    assertEquals "2b" "$(deployPreviousVersion "$d/DEPLOY" "3c")"
    assertEquals "3c" "$(deployPreviousVersion "$d/DEPLOY" "4d")"

    assertEquals "2b" "$(deployNextVersion "$d/DEPLOY" "1a")"
    assertEquals "3c" "$(deployNextVersion "$d/DEPLOY" "2b")"
    assertEquals "4d" "$(deployNextVersion "$d/DEPLOY" "3c")"
    assertEquals "" "$(deployNextVersion "$d/DEPLOY" "4d")"

    cd "$d" || return 1

    # find . -type f

    cd "$home"
}

# source ./bin/build/tools.sh
# source ./bin/tests/deploy-tests.sh
# deployApplicationTest
# . bin/build/tools.sh; . bin/tests/deploy-tests.sh; deployApplicationTest
