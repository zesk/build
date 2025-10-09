#!/usr/bin/env bash
#
# deploy-tests.sh
#
# Deploy tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__prepareSampleApplicationDeployment() {
  local handler="$1"
  local target="$2"
  local id="$3"

  export BUILD_HOME

  catchReturn "$handler" buildEnvironmentLoad BUILD_HOME || return $?

  local tempPath
  tempPath=$(fileTemporaryName "$handler" -d) || return $?
  catchReturn "$handler" directoryRequire "$target/app" || return $?
  local appRoot=$tempPath/simple-php
  catchEnvironment "$handler" cp -r "$BUILD_HOME/test/example/simple-php" "$appRoot" || return $?
  catchReturn "$handler" directoryRequire "$appRoot/.deploy" || return $?
  printf "%s\n" "$id" >"$appRoot/.deploy/APPLICATION_ID" || return $?
  catchReturn "$handler" directoryChange "$appRoot" tarCreate "$target/app.tar.gz" .webApplication bin docs public src simple.application.php .env .deploy || return $?
  catchEnvironment "$handler" rm -rf "$tempPath" || return $?

  # Mock deployment ?
  # catchEnvironment "$handler" tar zxf "$target/app.tar.gz" || return $?
}

#
# deployRemoteFinish
#
testDeployRemoteFinish() {
  local handler="returnMessage"

  mockEnvironmentStart BUILD_COLORS
  mockEnvironmentStart BUILD_DEBUG_LINES

  local tempDirectory id oldId matches finishArgs

  exec 2>&1
  export BUILD_HOME

  catchReturn "$handler" buildEnvironmentLoad BUILD_HOME || return $?

  id=abcdef
  tempDirectory=$(fileTemporaryName "$handler" -d) || return $?

  printf "%s %s\n" "$(decorate success "testDeployRemoteFinish:")" "$(decorate code "$tempDirectory")"

  catchEnvironment "$handler" mkdir -p "$tempDirectory/app" || return $?
  catchEnvironment "$handler" mkdir -p "$tempDirectory/deploy" || return $?

  matches=(--stderr-match "need --first")
  assertExitCode "${matches[@]+${matches[@]}}" 1 deployRemoteFinish "--deploy" "--target" "app.tar.gz" "--home" "$tempDirectory/deploy" "--id" "$id" "--application" "$tempDirectory/app" || return $?

  matches=(--stderr-match 'Missing target file')
  assertExitCode "${matches[@]+${matches[@]}}" 1 deployRemoteFinish --first "--deploy" "--target" "app.tar.gz" "--home" "$tempDirectory/deploy" "--id" "$id" "--application" "$tempDirectory/app" || return $?

  # $id-stage vs $id produces 'tar file' error
  clearLine
  __prepareSampleApplicationDeployment "$handler" "$tempDirectory/deploy/$id" "$id-stage"
  matches=(--stderr-match 'tar file is likely incorrect')
  finishArgs=(
    --first "--deploy"
    "--target" "app.tar.gz"
    "--home" "$tempDirectory/deploy"
    "--id" "$id"
    "--application" "$tempDirectory/app"
  )
  assertExitCode --dump "${matches[@]+${matches[@]}}" 1 deployRemoteFinish "${finishArgs[@]}" || return $?

  __prepareSampleApplicationDeployment "$handler" "$tempDirectory/deploy/$id" "$id"
  catchEnvironment "$handler" mkdir -p "$tempDirectory/app" || return $?
  matches=(--stderr-match "should be a link")
  assertExitCode "${matches[@]+${matches[@]}}" 1 deployRemoteFinish --first "--deploy" "--target" "app.tar.gz" "--home" "$tempDirectory/deploy" "--id" "$id" "--application" "$tempDirectory/app" || return $?

  __prepareSampleApplicationDeployment "$handler" "$tempDirectory/deploy/$id" "$id" || return $?
  catchEnvironment "$handler" rm -rf "$tempDirectory/app" || return $?

  #
  # --deploy abcdef
  #
  find "$tempDirectory" -type f -or -type d -or -type l | dumpPipe "Before DEPLOY"
  matches=(--stdout-match "Remote deployment finished")
  assertEquals "" "$(readlink "$tempDirectory/app" 2>/dev/null)" || return $?
  assertNotExitCode 0 test -f "$tempDirectory/app" || return $?
  assertExitCode --dump "${matches[@]+${matches[@]}}" 0 deployRemoteFinish --first "--deploy" "--target" "app.tar.gz" "--home" "$tempDirectory/deploy" "--id" "$id" "--application" "$tempDirectory/app" || return $?
  assertExitCode 0 test -L "$tempDirectory/app" || return $?
  assertEquals "$tempDirectory/deploy/$id/app" "$(readlink "$tempDirectory/app")" || return $?

  #
  # --cleanup
  #
  # works without --first?
  matches=(--stdout-match "Cleaning up")
  assertExitCode --dump "${matches[@]+${matches[@]}}" 0 deployRemoteFinish "--cleanup" "--target" "app.tar.gz" "--home" "$tempDirectory/deploy" "--id" "$id" "--application" "$tempDirectory/app" || return $?
  assertExitCode 0 test -L "$tempDirectory/app" || return $?
  assertEquals "$tempDirectory/deploy/$id/app" "$(readlink "$tempDirectory/app")" || return $?

  #
  # --deploy deadbeef
  #
  oldId=$id
  id=deadbeef
  __prepareSampleApplicationDeployment "$handler" "$tempDirectory/deploy/$id" "$id" || return $?

  matches=(--stdout-match "Remote deployment finished")
  assertExitCode --dump "${matches[@]+${matches[@]}}" 0 deployRemoteFinish "--deploy" "--target" "app.tar.gz" "--home" "$tempDirectory/deploy" "--id" "$id" "--application" "$tempDirectory/app" || return $?
  assertEquals "$tempDirectory/deploy/$id/app" "$(readlink "$tempDirectory/app")" || return $?
  assertExitCode 0 test -L "$tempDirectory/app" || return $?

  #
  # --cleanup
  #
  matches=(--stdout-match "Cleaning up")
  assertExitCode --dump "${matches[@]+${matches[@]}}" 0 deployRemoteFinish "--cleanup" "--target" "app.tar.gz" "--home" "$tempDirectory/deploy" "--id" "$id" "--application" "$tempDirectory/app" || return $?
  assertEquals "$tempDirectory/deploy/$id/app" "$(readlink "$tempDirectory/app")" || return $?
  assertExitCode 0 test -L "$tempDirectory/app" || return $?

  find "$tempDirectory" -type d -or -type l -or -name '*.env' | dumpPipe "$id Deployed"

  #
  # --revert
  #
  matches=(--stdout-match "reverted")
  assertExitCode --dump "${matches[@]+${matches[@]}}" 0 deployRemoteFinish "--revert" "--target" "app.tar.gz" "--home" "$tempDirectory/deploy" "--id" "$id" "--application" "$tempDirectory/app" || return $?
  assertEquals "$tempDirectory/deploy/$oldId/app" "$(readlink "$tempDirectory/app")" || return $?
  printf "%s %s\n" "$(decorate bold-magenta "APP points to")" "$(decorate code --)"

  find "$tempDirectory" -type d -or -type l -or -name '*.env' | dumpPipe "$id Reverted to $oldId"

  #
  # --deploy again
  #
  matches=(--stdout-match "Remote deployment finished")
  assertExitCode --dump "${matches[@]+${matches[@]}}" 0 deployRemoteFinish "--deploy" "--target" "app.tar.gz" "--home" "$tempDirectory/deploy" "--id" "$id" "--application" "$tempDirectory/app" || return $?
  assertEquals "$tempDirectory/deploy/$id/app" "$(readlink "$tempDirectory/app")" || return $?
  assertExitCode 0 test -L "$tempDirectory/app" || return $?

  catchEnvironment "$handler" rm -rf "$tempDirectory" || return $?

  mockEnvironmentStop BUILD_COLORS
  mockEnvironmentStop BUILD_DEBUG_LINES

  return 0
}

#
#
#
# deployToRemote
#

#
# Tag: slow
# Why slow?
testDeployToRemote() {
  local args matches
  local sampleHome sampleId sampleApplication onlyOne

  export BUILD_DEBUG

  BUILD_DEBUG=${BUILD_DEBUG-}

  sampleHome=/var/DEPLOY
  sampleApplication=/var/app
  sampleId=abcdef

  args=(--commands --id "$sampleId" --home "$sampleHome" --application "$sampleApplication" www-data@remote0)
  {
    matches=(--stdout-match "$sampleId" --stdout-match Sweeping --stdout-match deployRemoteFinish --stdout-match printf --stdout-no-match "Deploy Home")
    assertExitCode "${matches[@]}" 0 deployToRemote "${args[@]}" || return $?

    matches=(--stdout-match "deployRemoteFinish" --stdout-match "--revert" --stdout-match "tools.sh")
    assertExitCode "${matches[@]}" 0 deployToRemote --revert "${args[@]}" || return $?

    matches=(--stdout-match "deployRemoteFinish" --stdout-match "--cleanup" --stdout-match "tools.sh")
    assertExitCode "${matches[@]}" 0 deployToRemote --cleanup "${args[@]}" || return $?
  }

  matches=(--stderr-match twice)
  for onlyOne in --application --id --home --target; do
    args=("$onlyOne" "$sampleApplication" "$onlyOne" "$sampleApplication")
    assertExitCode "${matches[@]}" 2 deployToRemote "${args[@]}" || return $?
  done
  for onlyOne in --deploy --revert --cleanup; do
    args=("$onlyOne" "$onlyOne")
    assertExitCode "${matches[@]}" 2 deployToRemote "${args[@]}" || return $?
  done

  matches=(--stderr-match "mutually exclusive")

  args=("--revert" "--deploy")
  assertExitCode "${matches[@]}" 2 deployToRemote "${args[@]}" || return $?
  args=("--revert" "--deploy")
  assertExitCode "${matches[@]}" 2 deployToRemote "${args[@]}" || return $?
  args=("--revert" "--deploy")
  assertExitCode "${matches[@]}" 2 deployToRemote "${args[@]}" || return $?

  args=(--id "$sampleId" --application "$sampleApplication")
  matches=(--stderr-match "missing deployHome")
  assertExitCode "${matches[@]}" 2 deployToRemote "${args[@]}" || return $?

  args=(--home "$sampleHome" --application "$sampleApplication")
  matches=(--stderr-match "missing applicationId")
  assertExitCode "${matches[@]}" 2 deployToRemote "${args[@]}" || return $?

  args=(--id "$sampleId" --home "$sampleHome")
  matches=(--stderr-match "missing applicationPath")
  assertExitCode "${matches[@]}" 2 deployToRemote "${args[@]}" || return $?

  args=(--id "$sampleId" --home "$sampleHome" --application "$sampleApplication")
  matches=(--stderr-match "No user hosts")
  assertExitCode "${matches[@]}" 2 deployToRemote "${args[@]}" || return $?

  unset BUILD_DEBUG
}

#
#
#
# deployBuildEnvironment
#
#
# Tag: slow
testDeployBuildEnvironment() {
  local handler="returnMessage"

  local d args matches
  local sampleHome sampleId sampleApplication

  (
    # Important to clear these
    # For tests which depend on export environments make sure to reset THOSE globals at start of test
    # Should likely clear test environment somehow
    export APPLICATION_ID DEPLOY_REMOTE_HOME APPLICATION_REMOTE_HOME DEPLOY_USER_HOSTS BUILD_TARGET
    unset APPLICATION_ID DEPLOY_REMOTE_HOME APPLICATION_REMOTE_HOME DEPLOY_USER_HOSTS BUILD_TARGET

    d=$(fileTemporaryName "$handler" -d) || return $?
    catchEnvironment "$handler" pushd "$d" >/dev/null || return $?

    assertExitCode --stderr-match "blank" 2 deployBuildEnvironment --id || return $?

    assertExitCode --stdout-match "deployBuildEnvironment" 0 deployBuildEnvironment --help || return $?

    assertExitCode --stderr-match "blank" 2 deployBuildEnvironment "" --id || return $?

    assertExitCode --stderr-match "APPLICATION_ID" 2 deployBuildEnvironment || return $?

    sampleHome=/var/DEPLOY
    sampleApplication=/var/app
    sampleId=abcdef

    args=(--id "$sampleId")
    matches=(--stderr-match home --stderr-match non-blank --stderr-match "DEPLOY_REMOTE_HOME")
    assertExitCode "${matches[@]}" 2 deployBuildEnvironment "${args[@]}" || return $?
    APPLICATION_ID="$sampleId" assertExitCode "${matches[@]}" 2 deployBuildEnvironment || return $?

    args=(--id "$sampleId" --home "$sampleHome")
    matches=(--stderr-match home --stderr-match non-blank --stderr-match "APPLICATION_REMOTE_HOME")
    assertExitCode "${matches[@]}" 2 deployBuildEnvironment "${args[@]}" || return $?
    DEPLOY_REMOTE_HOME="$sampleHome" APPLICATION_ID="$sampleId" assertExitCode "${matches[@]}" 2 deployBuildEnvironment || return $?

    args=(--id "$sampleId" --home "$sampleHome" --application "$sampleApplication")
    matches=(--stderr-match "user hosts" --stderr-match "DEPLOY_USER_HOSTS")
    assertExitCode "${matches[@]}" 2 deployBuildEnvironment "${args[@]}" || return $?
    APPLICATION_REMOTE_HOME="$sampleApplication" DEPLOY_REMOTE_HOME="$sampleHome" APPLICATION_ID="$sampleId" assertExitCode "${matches[@]}" 2 deployBuildEnvironment || return $?

    # this is the point we WOULD succeed but instead just run the dry run which outputs the script which can be used to
    # generate the other tests
    args=(--id "$sampleId" --home "$sampleHome" --application "$sampleApplication" --host "www-data@remote0" --host "www-data@remote1")
    matches=(--stderr-match ".build.env")
    assertExitCode "${matches[@]}" 0 deployBuildEnvironment --dry-run "${args[@]}" || return $?

    DEPLOY_USER_HOSTS="www-data@remote0 www-data@remote1" \
      APPLICATION_REMOTE_HOME="$sampleApplication" \
      DEPLOY_REMOTE_HOME="$sampleHome" \
      APPLICATION_ID="$sampleId" assertExitCode "${matches[@]}" 0 deployBuildEnvironment --dry-run || return $?

    catchEnvironment "$handler" popd >/dev/null || return $?
    rm -rf "$d" || :

    export APPLICATION_ID DEPLOY_REMOTE_HOME APPLICATION_REMOTE_HOME DEPLOY_USER_HOSTS BUILD_TARGET
    unset APPLICATION_ID DEPLOY_REMOTE_HOME APPLICATION_REMOTE_HOME DEPLOY_USER_HOSTS BUILD_TARGET
  ) || return $?
}
