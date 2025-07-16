#!/usr/bin/env bash
#
# xdebug tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Environment: XDEBUG_ENABLED

__xdebugInstallationArtifact() {
  printf -- "%s\n" "/etc/xdebug-enabled"
}

# Install the xdebug PHP Debugger
xdebugInstall() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local iniFile

  __catchEnvironment "$handler" phpInstall php-pear || return $?
  __catchEnvironment "$handler" packageWhich pear php-pear || return $?
  __catchEnvironment "$handler" packageWhich phpize php-dev || return $?
  usageRequireBinary "$handler" pear pecl || return $?

  iniFile=$(__catchEnvironment "$handler" phpIniFile) || return $?
  [ -f "$iniFile" ] || __throwEnvironment "$handler" "php.ini not found $(decorate file "$iniFile")" || return $?

  statusMessage decorate info "Setting php ini path to $(decorate file "$iniFile")"
  __catchEnvironment "$handler" pear config-set php_ini "$iniFile" || return $?

  statusMessage decorate info "Installing xdebug ..."
  __catchEnvironment "$handler" pecl channel-update pecl.php.net || return $?
  muzzle __catchEnvironment "$handler" pecl install xdebug || return $?

  artifact=$(__xdebugInstallationArtifact)
  date | muzzle __catchEnvironment "$handler" tee "$artifact" || return $?
}
_xdebugInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__xdebug_Require() {
  artifact=$(__xdebugInstallationArtifact)
  [ -f "$artifact" ] || __throwArgument "$1" "xdebug is not installed on this system" || return $?
}

# Enable Xdebug on systems that have it
# Environment: XDEBUG_ENABLED
xdebugEnable() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return 0
  __xdebug_Require "$handler" || return $?
  export XDEBUG_ENABLED=true
  decorate success "xdebug debugging $(decorate value "[ENABLED]")"
}
_xdebugEnable() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Disable Xdebug on systems that have it
# Environment: XDEBUG_ENABLED
xdebugDisable() {
  local handler="_${FUNCNAME[0]}"

  [ $# -eq 0 ] || __help --only "$handler" "$@" || return 0
  __xdebug_Require "$handler" || return $?
  export XDEBUG_ENABLED
  unset XDEBUG_ENABLED
  decorate info "xdebug debugging $(decorate value "(disabled)")"
}
_xdebugDisable() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
