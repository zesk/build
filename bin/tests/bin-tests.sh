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
# testShellScripts moved into tools/
#

__doesScriptInstall() {
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

testEnvmapPortability() {
    tempDir="./random.$$/"
    mkdir -p "$tempDir" || :
    cp ./bin/build/envmap.sh "./random.$$/"
    export DUDE=ax
    export WILD=m
    assertEquals "$(echo "{WILD}{DUDE}i{WILD}u{WILD}" | ./random.$$/envmap.sh)" "maximum"
    rm -rf "$tempDir"
}

#
# Side-effect: installs scripts
#
testScriptInstallations() {
    if ! which docker-compose >/dev/null; then
        __doesScriptInstall docker-compose "bin/build/install/docker-compose.sh"
    fi

    __doesScriptInstall php "bin/build/install/php-cli.sh"
    __doesScriptInstall python "bin/build/install/python.sh"
    __doesScriptInstall mariadb "bin/build/install/mariadb-client.sh"
    # requires docker
    if which docker >/dev/null; then
        echo "{}" >composer.json
        "bin/build/pipeline/composer.sh"
        if [ ! -d "vendor" ] || [ ! -f composer.lock ]; then
            consoleError "composer failed"
        fi
    fi

    if ! which git >/dev/null; then
        __doesScriptInstall git "bin/build/install/git.sh"
    fi
    if ! which npm >/dev/null; then
        # npm 18 installed in this image
        __doesScriptInstall npm "bin/build/install/npm.sh"
    fi
    __doesScriptInstall prettier "bin/build/install/prettier.sh"

    __doesScriptInstall terraform "bin/build/install/terraform.sh"
}
