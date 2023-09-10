#!/usr/bin/env bash
#
# Build a PHP Application
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail
# set -x # Debugging

cd "$(dirname "${BASH_SOURCE[0]}")/.."

# Customize for your app environment
extraEnvs=(SMTP_URL MAIL_SUPPORT MAIL_FROM TESTING_EMAIL TESTING_EMAIL_IMAP DSN)
# Customize for your app files
files=(bin src etc public)

# Copy of bin/build/build-setup.sh in your project
./bin/build-setup.sh
./bin/build/pipeline/php-build.sh "${extraEnvs[@]}" -- "${files[@]}"

# Artifacts: .build.env app.tar.gz
