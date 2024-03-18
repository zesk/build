#!/usr/bin/env bash
#
# aws-cli.sh
#
# Depends: apt
#
# aws cli install
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

# shellcheck source=/dev/null
. ./bin/build/env/APACHE_HOME.sh

_installApacheConfigurationUsage() {
  usageDocument ./bin/build/install/lib/apache2.sh installApacheConfiguration "$@"
  return $?
}

# Configures Apache
#
#                      ▗▖         ▄▄▖
#                      ▐▌        ▐▀▀█▖
#   ▟██▖▐▙█▙  ▟██▖ ▟██▖▐▙██▖ ▟█▙    ▐▌
#   ▘▄▟▌▐▛ ▜▌ ▘▄▟▌▐▛  ▘▐▛ ▐▌▐▙▄▟▌  ▗▛
#  ▗█▀▜▌▐▌ ▐▌▗█▀▜▌▐▌   ▐▌ ▐▌▐▛▀▀▘ ▗▛
#  ▐▙▄█▌▐█▄█▘▐▙▄█▌▝█▄▄▌▐▌ ▐▌▝█▄▄▌▗█▄▄▖
#   ▀▀▝▘▐▌▀▘  ▀▀▝▘ ▝▀▀ ▝▘ ▝▘ ▝▀▀ ▝▀▀▀▘
#       ▐▌
#
# Usage: {fn} applicationsHome [ --site-remove siteName ]
# Argument: applicationsHome - Home directory for the application. User is derived from the owner.
# Argument: --site-remove siteName - Explicitly disable site
# Environment: APPLICATION_USER - Automatically defined and used to map `.conf` files
# Environment: APPLICATION_PATH - Automatically defined and used to map `.conf` files
# Environment: APPLICATION_NAME - Automatically defined and used to map `.conf` files
installApacheConfiguration() {
  local conf applicationsHome apacheNeedsRestart appUser
  local oldSites
  local site sites

  local vhosts

  applicationsHome="$1"
  if [ ! -d "$applicationsHome" ]; then
    _installApacheConfigurationUsage "$errorEnvironment" "$applicationsHome is not a directory" 1>&2
    return $?
  fi
  shift || return "$errorArgument"
  appUser=$(fileOwner "$applicationsHome")
  if [ -z "$APPLICATION_USER" ]; then
    _installApacheConfigurationUsage "$errorEnvironment" "$appUser is empty" 1>&2
  fi
  consoleNotice "Configuring Apache in $applicationsHome as user $appUser"
  oldSites=()
  while [ $# -gt 0 ]; do
    case $1 in
      --site-remove)
        oldSites+=("$1")
        ;;
      *)
        _installApacheConfigurationUsage "$errorArgument" "Unknown argument $1"
        return $?
        ;;
    esac
  done
  vhosts=$(mktemp)
  find "$applicationsHome" -type f -name '*.conf' -path '*/.webApplication/vhost/*' >"$vhosts"
  while read -r vhostFile; do
    sites+=("$vhostFile")
  done <"$vhosts"
  rm "$vhosts"

  sectionHeading "$APACHE_HOME/mods-available"
  # PHP_FPM_PROXY_MAX PHP_FPM_SOCKET
  if copyFileChanged --map  "./bin/build/install/apache2/php8.1-fpm.conf" "$APACHE_HOME/conf-available/php8.1-fpm.conf"; then
    apacheNeedsRestart=1
  fi

  local apacheConfigurationEnabled=(php8.1-fpm other-vhosts-access-log)
  local apacheConfigurationDisabled=(security localized-error-pages serve-cgi-bin charset)

  for conf in "${apacheConfigurationDisabled[@]}"; do
    if ! a2disconf "$conf" 2>&1 | grep -q already; then
      consoleWarning "Disabling apache configuration $conf"
      apacheNeedsRestart=1
    fi
  done
  for conf in "${apacheConfigurationEnabled[@]}"; do
    if ! a2enconf "$conf" 2>&1 | grep -q already; then
      consoleNotice "Enabling apache configuration $conf"
      apacheNeedsRestart=1
    fi
  done
  local apacheModulesDisabled=(mpm_worker)
  local apacheModulesEnabled=(mpm_event proxy_fcgi proxy alias deflate dir
    env expires filter headers mime negotiation rewrite setenvif
    status)
  for mod in "${apacheModulesDisabled[@]}"; do
    if ! a2dismod "$mod" 2>&1 | grep -q already; then
      consoleWarning "Disabling apache module $mod"
      apacheNeedsRestart=1
    fi
  done
  for mod in "${apacheModulesEnabled[@]}"; do
    if ! a2enmod "$mod" 2>&1 | grep -q already; then
      consoleNotice "Enabling apache module $mod"
      apacheNeedsRestart=1
    fi
  done
  sectionHeading "$APACHE_HOME/sites-available"
  if [ ${#oldSites[@]} -gt 0 ]; then
    for site in "${oldSites[@]}"; do
      a2dissite "$site" 2>/dev/null || :
    done
  fi
  if copyFileChanged "./bin/build/install/apache2/apache2.conf" /etc/apache2/apache2.conf; then
    apacheNeedsRestart=1
  fi
  (
    export APPLICATION_PATH
    export APPLICATION_NAME
    export APPLICATION_USER
    APPLICATION_USER=$appUser
    for site in "${sites[@]}"; do
      APPLICATION_PATH="$(dirname "$(dirname "$(dirname "$site")")")"
      APPLICATION_NAME="$(basename "$APPLICATION_PATH")"
      siteName="$(basename "$site")"
      siteName="${siteName%%.conf}"
      [ -L "$APACHE_HOME/sites-available/$siteName.conf" ] && rm "$APACHE_HOME/sites-available/$siteName.conf"
      if copyFileChanged --map "$site" "$APACHE_HOME/sites-available/$siteName.conf"; then
        apacheNeedsRestart=1
        consoleNotice "$siteName ($site)"
      else
        consoleInfo "$siteName"
      fi
      a2ensite "$siteName" | grep -v already || :
    done
  )
  local envName=envvars-webApplication
  if copyFileChanged --map --escalate "./bin/build/install/lib/$envName" /etc/apache2/$envName; then
    apacheNeedsRestart=1
  fi
  if ! grep -q /etc/apache2/$envName /etc/apache2/envvars; then
    local me=rulerup.sh
    grep -v conversion2 /etc/apache2/envvars | grep -v "$me" >/etc/apache2/envvars.cleaned
    cp /etc/apache2/envvars.cleaned /etc/apache2/envvars
    rm /etc/apache2/envvars.cleaned
    printf "\n# Automatically installed by%s\n\n# shellcheck source=/dev/null\n. /etc/apache2/%s\n" "$me" "$envName" >>/etc/apache2/envvars
    echo Patched /etc/apache2/envvars
    apacheNeedsRestart=1
  fi
  if test "$apacheNeedsRestart"; then
    date +%s >"$APACHE_HOME/restartRequested"
  fi
}
