#!/usr/bin/env bash
#
# build-test.sh
#
# Testing
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# docker run --platform linux/arm64 -v $(pwd):/opt/atlassian/bitbucketci/agent/build -it atlassian/default-image:4
# rm -rf .build/ test.*; set -a; source .env.prod-robot ; bin/build-test.sh

set -eo pipefail
errEnv=1

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
    consoleGreen "$bar"
    echo "$(consoleGreen -n \|) $(consoleInfo -n "$remain")$(repeat $spaces " ") $(consoleMagenta -n \|)"
    consoleMagenta "$bar"
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
        failed "$testOutput"
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
        failed "$testOutput"
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

#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#

testSection APT
bin/build/install/apt.sh shellcheck

whichApt shellcheck shellcheck

quietLog="./.build/$me.log"

requireFileDirectory "$quietLog"

testSection "Checking all shellcheck and bash -n"

failedScripts=()
while IFS= read -r -d '' f; do
    consoleInfo "Checking $f"
    bash -n "$f"
    if ! shellcheck "$f" >>"$quietLog"; then
        failedScripts+=("$f")
    fi
done < <(find . -name '*.sh' ! -path '*/.*' -print0)

if [ "${#failedScripts[@]}" -gt 0 ]; then
    consoleError -n "The following scripts failed:"
    for f in "${failedScripts[@]}"; do
        echo "$(consoleMagenta -n "$f") $(consoleWhite -n ", ")"
    done
    consoleError "done."
    failed "$quietLog"
else
    consoleSuccess "All scripts passed"
fi

testEnvMap
testBuildSetup
testUrlParse
# testScriptInstalls aws "bin/build/install/aws-cli.sh"
testAWSIPAccess

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

bigText Passed | prefixLines "$(consoleSuccess)"
