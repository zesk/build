#!/usr/bin/env bash
#
# s3-tests.sh
#
# AWS S3 tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__dataIsS3URL() {
  cat <<EOF
0 s3://foo/bar
1 s4://bar/foo
1 https://www.example.com/
0 s3://a
EOF
}
testIsS3URL() {
  local result testString
  while read -r result testString; do
    assertExitCode "$result" isS3URL "$testString" || return $?
  done < <(__dataIsS3URL)
}

# Tag: package-install
testAWSS3Upload() {
  local handler="returnMessage"
  local target

  assertExitCode 0 awsInstall || return $?

  target=$(buildEnvironmentGet TEST_RESULTS_TEST_TARGET) || return 0
  [ -n "$target" ] || throwEnvironment "$handler" "No TEST_RESULTS_TEST_TARGET required for ${FUNCNAME[0]}" || return $?
  target="${target%/}"

  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  assertExitCode 0 awsS3Upload --target "$target" "$home/bin/build/build.json" "$home/bitbucket-pipelines.yml" "$home/README.md" "$home/etc" || return $?

  local checkFile
  checkFile=$(fileTemporaryName "$handler") || return $?
  catchEnvironment "$handler" aws s3 cp "$target/manifest.json" "$checkFile" || return $?

  assertFileContains "$checkFile" "createdString" "$home/bin/build/build.json" "$home/bitbucket-pipelines.yml" "$home/README.md" "$home/etc" || return $?

  assertExitCode --stdout-match "manifest.json" --stdout-match "README.md" 0 awsS3DirectoryDelete --show "$target" || return $?
  assertExitCode 0 awsS3DirectoryDelete "$target" || return $?

  assertNotExitCode --stderr-ok 0 aws s3 cp "$target/manifest.json" "$checkFile" || return $?

  catchEnvironment "$handler" rm -f "$checkFile" || return $?
}
