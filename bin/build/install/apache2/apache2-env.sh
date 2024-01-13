#!/usr/bin/env bash
#
# Default apache2 environment variable extensions
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# FCGI Apache
export PHP_FPM_SOCKET=/run/php/php8.1-fpm.sock

#
# Please keep in mind that PHP-FPM (at the time of writing, February 2018) uses a prefork model, namely each of its worker processes can handle one connection at the time
# By default mod_proxy (configured with enablereuse=on) allows a connection pool of ThreadsPerChild connections to the backend
# for each httpd process when using a threaded mpm (like worker or event), so the following use cases should be taken into account:
#
# Under HTTP/1.1 load it will likely cause the creation of up to MaxRequestWorkers connections to the FCGI backend.
# Under HTTP/2 load, due to how mod_http2 is implemented, there are additional h2 worker threads that may force the creation of other backend connections. The overall count of connections in the pools may raise to more than MaxRequestWorkers.
#
# The maximum number of PHP-FPM worker processes needs to be configured wisely, since there is the chance that they will all end up "busy" handling idle persistent connections, without any room for new ones to be established, and the end user experience will be a pile of HTTP request timeouts.
#

# for pid in $(ps aux | grep apache2 | awk '{print $2}'); do processMemoryUsage $pid; done
# - throw in a spreadsheet and MIN/MAX RSS columns
# Apache2 Memory Usage sample (RSS) KILOBYTES (2024)
export APACHE2_MEMORY_USAGE_UBUNTU22_MIN=10484
export APACHE2_MEMORY_USAGE_UBUNTU22_MAX=1085436
# for pid in $(ps aux | grep php | awk '{print $2}'); do processMemoryUsage $pid; done
# - throw in a spreadsheet and MIN/MAX RSS columns
# PHP-FPM Memory Usage sample (RSS) KILOBYTES (2024)
export PHP_FPM_MEMORY_USAGE_UBUNTU22_MIN=10712
export PHP_FPM_MEMORY_USAGE_UBUNTU22_MAX=35828

PHP_FPM_MEMORY_USAGE_UBUNTU22=$(((PHP_FPM_MEMORY_USAGE_UBUNTU22_MIN + PHP_FPM_MEMORY_USAGE_UBUNTU22_MAX) / 2))

export SYSTEM_MEMORY
export APACHE_LOG_PATH

# Users and Groups
if [ -z "$APACHE_RUN_USER" ]; then
  printf "%s: %s\n" "Need environment defined prior to running:" "APACHE_RUN_USER" 1>&2
  exit 1
fi

APACHE_LOG_PATH="$(grep -E "^$APACHE_RUN_USER:" /etc/passwd | cut -d : -f 6)"
if [ -z "$APACHE_LOG_PATH" ]; then
  printf "%s: %s\n" "Unable to fetch home directory for user:" "$APACHE_RUN_USER" 1>&2
  exit 1
fi
APACHE_LOG_PATH="${APACHE_LOG_PATH%%/}/log/apache2"

# Unit is BYTES
SYSTEM_MEMORY=$(("$(grep -i 'MemTotal' /proc/meminfo | awk '{ print $2 }')" * 1024))
# Assume PHP server (mostly) and low percentage of non-FPM requests
SYSTEM_MEMORY_KILOBYTES=$((SYSTEM_MEMORY / 1024))

export APACHE_THREADS_PER_CHILD=64

# Max children to fill memory
export PHP_FPM_MAX_CHILDREN=$((SYSTEM_MEMORY_KILOBYTES / ((APACHE2_MEMORY_USAGE_UBUNTU22_MAX / APACHE_THREADS_PER_CHILD) + PHP_FPM_MEMORY_USAGE_UBUNTU22)))

if [ "$PHP_FPM_MAX_CHILDREN" -lt 16 ]; then
  printf "%s: %s\n" "Not enough system memory:" "$SYSTEM_MEMORY" 1>&2
  exit 1
fi

# Start, by default is (max - min) / 2
export PHP_FPM_START_SERVERS=$((PHP_FPM_MAX_CHILDREN / 2))
export PHP_FPM_MIN_SPARE_SERVERS=$((PHP_FPM_MAX_CHILDREN / 8))
export PHP_FPM_MAX_SPARE_SERVERS=$((PHP_FPM_MIN_SPARE_SERVERS * 2))

# Apache <Proxy reuse=... /> setting
export PHP_FPM_PROXY_MAX=$((PHP_FPM_MAX_CHILDREN / 2))

# APACHE_MAX_REQUEST_WORKERS restricts the total number of threads that will be available to serve clients
export APACHE_MAX_REQUEST_WORKERS=$PHP_FPM_MAX_CHILDREN
# APACHE_THREADS_PER_CHILD This directive sets the number of threads created by each child process.
# The child creates these threads at startup and never creates more.

# APACHE_SERVER_LIMIT
# With event, increase this directive if the process number defined by your MaxRequestWorkers and ThreadsPerChild settings, plus the number of gracefully shutting down processes, is more than 16 server processes (default).
export APACHE_SERVER_LIMIT=$((PHP_FPM_MAX_CHILDREN * 2 / APACHE_THREADS_PER_CHILD))

# this is currently 8x the threads
# Upper limit on configurable number of processes
# Start this many
export APACHE_START_SERVERS=$((APACHE_SERVER_LIMIT / 2))

export APACHE_MIN_SPARE_THREADS=$APACHE_THREADS_PER_CHILD
export APACHE_MAX_SPARE_THREADS=$((APACHE_MIN_SPARE_THREADS * 2))
