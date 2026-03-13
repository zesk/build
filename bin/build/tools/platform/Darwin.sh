#!/usr/bin/env bash
#
# TOP-LEVEL PLATFORM INCLUDE
#
# Darwin is Apple Inc.'s code name for the underlying operating system of Mac OS X
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Requires: find stat
__fileModificationTimes() {
  local directory="$1" && shift
  find "$directory" -type f "$@" -exec stat -f '%m %N' {} \;
}

# Requires: xargs sed
__xargsSedInPlaceReplace() {
  xargs sed -i '' "$@"
}

# Requires: printf
__urlBinary() {
  printf "%s\n" "open"
}

# Argument: date - String. Required.
# Argument: format - String. Required.
# Requires: date
__dateToFormat() {
  date -u -jf '%F %T' "$1 00:00:00" "+$2" 2>/dev/null
}

# Requires: date
# Argument: value - Integer. Required.
# Argument: format - String. Required.
# Argument: isUTC - Boolean. Optional. Defaults to `true`.
__dateFromTimestamp() {
  local a=(-r "$1" "+$2")
  ! "${3:-true}" || a=(-u "${a[@]}")
  date "${a[@]}"
}

# Requires: mv
__linkRename() {
  mv -fh "$@"
}

# Requires: readlink
__fileRealPath() {
  readlink -f -n "$@"
}

# Requires: hostname
__hostname() {
  hostname -f
}

# Mac OS X has python3 installed by default so this should not be an issue
__timestamp() {
  python3 -c 'import time; print(int(time.time() * 1000))'
}

__testPlatformName() {
  printf -- "%s\n" "darwin"
}

__decorateBigBinary() {
  printf "%s\n" "figlet"
}

__pcregrep() {
  pcre2grep "$@"
}

__pcregrepBinary() {
  printf "%s\n" pcre2grep
}

# Requires: printf
__packageManagerDefault() {
  local manager managers=(port brew)
  for manager in "${managers[@]}"; do
    if executableExists "$manager"; then
      printf "%s\n" "$manager"
      return 0
    fi
  done
  manager="${1-}"
  [ -n "$manager" ] || manager="${managers[0]}"
  printf "%s\n" "$manager"
}

__groupID() {
  grep -e "^$(quoteGrepPattern "$1"):" /etc/group | cut -d: -f3
}
