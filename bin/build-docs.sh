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
# Given that bash is not an ideal template language, caching is mandatory.
#
# Uses a cache at `buildCacheDirectory build-docs`
#
# You can disable this with `--no-cache`.
#
# Argument: --force - Force generation, ignore cache directives
# Argument: --no-cache - Do not use cache or store cache.
# Argument: --help - I need somebody
buildBuildDocumentation() {
  local cacheDirectory theDirectory start documentDirectoryArgs indexArgs=()
  local functionLinkPattern fileLinkPattern
  start=$(beginTiming)

  cacheDirectory="$(buildCacheDirectory)"
  # Default option settings
  documentDirectoryArgs=()
  while [ $# -gt 0 ]; do
    case $1 in
      --no-cache)
        indexArgs+=(--clean)
        ;;
      --force)
        if ! inArray "$1" "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}"; then
          documentDirectoryArgs+=("$1")
        fi
        ;;
      --help)
        _buildBuildDocumentationUsage 0
        return $?
        ;;
      *)
        _buildBuildDocumentationUsage "$errorArgument" "Unknown argument $1"
        return $?
        ;;
    esac
    shift
  done
  if ! cacheDirectory=$(requireDirectory "$cacheDirectory"); then
    return $errorEnvironment
  fi
  if ! documentationFunctionIndex "${indexArgs[@]+${indexArgs[@]}}" ./bin/ "$(requireDirectory "$cacheDirectory")"; then
    return $errorEnvironment
  fi
  if ! documentFunctionTemplateDirectory "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}" \
    "$cacheDirectory" ./docs/_templates/hooks/ ./docs/_templates/__hook.md ./docs/hooks/; then
    return "$errorEnvironment"
  fi
  for theDirectory in bin install pipeline; do
    if ! documentFunctionTemplateDirectory "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}" \
      "$cacheDirectory" ./docs/_templates/$theDirectory/ ./docs/_templates/__binary.md ./docs/$theDirectory/; then
      return $errorEnvironment
    fi
  done
  for theDirectory in ops tools; do
    if ! documentFunctionTemplateDirectory "${documentDirectoryArgs[@]+${documentDirectoryArgs[@]}}" \
      "$cacheDirectory" ./docs/_templates/$theDirectory/ ./docs/_templates/__function.md ./docs/$theDirectory/; then
      return $errorEnvironment
    fi
  done
  (
    # shellcheck source=/dev/null
    source "$(dirname "${BASH_SOURCE[0]}")/build/env/BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN.sh"
    functionLinkPattern=${BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN-}
    # Remove line
    fileLinkPattern=${functionLinkPattern%%#.*}
    documentationFunctionSeeLinker "$cacheDirectory" "./docs" ./docs/_templates/__seeFunction.md "$functionLinkPattern" ./docs/_templates/__seeFile.md "$fileLinkPattern"
  )
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
  return $?
}

buildBuildDocumentation "$@"
