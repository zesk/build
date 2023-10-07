#!/usr/bin/env bash
#
# build-test.sh
#
# Testing
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Test locally:
# docker run --platform linux/arm64 -v $(pwd):/opt/atlassian/bitbucketci/agent/build -it atlassian/default-image:4
# rm -rf .build/ test.*; set -a; source .env.prod-robot ; bin/test.sh

set -eo pipefail
errEnv=1

quietLog="./.build/$me.log"

me=$(basename "$0")
relTop=".."
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
    echo "$me: Can not cd to $relTop" 1>&2
    exit $errEnv
fi

# shellcheck source=/dev/null
. ./bin/build/tools.sh

usage() {
    local result

    result=$1
    shift
    consoleError "$*"
    echo
    consoleInfo "$me failed"
    exit "$result"
}

assertEquals() {
    local a=$1 b=$2
    shift
    shift
    if [ "$a" != "$b" ]; then
        consoleError "$a != $b $*"
        exit $errEnv
    else
        consoleSuccess "$a == $b"
    fi
}

testSection() {
    local bar spaces remain

    bar="+$(echoBar)+"
    remain="$*"
    spaces=$((${#bar} - ${#remain} - 4))
    consoleDecoration "$bar"
    echo "$(consoleDecoration -n \|) $(consoleInfo -n "$remain")$(repeat $spaces " ") $(consoleDecoration -n \|)"
    consoleDecoration "$bar"
}

testScripts() {
    local failedReasons thisYear f
    testSection "Checking all shellcheck and bash -n"

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
        return "$errEnv"
    fi
    $script
    if ! which "$binary" >/dev/null; then
        consoleError "binary $binary was not installed by $script"
        return "$errEnv"
    fi
}
randomString() {
    head --bytes=64 /dev/random | md5sum | cut -f 1 -d ' '
}

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
        exit $errEnv
    fi
    consoleSuccess OK
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
        return $errEnv
    fi

    testOutput=$(mktemp)
    if ! $testBinary >"$testOutput"; then
        consoleError "Binary $testBinary failed"
        return $errEnv
    fi

    if ! grep -q "was updated" "$testOutput"; then
        consoleError "Missing was updated from $testBinary"
        buildFailed "$testOutput"
    fi

    if [ ! -d "test.$$/bin/build" ]; then
        consoleError "binary $testBinary failed to do the job"
        return $errEnv
    fi
    if grep -q "$marker" "$testBinary"; then
        consoleError "binary $testBinary did not update itself as it should have"
        return $errEnv
    fi

    if ! $testBinary >"$testOutput"; then
        consoleError "Binary $testBinary failed 2nd round - ok as live script is dead"
        return $errEnv
    fi

    if ! grep -q "up to date" "$testOutput"; then
        consoleError "Missing up to date from $testBinary"
        buildFailed "$testOutput"
    fi

    consoleSuccess "build-setup.sh update was tested successfully"
    rm -rf "$targetDir"
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
}

testAWSIPAccess() {
    local id key
    usageEnvironment TEST_AWS_SECURITY_GROUP AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION HOME

    if [ ! -d "$HOME" ]; then
        usage $errEnv "No HOME defined or exists: $HOME"
    fi
    if [ -d "$HOME/.aws" ]; then
        usage $errEnv "No .aws directory should exist already"
    fi

    # Work using environment variables
    testSection "CLI IP and env credentials"
    bin/build/pipeline/aws-ip-access.sh --services ssh,mysql --id robot@zesk/build --ip 10.0.0.1 "$TEST_AWS_SECURITY_GROUP"
    bin/build/pipeline/aws-ip-access.sh --revoke --services ssh,mysql --id robot@zesk/build --ip 10.0.0.1 "$TEST_AWS_SECURITY_GROUP"

    # copy env to locals
    id=$AWS_ACCESS_KEY_ID
    key=$AWS_SECRET_ACCESS_KEY

    # delete them
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY

    testSection "CLI IP and no credentials - fails"
    if bin/build/pipeline/aws-ip-access.sh --services ssh,http --id robot@zesk/build --ip 10.0.0.1 "$TEST_AWS_SECURITY_GROUP" 2>/dev/null; then
        usage $errEnv "Should not succeed with no credentials"
    fi

    mkdir "$HOME/.aws"
    {
        echo "[default]"
        echo "aws_access_key_id = $id"
        echo "aws_secret_access_key = $key"
    } >"$HOME/.aws/credentials"

    testSection "CLI IP and file system credentials"
    # Work using environment variables
    bin/build/pipeline/aws-ip-access.sh --services ssh,http --id robot@zesk/build --ip 10.0.0.1 "$TEST_AWS_SECURITY_GROUP"
    bin/build/pipeline/aws-ip-access.sh --revoke --services ssh,http --id robot@zesk/build --ip 10.0.0.1 "$TEST_AWS_SECURITY_GROUP"

    testSection "Generated IP and file system credentials"
    # Work using environment variables
    bin/build/pipeline/aws-ip-access.sh --services ssh,http --id robot@zesk/build-autoip "$TEST_AWS_SECURITY_GROUP"
    bin/build/pipeline/aws-ip-access.sh --revoke --services ssh,http --id robot@zesk/build-autoip "$TEST_AWS_SECURITY_GROUP"

    rm "$HOME/.aws/credentials"
    rmdir "$HOME/.aws"

    # restore all set for other tests
    export AWS_ACCESS_KEY_ID=$id
    export AWS_SECRET_ACCESS_KEY=$key
}

testAWSExpiration() {
    local thisYear thisMonth expirationDays start

    start=$(beginTiming)
    testSection "AWS_ACCESS_KEY_DATE/isAWSKeyUpToDate testing"
    thisYear=$(($(date +%Y) + 0))
    thisMonth="$(date +%m)"
    unset AWS_ACCESS_KEY_DATE
    if isAWSKeyUpToDate; then
        consoleError "unset AWS_ACCESS_KEY_DATE should NOT be up to date"
        return $errEnv
    fi
    export AWS_ACCESS_KEY_DATE=
    if isAWSKeyUpToDate; then
        consoleError "blank AWS_ACCESS_KEY_DATE should NOT be up to date"
        return $errEnv
    fi
    AWS_ACCESS_KEY_DATE=99999
    if isAWSKeyUpToDate; then
        consoleError "invalid AWS_ACCESS_KEY_DATE ($AWS_ACCESS_KEY_DATE) should NOT be up to date"
        return $errEnv
    fi
    AWS_ACCESS_KEY_DATE=2020-01-01
    if isAWSKeyUpToDate; then
        consoleError "$AWS_ACCESS_KEY_DATE should NOT be up to date"
        return $errEnv
    fi
    AWS_ACCESS_KEY_DATE="$thisYear-01-01"
    expirationDays=366
    if ! isAWSKeyUpToDate $expirationDays; then
        consoleError "$AWS_ACCESS_KEY_DATE should be up to date $expirationDays"
        return $errEnv
    fi
    AWS_ACCESS_KEY_DATE="$((thisYear - 1))-01-01"
    expirationDays=365
    if isAWSKeyUpToDate $expirationDays; then
        consoleError "$AWS_ACCESS_KEY_DATE should NOT be up to date $expirationDays"
        return $errEnv
    fi
    AWS_ACCESS_KEY_DATE="$thisYear-$thisMonth-01"
    if ! isAWSKeyUpToDate; then
        consoleError "$AWS_ACCESS_KEY_DATE should be up to date"
        return $errEnv
    fi
    reportTiming "$start" Done
}

testDotEnvConfig() {
    local tempDir="$$.dotEnvConfig"
    mkdir "$tempDir"
    cd "$tempDir"
    consoleInfo "$(pwd)"
    touch .env
    if ! dotEnvConfig || [ -n "$(dotEnvConfig)" ]; then
        consoleError "dotEnvConfig failed with just .env"
        return $errEnv
    fi
    touch .env.local
    if ! dotEnvConfig || [ -n "$(dotEnvConfig)" ]; then
        consoleError "dotEnvConfig failed with both .env"
        return $errEnv
    fi
    cd ..
    rm -rf "$tempDir"
    consoleGreen dotEnvConfig works AOK
}
#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
requireFileDirectory "$quietLog"

testSection API
testDotEnvConfig

testSection APT
bin/build/install/apt.sh shellcheck

whichApt shellcheck shellcheck

bigText allColorTest | prefixLines "$(consoleMagenta)"
allColorTest
echo
bigText colorTest | prefixLines "$(consoleGreen)"
colorTest
echo

testScripts
testTools
testEnvMap

if ! which docker-compose >/dev/null; then
    testScriptInstalls docker-compose "bin/build/install/docker-compose.sh"
fi

testBuildSetup
testUrlParse
testAWSExpiration

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

# testScriptInstalls aws "bin/build/install/aws-cli.sh"
testAWSIPAccess

if ! which git >/dev/null; then
    testScriptInstalls git "bin/build/install/git.sh"
fi
if ! which npm >/dev/null; then
    # npm 18 installed in this image
    testScriptInstalls npm "bin/build/install/npm.sh"
fi
testScriptInstalls prettier "bin/build/install/prettier.sh"

testCleanup() {
    rm -rf vendor composer.json composer.lock test.*/ ./aws .build 2>/dev/null || :
}
testCleanup
bigText Passed | prefixLines "$(consoleSuccess)"
