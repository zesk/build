#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Zesk Build tools
#
# Test: o test/tools/self-tests.sh
# Docs: o docs/_templates/tools/self.md

# Installs `install-bin-build.sh` the first time in a new project, and modifies it to work.
# Argument: path - Optional. Directory. Path to install the binary. Default is `bin`.
# Argument: applicationHome - Optional. Directory. Path to the application home directory. Default is current directory.
# Usage: {fn} [ path [ applicationHome ] ]
installInstallBuild() {
  local usage="_${FUNCNAME[0]}"
  local argument
  local path applicationHome temp relTop replace
  local installBinName target url

  export BUILD_INSTALL_URL

  __usageEnvironment "$usage" whichApt curl curl || return $?
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_INSTALL_URL || return $?
  urlParse "$BUILD_INSTALL_URL" >/dev/null || __failEnvironment "$usage" "BUILD_INSTALL_URL ($BUILD_INSTALL_URL) is not a valid URL" || return $?

  url="${BUILD_INSTALL_URL}"
  installBinName="install-bin-build.sh"
  path=
  applicationHome=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        if [ -z "$path" ]; then
          path=$(usageArgumentDirectory "$usage" "path" "$1") || return $?
        elif [ -z "$applicationHome" ]; then
          applicationHome=$(usageArgumentDirectory "$usage" "applicationHome" "$1") || return $?
        else
          __failArgument "$usage" "unknown argument: $(consoleValue "$argument")" || return $?
        fi
        ;;
    esac
    shift || :
  done
  [ -n "$applicationHome" ] || applicationHome="$(pwd)" || __failEnvironment "$usage" "pwd failed" || return $?
  [ -n "$path" ] || path="$applicationHome/bin"
  if ! isAbsolutePath "$path"; then
    temp=$(realPath "$path") || __failEnvironment "Unable to get realpath for path $path" || return $?
    path="$temp"
  fi
  if ! isAbsolutePath "$applicationHome"; then
    temp=$(realPath "$applicationHome") || __failEnvironment "Unable to get realpath for applicationHome $applicationHome" || return $?
    applicationHome="$temp"
  fi
  if [ "${path#$applicationHome}" = "$path" ]; then
    __failArgument "Path ($path) is not within applicationHome ($applicationHome)" || return $?
  fi
  relTop="${path#$applicationHome}"
  if [ -z "$relTop" ]; then
    relTop=.
  else
    relTop=$(printf "%s\n" "$relTop" | sed -e 's/[^/]//g' -e 's/\//..\//g')
    relTop="${relTop%/}"
  fi
  temp="$path/$installBinName.downloaded.$$"
  if curl -o "$temp" "$url"; then
    replace=$(quoteSedPattern "relTop=$relTop")
    target="$path/$installBin"
    if ! sed -e "s/^relTop=.*/$replace/" <"$temp" >"$target"; then
      rm -rf "$temp"
      __failEnvironment "$usage" "Unable to write $target" || return $?
    fi
    rm -rf "$temp" || :
    printf "%s %s\n" "$(consoleSuccess "Installed")" "$(consoleCode "$target")"
    return 0
  else
    rm -rf "$temp" || :
    __failEnvironment "$usage" "Unable to download $(consoleCode "$url")" || return $?
  fi
}
