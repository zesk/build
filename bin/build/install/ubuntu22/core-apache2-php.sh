#!/usr/bin/env bash
#
# Install php apache2 mariadb aws on
#
# - Ubuntu 22
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y dirmngr ca-certificates software-properties-common apt-transport-https
add-apt-repository ppa:ondrej/apache2 -y
apt-get update
apt-get dist-upgrade -y

installs=()
installs+=(daemontools daemontools-run svtools)
installs+=(apache2 libapache2-mod-fcgid)
installs+=(cronolog zip)
installs+=(mariadb-client)
installs+=(php-fpm php-gd php-curl php-mysql)
installs+=(awscli)
installs+=(ntpdate)

apt-get install -y "${installs[@]}"
