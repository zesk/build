#!/usr/bin/env bash
#
# xml.sh XML Formatting
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/xml.md
# Test: ./test/tools/xml.sh

# Prints the `<?xml` header for XML files
# stdout: String. XML header
__xmlHeader() {
  printf "%s%s%s\n" "<?xml" "$(__xmlAttributes "$@" "version=1.0" "encoding=UTF-8")" "?>"
}

# Output am XML single tag
# Argument: name - String. Required. Tag name.
# Argument: ... - Arguments. Optional. Attributes to output within the tag in name/value pairs as `name=value`
# stdout: String. XML single tag
__xmlTag() {
  local name="$1" && shift
  printf -- "<%s%s />\n" "$name" "$(__xmlAttributes "$@")"
}

# Output am XML open tag
# Argument: name - String. Required. Tag name.
# Argument: ... - Arguments. Optional. Attributes to output within the tag in name/value pairs as `name=value`
# stdout: String. XML tag open
__xmlTagOpen() {
  local name="$1" && shift
  printf -- "<%s%s>\n" "$name" "$(__xmlAttributes "$@")"
}

# Output am XML close tag
# Argument: name - String. Required. Tag name.
# stdout: String. XML tag close
__xmlTagClose() {
  local name="$1" && shift
  printf -- "</%s>\n" "$name"
}

# Output an XML attribute value with proper quoting
# Argument: value - EmptyString. Optional.
# stdout: String. XML attribute value
__xmlAttributeValue() {
  while [ $# -gt 0 ]; do
    local value="$1"
    value=${value//&/&amp;}
    value=${value//\"/&quot;}
    printf -- "%s\n" "$value"
    shift
  done
}

# Output XML attributes
# Argument: nameValue - String. Optional. One or more name/value pairs in the form `name=value` where the delimiter is an equals sign `=` and the value is *unquoted*.
# Beware of Bash quoting rules when passing in values
# stdout: String. XML attribute values formatted on a single line with a leading space
__xmlAttributes() {
  local attr=() found=()
  while [ $# -gt 0 ]; do
    case "$1" in
    "") ;;
    *=*)
      local name value="$1"
      name="${value%%=*}"
      value="${value#*=}"
      if [ ${#found[@]} -eq 0 ] || ! inArray "$name" "${found[@]}"; then
        found+=("$name")
        [ -z "$value" ] || name="$(printf -- "%s=%s" "$name" "\"$(__xmlAttributeValue "$value")")\""
        attr+=("$name")
      fi
      ;;
    *)
      if [ ${#found[@]} -eq 0 ] || ! inArray "$1" "${found[@]}"; then
        attr+=("$1") && found+=("$1")
      fi
      ;;
    esac
    shift
  done
  [ ${#attr[@]} -eq 0 ] || printf -- " %s" "${attr[*]-}"
}
