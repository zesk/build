#!/usr/bin/env bash
#
# Checking identical
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# In case you forgot, the directory in which this file is named `_identical` and *NOT* `identical`.
#
# This is to avoid having this match when doing `identicalRepair` - causes issues.
#
# Thanks for your consideration.

#
# Identical check for shell files
#
# Looks for up to three tokens in code:
#
# - `# ``IDENTICAL tokenName 1`
# - `# ``_IDENTICAL_ tokenName 1`, and
# - `# ``DOC TEMPLATE: tokenName 1`
#
# This allows for overlapping identical sections within templates with the intent:
#
# - `IDENTICAL` - used in most cases (not internal)
# - `_IDENTICAL_` - used in templates which must be included in IDENTICAL templates (INTERNAL)
# - `__IDENTICAL__` - used in templates which must be included in _IDENTICAL_ templates (INTERNAL)
# - `DOC TEMPLATE:` - used in documentation templates for functions - is handled by internal document generator (INTERNAL)
#
# Usage: {fn} [ --repair repairSource ] [ --help ] [ --interactive ] [ --check checkDirectory ] ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --singles singlesFiles - Optional. File. One or more files which contain a list of allowed `IDENTICAL` singles, one per line.
# Argument: --single singleToken - Optional. String. One or more tokens which cam be singles.
# Argument: --repair directory - Optional. Directory. Any files in onr or more directories can be used to repair other files.
# Argument: --internal - Flag. Optional. Do updates for `# _IDENTICAL_` and `# DOC TEMPLATE:` prefixes first.
# Argument: --internal-only - Flag. Optional. Just do `--internal` repairs.
# Argument: --interactive - Flag. Optional. Interactive mode on fixing errors.
# Argument: ... - Optional. Additional arguments are passed directly to `identicalCheck`.
identicalCheckShell() {
  local usage="_${FUNCNAME[0]}"
  local argument aa=() pp=() addDefaultPrefixes=true

  local internalPrefixes=(--prefix '# ''DOC TEMPLATE:' --prefix '# ''__IDENTICAL__' --prefix '# ''_IDENTICAL_')

  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
    --internal-only)
      pp=("${internalPrefixes[@]}")
      addDefaultPrefixes=false
      ;;
    --internal)
      if [ "${#pp[@]}" -eq 0 ]; then
        # Ordering here matters so declare from inside scope to outside scope
        pp=("${internalPrefixes[@]}")
      fi
      ;;
    --interactive | --ignore-singles | --no-map | --watch | --debug | --verbose)
      aa+=("$argument")
      ;;
    --repair | --single | --exec | --prefix | --exclude | --extension | --skip | --singles | --cd)
      shift
      aa+=("$argument" "${1-}")
      ;;
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    *)
      break
      ;;
    esac
    shift || :
  done
  ! $addDefaultPrefixes || pp+=(--prefix '# ''IDENTICAL')
  __catch "$usage" identicalCheck "${aa[@]+"${aa[@]}"}" "${pp[@]}" --extension sh "$@" || return $?
}
_identicalCheckShell() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
