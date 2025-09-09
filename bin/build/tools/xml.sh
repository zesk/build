#!/usr/bin/env bash
#
# xml.sh XML Formatting
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/xml.md
# Test: ./test/tools/xml.sh

# Prints the `<?xml` header for XML files
__xmlHeader() {
  printf "%s%s%s\n" "<?xml" "$(__xmlAttributes "$@" "version=1.0" encoding=UTF-8)" "?>"
}
__xmlTag() {
  local name="$1" && shift
  printf -- "<%s%s />\n" "$name" "$(__xmlAttributes "$@")"
}
__xmlTagOpen() {
  local name="$1" && shift
  printf -- "<%s%s>\n" "$name" "$(__xmlAttributes "$@")"
}
__xmlTagClose() {
  local name="$1" && shift
  printf -- "</%s>\n" "$name"
}

__xmlAttributeValue() {
  while [ $# -gt 0 ]; do
    local value="$1"
    value=${value//&/&amp;}
    value=${value//\"/&quot;}
    printf "%s\n" "$value"
    shift
  done
}

# Output XML attributes
# Argument: nameValue - String. Optional. A name/value pair in the form `name=value` where the delimiter is an equals sign `=` and the value is *unquoted*.
# Beware of Bash quoting rules when passing in values
__xmlAttributes() {
  local attr=() found=()
  while [ $# -gt 0 ]; do
    local name value
    IFS="=" read -r name value <<<"$1" || :
    [ -n "$name" ] || continue
    [ ${#found[@]} -eq 0 ] || ! inArray "$name" "${found[@]}" || continue
    [ -z "$value" ] || name="$(printf -- "%s=%s" "$name" "\"$(__xmlAttributeValue "$value")")\""
    attr+=("$name")
    shift
  done
  [ ${#attr[@]} -eq 0 ] || printf -- " %s" "${attr[*]-}"
}
