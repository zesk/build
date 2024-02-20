#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh pipeline.sh
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

#
#
#
urlMatchesLocalFileSize() {
  local url file remoteSize localSize

  url=$1
  file=$2
  if [ -f "$file" ]; then
    return $errorEnvironment
  fi
  localSize=$(du -b "$file")
  localSize=$((localSize + 0))
  remoteSize=$(urlContentLength "$url")
  [ "$localSize" -eq "$remoteSize" ]
}

urlContentLength() {
  local url remoteSize

  while [ $# -gt 0 ]; do
    url=$1
    if ! remoteSize=$(curl -s -I "$url" | grep -i Content-Length | awk '{ print $2 }'); then
      consoleError "Fetching \"$url\" failed"
      return "$errorEnvironment"
    fi
    printf "%d\n" $((remoteSize + 0))
    shift
  done
}

hostIPList() {
  if [ "$OS_TYPE" = Linux ]; then
    ifconfig | grep 'inet addr:' | cut -f 2 -d : | cut -f 1 -d ' '
  elif [ "$OS_TYPE" = FreeBSD ]; then
    ifconfig | grep 'inet ' | cut -f 2 -d ' '
  else
    consoleError "hostIPList Unsupported OS_TYPE \"$OS_TYPE\"" 1>&2
    return "$errorEnvironment"
  fi
}

hostTTFB() {
  curl -L -s -o /dev/null -w "Connect: %{time_connect}\nTTFB: %{time_starttransfer}\nTotal: %{time_total} \n" "$@"
}

_watchFile() {
  tail -F "$1" | prefixLines "$(clearLine)$(consoleGreen)" | sed 's/^.*--  //g'
}

#
# Usage: {fn} siteURL
# Uses wget to fetch a site, convert it to HTML nad rewrite it for local consumption
# SIte is stored in a directory called `host` for the URL requested
#
websiteScrape() {
  local logFile pid progressFile progressPid

  if ! logFile=$(buildQuietLog "${FUNCNAME[0]}.$$.log") || ! progressFile=$(buildQuietLog "${FUNCNAME[0]}.$$.progress.log"); then
    _websiteScrape "$errorEnvironment" "buildQuietLog failed" || return $?
  fi

  if ! whichApt wget wget; then
    _websiteScrape "$errorEnvironment" "No wget installed" || return $?
  fi

  if
    ! wget -e robots=off \
      -R zip,exe \
      --no-check-certificate \
      --user-agent="Mozilla/4.0 (compatible; MSIE 10.0; Windows NT 5.1)" \
      -r --level=5 -t 10 --random-wait --force-directories --html-extension \
      --no-parent --convert-links --backup-converted --page-requisites "$@" 2>&1 | tee "$logFile" | grep -E '^--' >"$progressFile" &
  then
    _websiteScrape "$errorEnvironment" "wget failed" || return $?
  fi
  pid=$!
  if ! _watchFile "$progressFile" 2>/dev/null & then
    kill -9 "$pid" || :
    _websiteScrape "$errorEnvironment" "_watchFile failed" || return $?
  fi
  progressPid=$!
  while kill -0 "$pid" 2>/dev/null; do
    kill -0 "$progressPid" || :
    sleep 1
  done
  kill -HUP "$progressPid" 2>/dev/null || :
}
_websiteScrape() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
