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

#
# Usage: {fn} cacheDirectory envFile
# Argument: cacheDirectory - Required. Directory. Cache directory.
# Argument: envFile - Required. File. Environment file used as base environment for all template generation.
#
buildDocsUpdateUnlinked() {
  local cacheDirectory=$1
  local envFile=$2
  local unlinkedFunctions template total

  shift || ::
  if ! unlinkedFunctions=$(mktemp); then
    consoleError "Unable to create temporary file" 1>&2
    return $errorEnvironment
  fi
  template="./docs/_templates/tools/todo.md"
  if ! documentationIndex_SetUnlinkedDocumentationPath "$cacheDirectory" "./docs/tools/todo.md" | IFS="" awk '{ print "{" $1 "}" }' >"$unlinkedFunctions"; then
    consoleError "Unable to documentationIndex_SetUnlinkedDocumentationPath" 1>&2
    return $errorEnvironment
  fi
  (
    set -a
    # shellcheck source=/dev/null
    . "$envFile"
    title="Missing functions" content="$(cat "./docs/_templates/__todo.md")\n\n$(sort <"$unlinkedFunctions")" mapEnvironment <"./docs/_templates/__main1.md" >"$template.$$"
  )
  total=$(wc -l <"$unlinkedFunctions" | trimSpacePipe)
  if diff -q "$template" "$template.$$"; then
    statusMessage consoleInfo "Not updating $template - unchanged $(plural "$total" function functions)"
    if ! rm "$template.$$"; then
      consoleError "Unable to delete $template.$$" 1>&2
      return $errorEnvironment
    fi
  else
    cp "$template.$$" "$template"
    statusMessage consoleInfo "Updated $template with $total unlinked $(plural "$total" function functions)"
  fi
  rm -f "$unlinkedFunctions" 2>/dev/null || :
}

# fn: {base}
# Build documentation for build system.
#
# Given that bash is not an ideal template language, caching is mandatory.
#
# Uses a cache at `buildCacheDirectory`
#
# Argument: --force - Force generation, ignore cache directives
# Argument: --unlinked - Show unlinked functions
# Argument: --unlinked-update - Update unlinked document file
# Argument: --clean - Erase the cache before starting.
# Argument: --help - I need somebody
# Artifact: `cacheDirectory` may be created even on non-zero exit code
# Exit Code: 0 - Success
# Exit Code: 1 - Issue with environment
# Exit Code: 2 - Argument error
buildDocsBuild() {
  local cacheDirectory theDirectory start docArgs indexArgs=()
  local functionLinkPattern fileLinkPattern documentTemplate templateDirectory
  local start envFile exitCode

  exitCode=0
  start=$(beginTiming)

  cacheDirectory="$(buildCacheDirectory)"

  # shellcheck source=/dev/null
  . ./bin/build/env/BUILD_COMPANY.sh

  # shellcheck source=/dev/null
  . ./bin/build/env/BUILD_COMPANY_LINK.sh

  docArgs=()
  envFile=$(mktemp)
  {
    __dumpNameValue summary "{fn}"
    __dumpNameValue vendor "$BUILD_COMPANY"
    __dumpNameValue BUILD_COMPANY "$BUILD_COMPANY"
    __dumpNameValue vendorLink "$BUILD_COMPANY_LINK"
    __dumpNameValue BUILD_COMPANY_LINK "$BUILD_COMPANY_LINK"

    __dumpNameValue year "$(date +%Y)"
  } >>"$envFile"
  docArgs+=(--env "$envFile")

  # Default option settings
  while [ $# -gt 0 ]; do
    case $1 in
      --clean)
        indexArgs+=("$1")
        ;;
      --unlinked)
        if ! documentationIndex_ShowUnlinked "$cacheDirectory"; then
          exitCode=$?
        fi
        rm -f "$envFile" 2>/dev/null || :
        return $exitCode
        ;;
      --unlinked-update)
        if ! buildDocsUpdateUnlinked "$cacheDirectory" "$envFile"; then
          exitCode=$?
        fi
        printf "\n"
        rm -f "$envFile" 2>/dev/null || :
        return $exitCode
        ;;
      --force)
        if ! inArray "$1" "${docArgs[@]}"; then
          docArgs+=("$1")
        fi
        ;;
      --help)
        _buildDocsBuildUsage 0
        return $?
        ;;
      *)
        _buildDocsBuildUsage "$errorArgument" "Unknown argument $1"
        return $?
        ;;
    esac
    shift
  done
  if ! cacheDirectory=$(requireDirectory "$cacheDirectory"); then
    rm -f "$envFile" 2>/dev/null || :
    return $errorEnvironment
  fi

  if ! cacheDirectory="$(requireDirectory "$cacheDirectory")"; then
    return $?
  fi
  #
  # Generate or update indexes
  #
  if ! documentationIndex_Generate "${indexArgs[@]+${indexArgs[@]}}" ./bin/ "$cacheDirectory"; then
    consoleError "documentationIndex_Generate failed" 1>&2
    rm -f "$envFile" 2>/dev/null || :
    return $errorEnvironment
  fi
  #
  # Update indexes with function -> documentationPath
  #
  templateDirectory=./docs/_templates
  find "$templateDirectory" -type f -name '*.md' ! -path '*/__*' | while read -r documentTemplate; do
    if ! documentationIndex_LinkDocumentationPaths "$cacheDirectory" "$documentTemplate" "./docs${documentTemplate#"$templateDirectory"}"; then
      return $?
    fi
  done
  clearLine
  reportTiming "$start" "Indexes completed in"

  #
  # Build docs
  #

  # Update unlinked document
  if ! buildDocsUpdateUnlinked "$cacheDirectory" "$envFile"; then
    consoleError "buildDocsUpdateUnlinked failed" 1>&2
    return $?
  fi
  clearLine

  if ! documentationTemplateDirectoryCompile "${docArgs[@]}" \
    "$cacheDirectory" ./docs/_templates/hooks/ ./docs/_templates/__hook.md ./docs/hooks/; then
    rm "$envFile" || :
    return "$errorEnvironment"
  fi
  for theDirectory in bin install pipeline; do
    if ! documentationTemplateDirectoryCompile "${docArgs[@]}" \
      "$cacheDirectory" ./docs/_templates/$theDirectory/ ./docs/_templates/__binary.md ./docs/$theDirectory/; then
      rm "$envFile" || :
      return $errorEnvironment
    fi
  done
  for theDirectory in ops tools; do
    if ! documentationTemplateDirectoryCompile "${docArgs[@]}" \
      "$cacheDirectory" ./docs/_templates/$theDirectory/ ./docs/_templates/__function.md ./docs/$theDirectory/; then
      rm "$envFile" || :
      return $errorEnvironment
    fi
  done
  #
  # {SEE:foo} gets linked in final documentation where it exists (rewrites file currently)
  #
  (
    # shellcheck source=/dev/null
    source "$(dirname "${BASH_SOURCE[0]}")/build/env/BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN.sh"
    functionLinkPattern=${BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN-}
    # Remove line
    fileLinkPattern=${functionLinkPattern%%#.*}
    documentationIndex_SeeLinker "$cacheDirectory" "./docs" ./docs/_templates/__seeFunction.md "$functionLinkPattern" ./docs/_templates/__seeFile.md "$fileLinkPattern"
  )
  reportTiming "$start" "Completed in"
}

#
# 2023-11-22 This file layout is easier to follow and puts the documentation at top, try and do this more
#

# Output _buildDocsBuildUsage and exit
# Ignore: Usage
_buildDocsBuildUsage() {
  usageDocument "./bin/$(basename "${BASH_SOURCE[0]}")" "buildDocsBuild" "$@"
  return $?
}

buildDocsBuild "$@"
