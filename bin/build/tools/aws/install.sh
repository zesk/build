#!/usr/bin/env bash
#
# Amazon Web Services: awsInstall
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__awsInstall() {
  local handler="$1" && shift

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  if whichExists aws; then
    return 0
  fi

  if isAlpine; then
    packageInstall aws-cli || return $?
    return 0
  fi

  local start
  start=$(timingStart) || return $?
  catchReturn "$handler" packageWhich unzip unzip || return $?

  local url
  statusMessage decorate info "Installing aws-cli ... " || :
  case "${HOSTTYPE-}" in
  arm64 | aarch64)
    url="https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip"
    ;;
  *)
    url="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
    ;;
  esac
  {
    local buildDir quietLog clean=()
    buildDir="$(catchReturn "$handler" buildCacheDirectory awsCache.$$)" || return $?
    clean+=("$buildDir")
    quietLog="$(catchReturn "$handler" buildQuietLog awsInstall)" || returnClean $? "${clean[@]}" || return $?
    clean+=("$quietLog")
    buildDir=$(catchReturn "$handler" directoryRequire "$buildDir") || returnClean $? "${clean[@]}" || return $?
    clean+=("$buildDir")

    local zipFile=awscliv2.zip version
    catchEnvironmentQuiet "$handler" "$quietLog" urlFetch "$url" "$buildDir/$zipFile" || returnClean $? "${clean[@]}" || return $?
    catchEnvironmentQuiet "$handler" "$quietLog" unzip -d "$buildDir" "$buildDir/$zipFile" || returnClean $? "${clean[@]}" || return $?
    catchEnvironmentQuiet "$handler" "$quietLog" "$buildDir/aws/install" || returnClean $? "${clean[@]}" || return $?
    version="$(catchReturn "$handler" __awsWrapper --version)" || returnClean $? "${clean[@]}" || return $?
    printf "%s %s\n" "$version" "$(timingReport "$start" OK)" || :
    catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
  }
}
