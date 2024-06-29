#!/usr/bin/env bash
#
# deploy-tests.sh
#
# Deploy tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
declare -a tests

__prepareSampleApplicationDeployment() {
  local target="$1"
  local id="$2"

  export BUILD_HOME

  __environment buildEnvironmentLoad BUILD_HOME || return $?

  __environment mkdir -p "$target/app" || return $?
  __environment cd "$BUILD_HOME/test/example/simple-php" || return $?
  __environment mkdir ".deploy" || return $?
  printf "%s\n" "$id" >".deploy/APPLICATION_ID" || return $?
  __environment createTarFile "$target/app.tar.gz" .webApplication bin docs public src simple.application.php .env .deploy || return $?
  __environment rm -rf ".deploy" || return $?
  __environment cd "$target/app" || return $?

  # Mock deployment
  __environment tar zxf "$target/app.tar.gz" || return $?
}

tests+=(testDeployRemoteFinish)
testDeployRemoteFinish() {
  local tempDirectory id oldId matches finishArgs

  export BUILD_HOME

  __environment buildEnvironmentLoad BUILD_HOME || return $?

  id=abcdef
  tempDirectory=$(mktemp -d) || __failEnvironment mktemp || return $?

  printf "%s %s\n" "$(consoleSuccess "testDeployRemoteFinish:")" "$(consoleCode "$tempDirectory")"

  __environment mkdir -p "$tempDirectory/app" || return $?
  __environment mkdir -p "$tempDirectory/deploy" || return $?

  matches=(--stderr-match "need --first")
  assertExitCode "${matches[@]+${matches[@]}}" 1 deployRemoteFinish "--deploy" "--target" "app.tar.gz" "--home" "$tempDirectory/deploy" "--id" "$id" "--application" "$tempDirectory/app" || return $?

  matches=(--stderr-match 'Missing target file')
  assertExitCode "${matches[@]+${matches[@]}}" 1 deployRemoteFinish --first "--deploy" "--target" "app.tar.gz" "--home" "$tempDirectory/deploy" "--id" "$id" "--application" "$tempDirectory/app" || return $?

  # $id-stage vs $id produces 'tar file' error
  clearLine
  __prepareSampleApplicationDeployment "$tempDirectory/deploy/$id" "$id-stage"
  matches=(--stderr-match 'tar file is likely incorrect')
  finishArgs=(
    --first "--deploy"
    "--target" "app.tar.gz"
    "--home" "$tempDirectory/deploy"
    "--id" "$id"
    "--application" "$tempDirectory/app"
  )
  #  consoleInfo deployRemoteFinish "${finishArgs[@]}"
  #  consoleMagenta "$(echoBar)"
  #  deployRemoteFinish "${finishArgs[@]}"
  #  consoleError "Exit code: $?"
  assertExitCode --dump "${matches[@]+${matches[@]}}" 1 deployRemoteFinish "${finishArgs[@]}" || return $?

  __prepareSampleApplicationDeployment "$tempDirectory/deploy/$id" "$id"
  __environment mkdir -p "$tempDirectory/app" || return $?
  matches=(--stderr-match "should be a link")
  assertExitCode "${matches[@]+${matches[@]}}" 1 deployRemoteFinish --first "--deploy" "--target" "app.tar.gz" "--home" "$tempDirectory/deploy" "--id" "$id" "--application" "$tempDirectory/app" || return $?

  __environment __prepareSampleApplicationDeployment "$tempDirectory/deploy/$id" "$id" || return $?
  __environment rm -rf "$tempDirectory/app" || return $?

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
  __environment __prepareSampleApplicationDeployment "$tempDirectory/deploy/$id" "$id" || return $?

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
  printf "%s %s\n" "$(consoleBoldMagenta "APP points to")" "$(consoleCode)"

  find "$tempDirectory" -type d -or -type l -or -name '*.env' | dumpPipe "$id Reverted to $oldId"

  #
  # --deploy again
  #
  matches=(--stdout-match "Remote deployment finished")
  assertExitCode --dump "${matches[@]+${matches[@]}}" 0 deployRemoteFinish "--deploy" "--target" "app.tar.gz" "--home" "$tempDirectory/deploy" "--id" "$id" "--application" "$tempDirectory/app" || return $?
  assertEquals "$tempDirectory/deploy/$id/app" "$(readlink "$tempDirectory/app")" || return $?
  assertExitCode 0 test -L "$tempDirectory/app" || return $?

  unset BUILD_DEBUG_LINES
}

tests+=(testDeployToRemote)
testDeployToRemote() {
  local args matches
  local sampleHome sampleId sampleApplication onlyOne

  sampleHome=/var/DEPLOY
  sampleApplication=/var/app
  sampleId=abcdef

  args=(--commands --id "$sampleId" --home "$sampleHome" --application "$sampleApplication" www-data@remote0)
  {
    matches=(--stdout-match "$sampleId" --stdout-match Sweeping --stdout-match deployRemoteFinish --stdout-match printf --stdout-no-match "Deploy Home")
    assertExitCode "${matches[@]}" 0 deployToRemote "${args[@]}" || return $?

    matches=(--stdout-match "deployRemoteFinish" --stdout-match "--revert" --stdout-match "tools.sh")
    assertExitCode --dump "${matches[@]}" 0 deployToRemote --revert "${args[@]}" || return $?

    matches=(--stdout-match "deployRemoteFinish" --stdout-match "--cleanup" --stdout-match "tools.sh")
    assertExitCode --dump "${matches[@]}" 0 deployToRemote --cleanup "${args[@]}" || return $?
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

}

tests=(testDeployBuildEnvironment "${tests[@]}")
testDeployBuildEnvironment() {
  local d args matches
  local sampleHome sampleId sampleApplication

  # Important to clear these
  # For tests which depend on export environments make sure to reset THOSE glboals at start of test
  # Should likely clear test environment somehow
  export APPLICATION_ID DEPLOY_REMOTE_PATH APPLICATION_REMOTE_PATH DEPLOY_USER_HOSTS BUILD_TARGET
  unset APPLICATION_ID DEPLOY_REMOTE_PATH APPLICATION_REMOTE_PATH DEPLOY_USER_HOSTS BUILD_TARGET

  d=$(mktemp -d)
  __environment pushd "$d" >/dev/null || return $?

  assertExitCode --stderr-match "blank" 2 deployBuildEnvironment --id || return $?

  assertExitCode --stdout-match "deployBuildEnvironment" 0 deployBuildEnvironment --help || return $?

  assertExitCode --stderr-match "blank" 2 deployBuildEnvironment "" --id || return $?

  assertExitCode --stderr-match "APPLICATION_ID" 2 deployBuildEnvironment || return $?

  sampleHome=/var/DEPLOY
  sampleApplication=/var/app
  sampleId=abcdef

  args=(--id "$sampleId")
  matches=(--stderr-match home --stderr-match non-blank --stderr-match "DEPLOY_REMOTE_PATH")
  assertExitCode "${matches[@]}" 2 deployBuildEnvironment "${args[@]}" || return $?
  APPLICATION_ID="$sampleId" assertExitCode "${matches[@]}" 2 deployBuildEnvironment || return $?

  args=(--id "$sampleId" --home "$sampleHome")
  matches=(--stderr-match home --stderr-match non-blank --stderr-match "APPLICATION_REMOTE_PATH")
  assertExitCode "${matches[@]}" 2 deployBuildEnvironment "${args[@]}" || return $?
  DEPLOY_REMOTE_PATH="$sampleHome" APPLICATION_ID="$sampleId" assertExitCode "${matches[@]}" 2 deployBuildEnvironment || return $?

  args=(--id "$sampleId" --home "$sampleHome" --application "$sampleApplication")
  matches=(--stderr-match "user hosts" --stderr-match "DEPLOY_USER_HOSTS")
  assertExitCode "${matches[@]}" 2 deployBuildEnvironment "${args[@]}" || return $?
  APPLICATION_REMOTE_PATH="$sampleApplication" DEPLOY_REMOTE_PATH="$sampleHome" APPLICATION_ID="$sampleId" assertExitCode "${matches[@]}" 2 deployBuildEnvironment || return $?

  # this is the point we WOULD succeed but instead just run the dry run which outputs the script which can be used to
  # generate the other tests
  args=(--id "$sampleId" --home "$sampleHome" --application "$sampleApplication" --host "www-data@remote0" --host "www-data@remote1")
  matches=(--stderr-match ".build.env")
  assertExitCode "${matches[@]}" 0 deployBuildEnvironment --dry-run "${args[@]}" || return $?
  deployBuildEnvironment --dry-run "${args[@]}"

  DEPLOY_USER_HOSTS="www-data@remote0 www-data@remote1" APPLICATION_REMOTE_PATH="$sampleApplication" DEPLOY_REMOTE_PATH="$sampleHome" APPLICATION_ID="$sampleId" \
    assertExitCode --dump "${matches[@]}" 0 deployBuildEnvironment --dry-run || return $?

  rm -rf "$d" || :
  unset APPLICATION_ID DEPLOY_REMOTE_PATH APPLICATION_REMOTE_PATH DEPLOY_USER_HOSTS BUILD_TARGET
}
