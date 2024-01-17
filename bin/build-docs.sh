#!/bin/bash
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
#

set -eou pipefail

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

cd "$(dirname "${BASH_SOURCE[0]}")/.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# fn: {base}
# Build documentation for build system.
#
# Given that bash is a terrible template language, caching is sort of mandatory if you
# want builds which do not take eons.
#
# Uses a cache at `buildCacheDirectory build-docs`
#
# You can disable this with `--no-cache`.
#
# Argument: --force - Force generation, ignore cache directives
# Argument: --no-cache - Do not use cache or store cache.
# Argument: --help - I need somebody
# TODO: Stop complaining about bash
buildBuildDocumentation() {
  local cacheDirectory theDirectory start documentDirectoryArgs cacheDirectoryArgs

  start=$(beginTiming)

  cacheDirectory="$(buildCacheDirectory build-docs)"
  # Default option settings
  documentDirectoryArgs=()
  cacheDirectoryArgs=("$cacheDirectory")
  while [ $# -gt 0 ]; do
    case $1 in
      --no-cache)
        cacheDirectoryArgs=()
        ;;
      --force)
        if ! inArray "$1" "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}"; then
          documentDirectoryArgs+=("$1")
        fi
        ;;
      --help)
        _buildBuildDocumentationUsage 0
        ;;
      *)
        _buildBuildDocumentationUsage "$errorArgument" "Unknown argument $1"
        ;;
    esac
    shift
  done

  if [ "${#cacheDirectoryArgs[@]}" -gt 0 ] && ! requireDirectory "$cacheDirectory"; then
    return $errorEnvironment
  fi
  if ! documentFunctionTemplateDirectory "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}" \
    ./bin/ ./docs/_templates/hooks/ ./docs/_templates/__hook.md ./docs/hooks/ "${cacheDirectoryArgs[@]+${cacheDirectoryArgs[@]}}"; then
    return "$errorEnvironment"
  fi
  for theDirectory in bin install pipeline; do
    if ! documentFunctionTemplateDirectory "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}" \
      ./bin/build/ ./docs/_templates/$theDirectory/ ./docs/_templates/__binary.md ./docs/$theDirectory/ "${cacheDirectoryArgs[@]+${cacheDirectoryArgs[@]}}"; then
      return $errorEnvironment
    fi
  done
  for theDirectory in ops tools; do
    if ! documentFunctionTemplateDirectory "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}" \
      ./bin/build/ ./docs/_templates/$theDirectory/ ./docs/_templates/__function.md ./docs/$theDirectory/ "${cacheDirectoryArgs[@]+${cacheDirectoryArgs[@]}}"; then
      return $errorEnvironment
    fi
  done
  reportTiming "$start" "Completed in"
}

#
# 2023-11-22 This file layout is easier to follow and puts the documentation at top, try and do this more
#

#
# Output _buildBuildDocumentationUsage and exit
#
_buildBuildDocumentationUsage() {
  usageDocument "./bin/$(basename "${BASH_SOURCE[0]}")" "buildBuildDocumentation" "$@"
  exit $?
}

buildBuildDocumentation "$@"
