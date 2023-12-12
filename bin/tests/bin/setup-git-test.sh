#!/bin/bash
#
# setup-git-test.sh
#
# install-bin-build.sh tests
#
# Note that this tests the LIVE version of build-setup.sh so it's a version behind
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

section=0

buildHome=$1
shift

# shellcheck source=/dev/null
. "$buildHome/bin/build/tools.sh"

testDir=$(mktemp -d)
cd "$testDir"

mkdir -p bin/pipeline
cp "$buildHome/bin/build/install-bin-build.sh" "bin/pipeline/install-bin-build.sh"
echo '# this make the file different' >>bin/pipeline/install-bin-build.sh

# --------------------------------------------------------------------------------
#
title="No .gitignore, was updated, same name"
#
section=$((section + 1))
boxedHeading "$section: $title"
logFile=$section.log

assertDirectoryDoesNotExist bin/build

bin/pipeline/install-bin-build.sh --mock "$buildHome/bin/build" >$logFile 2>&1

assertDirectoryExists bin/build

assertFileContains $logFile install-bin-build.sh

assertFileContains $logFile "was updated"
assertFileDoesNotContain $logFile "is up to date"

assertFileDoesNotContain $logFile "does not ignore"

rm -rf bin/build

consoleSuccess Success

# --------------------------------------------------------------------------------
#
title="Has gitignore (missing), up to date, different name"
#
section=$((section + 1))
boxedHeading "$title"
logFile=$section.log

assertDirectoryDoesNotExist bin/build

touch .gitignore
mv bin/pipeline/install-bin-build.sh bin/pipeline/we-like-head-rubs.sh

bin/pipeline/we-like-head-rubs.sh --mock "$buildHome/bin/build" >$logFile 2>&1

assertDirectoryExists bin/build

assertFileContains $logFile we-like-head-rubs.sh
assertFileDoesNotContain $logFile "install-bin-build.sh"

assertFileContains $logFile "is up to date"
assertFileDoesNotContain $logFile "was updated"

assertFileContains $logFile "does not ignore"
assertFileContains $logFile ".gitignore"

rm -rf bin/build

consoleSuccess Success, wanrnings were shown

# --------------------------------------------------------------------------------
#
title="Has gitignore (good), needs update, different name"
#
section=$((section + 1))
boxedHeading "$title"
logFile=$section.log

assertDirectoryDoesNotExist bin/build

echo "/bin/build/" >>.gitignore
bin/pipeline/we-like-head-rubs.sh --mock "$buildHome/bin/build" >$logFile 2>&1

assertDirectoryExists bin/build

assertFileContains $logFile we-like-head-rubs.sh
assertFileDoesNotContain $logFile "install-bin-build.sh"

assertFileContains $logFile "is up to date"
assertFileDoesNotContain $logFile "was updated"

assertFileDoesNotContain $logFile "does not ignore"
assertFileDoesNotContain $logFile ".gitignore"

rm -rf bin/build

consoleSuccess Success
