#!/usr/bin/env bash
#
# Amazon Web Services: s3
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__awsS3DirectoryDelete() {
  local handler="$1" && shift

  local urls=() aa=()
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --show) aa=(--dryrun) ;;
    *)
      isS3URL "$argument" || throwArgument "$handler" "Not a S3 URL: $argument" || return $?
      urls+=("$argument")
      ;;
    esac
    shift || usageArgumentMissing "$handler" "$argument" || return $?
  done
  [ ${#urls[@]} -gt 0 ] || throwArgument "$handler" "At least one URL is required" || return $?

  whichExists aws || catchEnvironment "$handler" awsInstall || return $?

  local url
  for url in "${urls[@]}"; do
    local path base bucket
    path=$(urlParseItem path "$url") || return $?
    bucket=$(urlParseItem host "$url") || return $?
    base=$(basename "$path")
    path=$(dirname "$path")
    catchEnvironment "$handler" aws s3 rm "s3://$bucket$path" --recursive "${aa[@]+"${aa[@]}"}" --exclude "*" --include "$base/*" || return $?
  done
}

__awsS3Upload() {
  local handler="$1" && shift

  local profileArgs=() target=""
  local uploadDirectories=() uploadFiles=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --target) shift && target="$(usageArgumentURL "$handler" "$argument" "${1-}")" || return $? ;;
    --profile)
      shift
      [ "${#profileArgs[@]}" -eq 0 ] || throwArgument "$handler" "Specified multiple profiles: ${profileArgs[*]} and ${1-}" || return $?
      profileArgs=(--profile "$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      decorate info "Using profile $argument"
      ;;
    *)
      if [ -d "$argument" ]; then
        uploadDirectories+=("$1")
      elif [ -f "$argument" ]; then
        uploadFiles+=("$1")
      else
        throwArgument "$handler" "\"$argument\" $(fileType "$argument") is not a file or directory" || return $?
      fi
      ;;
    esac
    shift || usageArgumentMissing "$handler" "$argument" || return $?
  done

  local start
  start=$(catchEnvironment "$handler" timingStart) || return $?

  whichExists aws || catchEnvironment "$handler" awsInstall || return $?

  [ -n "$target" ] || throwArgument "$handler" "--target required" || return $?
  if [ $((${#uploadFiles[@]} + ${#uploadDirectories[@]})) -eq 0 ]; then
    catchArgument "$handler" "No files or directories to upload" || rewturn $?
  fi

  if ! isS3URL "$target"; then
    throwArgument "$handler" "$target is not a valid S3 URL" || return $?
  fi

  target="${target%/}"

  local stagePath
  stagePath="$(catchEnvironment "$handler" buildCacheDirectory "./stage-results-$$")" || return $?
  catchEnvironment "$handler" directoryRequire "$stagePath" || return $?
  local clean=("$stagePath")

  local manifest="$stagePath/manifest.json"
  # Clean up after here
  local fileList=()
  catchEnvironment "$handler" printf "%s\n" "{}" >"$manifest" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" jsonFileSet "$manifest" ".hostname" "$(hostname)" || returnClean $? "${clean[@]}" || return $?
  fileList+=("manifest.json")

  catchEnvironment "$handler" jsonFileSet "$manifest" ".arguments" "${__saved[@]}" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" jsonFileSet "$manifest" ".created" "$(timingStart)" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" jsonFileSet "$manifest" ".createdString" "$(date)" || returnClean $? "${clean[@]}" || return $?

  local directory file relative
  for directory in ${uploadDirectories[@]+"${uploadDirectories[@]}"}; do
    while IFS= read -r -d '' file; do
      relative="${file#"$directory"}"
      relative="$(basename "$directory")${relative#/}"
      catchEnvironment "$handler" fileDirectoryRequire "$stagePath/$relative" || returnClean $? "${clean[@]}" || return $?
      catchEnvironment "$handler" cp "$file" "$stagePath/$relative" || returnClean $? "${clean[@]}" || return $?
      fileList+=("$relative")
    done < <(find "$directory" -type f)
  done
  for file in ${uploadFiles[@]+"${uploadFiles[@]}"}; do
    relative="$(basename "$file")"
    catchEnvironment "$handler" cp "$file" "$stagePath/$relative" || returnClean $? "${clean[@]}" || return $?
    fileList+=("$relative")
  done
  catchEnvironment "$handler" jsonFileSet "$manifest" ".files" "${fileList[@]}" || returnClean $? "${clean[@]}" || return $?
  fileList+=("files.json")
  printf "%s\n" "${fileList[@]}" | jq -r --raw-input '@json' | sort -u | jq --slurp >"$stagePath/files.json" || returnClean $? "${clean[@]}" || return $?

  catchEnvironment "$handler" aws "${profileArgs[@]+"${profileArgs[@]}"}" s3 sync --delete --quiet "$stagePath" "$target/" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
  statusMessage timingReport "$start" "$(decorate label "$(buildEnvironmentGet APPLICATION_NAME)") published $(pluralWord "${#fileList[@]}" items) to $(decorate value "$target")"
}
