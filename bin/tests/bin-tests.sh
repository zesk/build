#!/usr/bin/env bash
#
# api-tests.sh
#
# API tests
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
errorEnvironment=1

testMakeEnv() {
    local v
    export TESTING_ENV=chameleon
    export DSN=mysql://not@host/thing

    export DEPLOY_USER_HOSTS=none
    export BUILD_TARGET=app2.tar.gz
    export DEPLOYMENT=test-make-env
    export APPLICATION_CHECKSUM=aabbccdd

    [ -f .env ] && rm .env
    bin/build/pipeline/make-env.sh TESTING_ENV DSN

    if [ ! -f .env ]; then
        consoleError "make-env.sh did not generate a .env file"
        return "$errorEnvironment"
    fi
    for v in TESTING_ENV APPLICATION_BUILD_DATE APPLICATION_VERSION DEPLOYMENT DSN; do
        if ! grep -q "$v" .env; then
            consoleError "make-env.sh .env file does not contain $v"
            return "$errorEnvironment"
        fi
    done
    consoleGreen make-env.sh works AOK
    rm .env
}

testBuildSetup() {
    local targetDir marker testBinary testOutput

    testSection build-setup.sh
    targetDir="test.$$/bin/deeper/deepest"
    mkdir -p "$targetDir"
    testBinary="$targetDir/build-setup.sh"
    cp bin/build/build-setup.sh "$testBinary"
    sed -i -e 's/^relTop=.*/relTop=..\/..\/../g' "$testBinary"
    chmod +x "$testBinary"
    marker=$(randomString)
    echo "# changed $marker" >>"$testBinary"

    if ! grep -q "$marker" "$testBinary"; then
        consoleError "binary $testBinary does not contain marker?"
        return "$errorEnvironment"
    fi

    testOutput=$(mktemp)
    if ! $testBinary >"$testOutput"; then
        consoleError "Binary $testBinary failed"
        return "$errorEnvironment"
    fi

    if ! grep -q "was updated" "$testOutput"; then
        consoleError "Missing was updated from $testBinary"
        buildFailed "$testOutput"
    fi

    if [ ! -d "test.$$/bin/build" ]; then
        consoleError "binary $testBinary failed to do the job"
        return "$errorEnvironment"
    fi
    if grep -q "$marker" "$testBinary"; then
        consoleError "binary $testBinary did not update itself as it should have"
        return "$errorEnvironment"
    fi

    if ! $testBinary >"$testOutput"; then
        consoleError "Binary $testBinary failed 2nd round - ok as live script is dead"
        return "$errorEnvironment"
    fi

    if ! grep -q "up to date" "$testOutput"; then
        consoleError "Missing up to date from $testBinary"
        buildFailed "$testOutput"
    fi

    consoleSuccess "build-setup.sh update was tested successfully"
    rm -rf "./test.$$"
}

testEnvMap() {
    local result expected

    testSection testEnvMap
    export FOO=test
    export BAR=goob

    result="$(echo "{FOO}{BAR}{foo}{bar}{BAR}" | bin/build/envmap.sh)"

    expected="testgoob{foo}{bar}goob"
    if [ "$result" != "$expected" ]; then
        consoleError "envmap.sh failed: $result != $expected"
        exit "$errorEnvironment"
    fi
    consoleSuccess OK
}

#
# Requires shellcheck so should be later in the testing process to have a cleaner build
#
# Side-effect: shellcheck is installed
#
testScripts() {
    local failedReasons thisYear f quietLog=$1
    testSection "Checking all shellcheck and bash -n"

    bin/build/install/apt.sh shellcheck
    if [ -f ./1 ]; then
        echo "1 found after apt.sh"
        exit 1
    fi
    whichApt shellcheck shellcheck

    thisYear=$(date +%Y)
    failedReasons=()
    while IFS= read -r -d '' f; do
        consoleInfo "Checking $f"
        if ! bash -n "$f"; then
            failedReasons+=("bash -n $f failed")
        fi
        if ! shellcheck "$f" >>"$quietLog"; then
            failedReasons+=("shellcheck $f failed")
        fi
        if ! grep -q "Copyright &copy; $thisYear" "$f"; then
            failedReasons+=("$f missing copyright")
        fi
    done < <(find . -name '*.sh' ! -path '*/.*' -print0)

    if [ "${#failedReasons[@]}" -gt 0 ]; then
        consoleError -n "The following scripts failed:"
        for f in "${failedReasons[@]}"; do
            echo "$(consoleMagenta -n "$f")$(consoleInfo -n ", ")"
        done
        consoleError "done."
        buildFailed "$quietLog"
    else
        consoleSuccess "All scripts passed"
    fi
}

testScriptInstalls() {
    local binary=$1 script=$2
    testSection "$binary"
    if which "$binary" >/dev/null; then
        consoleError "binary $binary is already installed?"
        return "$errorEnvironment"
    fi
    $script
    if ! which "$binary" >/dev/null; then
        consoleError "binary $binary was not installed by $script"
        return "$errorEnvironment"
    fi
}

#
# Side-effect: installs scripts
#
testScriptIntallations() {
    if ! which docker-compose >/dev/null; then
        testScriptInstalls docker-compose "bin/build/install/docker-compose.sh"
    fi

    testScriptInstalls php "bin/build/install/php-cli.sh"
    testScriptInstalls python "bin/build/install/python.sh"
    testScriptInstalls mariadb "bin/build/install/mariadb-client.sh"
    # requires docker
    if which docker >/dev/null; then
        echo "{}" >composer.json
        "bin/build/pipeline/composer.sh"
        if [ ! -d "vendor" ] || [ ! -f composer.lock ]; then
            consoleError "composer failed"
        fi
    fi

    if ! which git >/dev/null; then
        testScriptInstalls git "bin/build/install/git.sh"
    fi
    if ! which npm >/dev/null; then
        # npm 18 installed in this image
        testScriptInstalls npm "bin/build/install/npm.sh"
    fi
    testScriptInstalls prettier "bin/build/install/prettier.sh"

}
