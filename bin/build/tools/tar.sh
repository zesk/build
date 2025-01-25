#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/os.md
# Test: o ./test/tools/os-tests.sh

#
# Platform agnostic tar extract with wildcards
#
# e.g. `tar -xf '*/file.json'` or `tar -xf --wildcards '*/file.json'` depending on OS
#
# `tar` command is not cross-platform so this differentiates between the GNU and BSD command line arguments.
#
# Short description: Platform agnostic tar extract
# Usage: {fn} pattern
# Argument: pattern - The file pattern to extract
# stdin: A gzipped-tar file
# stdout: The desired file
tarExtractPattern() {
  local usage="_${FUNCNAME[0]}"

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        local pattern="$argument"
        shift || __throwArgument "No pattern supplied" || return $?
        # -h means follow symlinks
        if tar --version | grep -q GNU; then
          # GNU
          # > tar --version
          # tar (GNU tar) 1.34
          # ...
          tar -O -zx --wildcards "$pattern" "$@"
        else
          # BSD
          # > tar --version
          # bsdtar 3.5.3 - libarchive 3.5.3 zlib/1.2.11 liblzma/5.0.5 bz2lib/1.0.8
          tar -O -zx "$pattern" "$@"
        fi
        return 0
        ;;
    esac
  done
}
_tarExtractPattern() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Platform agnostic tar cfz which ignores owner and attributes
#
# `tar` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (`.tgz` or `.tar.gz`) with user and group set to 0 and no extended attributes attached to the files.
# Short description: Platform agnostic tar create which keeps user and group as user 0
# Usage: tarCreate target files
# Argument: target - The tar.gz file to create
# Argument: files - A list of files to include in the tar file
#
tarCreate() {
  local usage="_${FUNCNAME[0]}"

  local target=""

  [ $# -gt 0 ] || __throwArgument "$usage" "Need target and files" || return $?

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        target="$argument"
        shift || __throwArgument "No files supplied" || return $?
        # -h means follow symlinks
        if tar --version | grep -q GNU; then
          # GNU
          # > tar --version
          # tar (GNU tar) 1.34
          # ...
          tar -czf "$target" --owner=0 --group=0 --no-xattrs -h "$@"
        else
          # BSD
          # > tar --version
          # bsdtar 3.5.3 - libarchive 3.5.3 zlib/1.2.11 liblzma/5.0.5 bz2lib/1.0.8
          tar -czf "$target" --uid 0 --gid 0 --no-acls --no-fflags --no-xattrs -h "$@"
        fi
        return 0
        ;;
    esac
  done
}
_tarCreate() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
